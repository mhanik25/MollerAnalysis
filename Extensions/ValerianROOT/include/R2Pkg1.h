/********************************************
 \author <b>Programmer:<\b> Valerie Gray
 \author <b>Assisted By:<\b>

\brief <b>Purpose:</b> This is header file for
  the octant number of R2 package 1

  Everything is a element to the run

\date <b>Date:</b> 05-14-2014
\date <b>Modified:</b>

\note <b>Entry Conditions:</b> none

********************************************/

#ifndef R2PKG1_HH_
#define R2PKG1_HH_

//ROOT includes
#include <TROOT.h>
#include <TString.h>

//standard includes
#include <vector>

//QTOR current Structure
struct MyR2Pkg1_t
{
  Int_t octant;  //the octant value
};

//Function to read in the octatnnumber
//information for a given run number

std::vector<MyR2Pkg1_t> GetR2Pkg1(Int_t run);

#endif /* R2PKG1_HH_ */
