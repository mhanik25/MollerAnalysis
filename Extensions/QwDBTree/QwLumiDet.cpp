#include <Riostream.h>
#include <TSQLStatement.h>
#include <TSQLServer.h>
#include "QwDetector.h"
#include "QwLumiDet.h"

/* Constructor for QwLumiDet. */
QwLumiDet::QwLumiDet(TString name, TString id, TString type, vector<Int_t> runlets, TSQLServer* db_pointer, Bool_t ravg, Bool_t savg, Bool_t wavg):
    QwDetector(name, id, type, runlets, db_pointer, ravg, savg, wavg) {}

/*
 * Method to generate a query for lumi detectors. It uses the temporary tables
 * generated by QwRunlet::fill(), depending on which regession scheme is being
 * used. There are also similar methods for the lumins and the beam detectors,
 * but that join their specific table from the database.
 */
TString QwLumiDet::query(void) {
    /* table holds the temporary table to query. */
    TString table;
    /* Figure out which table to use, based on regression type. */
    if(reg_type == "offoff") table = "temp_table_unreg_offoff";
    else if(reg_type == "on_5+1") table = "temp_table_on_5p1";
    else if(reg_type == "off") table = "temp_table_unreg_on";
    else table = "temp_table_" + reg_type;

    /* query holds the actualy query as a TString */
    TString query;
    query = "SELECT\n";
    /*
     * If run averaging is enabled, take the weighted average.
     * 
     * FIXME: Change the weighting scheme to be weighted by qwk_mdallbars for
     * all variables. Currently it is doing a error weighted average.
     *
     * value weight: n * mdallbars_width^(-2)
     * error weight: mdallbars_width/sqrt(n)
     */
    if(runavg || slugavg || wienavg) {
        if(runavg) {
            query += "DISTINCT run_number\n";
        }
        if(slugavg) {
            query += "DISTINCT slug\n";
        }
        if(wienavg) {
            query += "DISTINCT wien_slug\n";
        }
        /* Changed to number weighted avg. FIXME. */
        if(measurement_id == "a" || measurement_id == "d") {
            /* Changed to number weighted avg. FIXME. */
            //query += ", SUM(lumi_data.value*SQRT(n))/SUM(SQRT(n))*1e6\n";
            query += ", SUM(lumi_data.value/POW(main_det.error,2))/SUM(POW(main_det.error,-2))*1e6\n";
            //query += ", SQRT(1/SUM(1/POWER(lumi_data.error,2)))*1e6\n";
            query += ", SUM(lumi_data.error/POW(main_det.error,2))/SUM(POW(main_det.error,-2))*1e6\n";
        }
        else {
            //query += ", SUM(lumi_data.value*(n))/SUM(SQRT(n))\n";
            query += ", SUM(lumi_data.value/POW(main_det.error,2))/SUM(POW(main_det.error,-2))\n";
            //query += ", SQRT(1/SUM(1/POWER(lumi_data.error,2)))\n";
            query += ", SUM(lumi_data.error/POW(main_det.error,2))/SUM(POW(main_det.error,-2))\n";
        }
        query += ", SUM(lumi_data.n)\n";
    }
    /* Otherwise, grab runlets with asymmetries and diffs in ppm. */
    else {
        query += "DISTINCT runlet_id\n";
        if(measurement_id == "a" || measurement_id == "d") {
            /* Convert values of asymmetries to ppm */
            query += ", lumi_data.value*1e6\n";
            query += ", lumi_data.error*1e6\n";
        }
        else {
            query += ", lumi_data.value\n";
            query += ", lumi_data.error\n";
        }
        query += ", lumi_data.n\n";
    }
    query += "FROM " + table + "\n";

    /* Join the temorary table to the lumi detector table */
    query += "JOIN lumi_data ON " + table+ ".analysis_id = lumi_data.analysis_id\n";
    /* Join the detector name to the detector number. */
    query += "JOIN lumi_detector ON lumi_data.lumi_detector_id = lumi_detector.lumi_detector_id\n";
    /* If run avg, join the main detector on for error weighting in the same manner as above. */
    if(runavg || slugavg || wienavg) {
        query += "JOIN md_data AS main_det ON " + table+ ".analysis_id = main_det.analysis_id\n";
        query += "JOIN main_detector AS main_detector_label ON main_det.main_detector_id = main_detector_label.main_detector_id\n";
    }

    /*
     * lumi detector level cuts. Runlet level cuts are made when generating
     * temporary tables
     */
    query += "WHERE lumi_data.subblock = 0\n";
    query += "AND lumi_data.measurement_type_id = \"" + measurement_id + "\"\n";
    query += "AND lumi_detector.quantity = \"" + detector_name + "\"\n";
    query += "AND lumi_data.n > 0\n";

    /* Organize the data. */
    if(runavg) query += "GROUP BY run_number;\n";
    else if(slugavg) query += "GROUP BY slug;\n";
    else if(wienavg) query += "GROUP BY wien_slug;\n";
    else query += "ORDER BY runlet_id;\n";

    return query;
}
