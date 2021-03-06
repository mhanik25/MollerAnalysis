/********************************************
 \author <b>Programmer:</b> Valerie Gray
 \author <b>Assisted By:</b>

 \brief <b>Purpose:</b> This file gets the Beam
 position X information

 \date <b>Date:</b> 05-15-2014
 \date <b>Modified:</b> 05-25-2014

 \note <b>Entry Conditions:</b>
 - run number
 ********************************************/

//ROOT includes
#include <TString.h>
#include <TSystem.h>

//standard include
#include <fstream>
#include <vector>
#include <iostream>
#include <cstdlib>

//Valerian Root include
#include "BeamPositionX.h"

//Read in the beam position X information for a given run number

std::vector<MyBeamPositionX_t> GetBeamPositionX(Int_t run)
{
  TString filename = TString(gSystem->Getenv("VALERIAN")) + Form("/data/pass")
                     + TString(gSystem->Getenv("PASS"))
                     + Form("/BeamPositionQ2X/BeamPositionQ2X_%d.txt", run);

  // An input stream that contains run list
  ifstream beampos_data;
  beampos_data.open(filename, std::ios::in);
  //this has an input mode of std::ios::in
  //and be keyboard, or file input, and read only

  // A vector that will contain all the runs
  // To make organization for now easier, we will define a special
  // structure called MyRun_t which will include what we need
  std::vector<MyBeamPositionX_t> beampos;
  MyBeamPositionX_t tmp;

  /*****************************
   Summary of what I will be doing:
   - I have defined a vector of MyBLAH_t (BLAH) and just one element
   of this type (tmp)
   - I read in the file number by number filling the tmp element
   - the tmp element is a "sub"-element of the vector angle (for
   the run run), so push that into the BLAH vector.
   - then celebrate when it works!
   *****************************/

  if (beampos_data.is_open())
  {
    //Get the information from the text file I need to process
    //while I...
    while (beampos_data >> tmp.R3package  //read in the pkg
           && beampos_data >> tmp.chi2  //read in the chi value
           && beampos_data >> tmp.slope  //read in the slope
           && beampos_data >> tmp.Error  //read in the Error on the slope
           && !beampos_data.eof())  // am not at the end of the file
    {
      beampos.push_back(tmp);
      //this put all this information in the BLAH
      //vector for the run
    }

    beampos_data.close();
  } else
  {
    //debugging
    if (atoi(gSystem->Getenv("DEBUG")) >= 3)
    {
      std::cout << "Beam X File " << run << " not open" << std::endl;
    }
    tmp.R3package = -1e6;
    tmp.chi2 = -1e6;
    tmp.slope = -1e6;
    tmp.Error = -1e6;
    beampos.push_back(tmp);
  }

  return beampos;
}

