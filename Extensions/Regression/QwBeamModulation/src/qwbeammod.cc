#include "headers.h"
#include "QwModulation.hh"

Int_t main(Int_t argc, Char_t *argv[])
{

  TString filename;

  TChain *mps_tree = new TChain("Mps_Tree");

  QwModulation *modulation = new QwModulation(mps_tree);

  modulation->output = gSystem->Getenv("BMOD_OUT");
  if(!gSystem->OpenDirectory(modulation->output)){
    modulation->PrintError("Cannot open output directory.\n");
    modulation->PrintError("Directory needs to be set as env variable and contain:\n\t slopes/ \n\t regression/ \n\t diagnostics/ \n\t rootfiles/"); 
    exit(1);
  }

  modulation->GetOptions(argv);

  if( !(modulation->fRunNumberSet) ){
    modulation->PrintError("Error Loading:  no run number specified");
    exit(1);
  }

  // This is the default filename format.  If doing a segment analysis
  // it is changes in QwModulation::FileSearch()

  //  filename = Form("QwPass*_%d*.trees.root", modulation->run_number);

  filename = Form("%s_%d*.trees.root", modulation->fFileStem.Data(), modulation->run_number);
  modulation->LoadRootFile(filename, mps_tree);
  modulation->SetFileName(filename);
  modulation->SetupMpsBranchAddress();

  std::cout << "Setting Branch Addresses of detectors/monitors" << std::endl;

  modulation->ReadConfig("");

  modulation->Scan();
//   modulation->fNumberEvents = mps_tree->GetEntries();

  std::cout << "Finished scanning data -- building relevant data vectors" << std::endl;
  modulation->BuildDetectorData();
  modulation->BuildMonitorData();
  modulation->BuildCoilData();
  modulation->BuildDetectorSlopeVector();
  modulation->BuildMonitorSlopeVector();

  std::cout << "Starting to pilfer the data" << std::endl;
  modulation->PilferData();
  modulation->BuildDetectorAvSlope();
  modulation->BuildMonitorAvSlope();
  modulation->CalculateWeightedSlope();
  modulation->MatrixFill();
  
  std::cout << "Closing Mps_Tree" << std::endl;
  delete mps_tree;
  modulation->Clean();

  std::cout << "Creating Hel_Tree chain now." << std::endl;
  TChain *hel_tree = new TChain("Hel_Tree");
  modulation->Init(hel_tree);

  filename = Form("QwPass*_%d*.trees.root", modulation->run_number);
  modulation->LoadRootFile(filename, hel_tree);
  modulation->SetFileName(filename);

  std::cout << "Setting up Hel_Tree" << std::endl;
  modulation->SetupHelBranchAddress();
  std::cout << "Calculating Corrections" << std::endl;
  modulation->ComputeAsymmetryCorrections();

  return 0;

}
