#include "headers.h"
#include "TSpectrum.h"
#include "TApplication.h"
#include "TDirectory.h"
#include "TSystem.h"
#include "Riostream.h"
#include "TStyle.h"

Bool_t FileSearch(TString, TChain*);
void   LoadRootFile(TString, TChain*);

Int_t run_number;

Int_t main(Int_t argc, Char_t *argv[])
{

  TString filename;

  TSpectrum *spectrum = new TSpectrum(3,1);

//   TApplication theApp("App", &argc, argv);
  TCanvas *canvas = new TCanvas("canvas", "canvas", 5);

  std::fstream pedestal;
  std::fstream pedestal_run;


  run_number = atoi(argv[1]);

  pedestal.open("pedestal/ramp.pedestal", std::ios_base::out | std::ios_base::app);
  pedestal_run.open(Form("pedestal/ramp_%i.pedestal", run_number), std::ios_base::out | std::ios_base::app);

  if(!pedestal.is_open()){
    std::cout << "Error opening output file." << std::endl;
    exit(1);
  }

//   filename = Form("slug%i.root", run_number);
//   filename = Form("QwPass5beta_%i*.trees.root", run_number);
  filename = Form("QwPass*_%i*.trees.root", run_number);
//   filename = Form("bmod_tree_%i.root", run_number);

  TChain *mps_tree = new TChain("Mps_Tree");

  LoadRootFile(filename, mps_tree);

  std::cout << "Processing...." << std::endl;

  TH1F *histo = new TH1F("histo","histo", 2000, -500.,4200);
  canvas->cd();
  gPad->SetLogy();

  mps_tree->Draw("ramp>>histo","ErrorFlag == 0x4018080 || ErrorFlag == 0");
  histo = (TH1F *)gDirectory->Get("histo");

  if(histo->GetEntries() < 1){
    std::cout << "Null histogram: cancelling." << std::endl;
    exit(1);
  }

  histo->Draw();

  std::cout << "Finding peaks...." << std::endl;

  Int_t nfound = spectrum->Search(histo, 2, "", 0.05);
  Float_t *xposition = spectrum->GetPositionX();

  std::cout << "Found some peaks: " << nfound << std::endl;
  for(Int_t i = 0; i < nfound; i++){
    std::cout << "peak:\t" << xposition[i] << std::endl;
  }

  // If there is only one peak switch the values
  Float_t temp = 0;

  if(nfound == 1){
    std::cout << "Only one peak found: switching printing position." << std::endl;

    temp = xposition[0];
    xposition[0] = xposition[1];
    xposition[1] = temp;
  }

  // If there are more than 2 peaks something is likely wrong with the run.

  if(nfound > 2){
    std::cout << "There was a problem with this run: Too many peaks found." << std::endl;
    canvas->SaveAs(Form("pedestal/macro/failed_ramp_pedestal_%i.C", run_number));
    exit(1);
  }

  if(xposition[0] > xposition[1]){

    temp = xposition[0];
    xposition[0] = xposition[1];
    xposition[1] = temp;
  }

//   pedestal << run_number   << "\t" 
// 	   << xposition[0] << "\t" 
// 	   << xposition[1] << std::endl;
//   pedestal_run << run_number   << "\t" 
// 	       << xposition[0] << "\t" 
// 	       << xposition[1] << std::endl;
  
//   pedestal.close();
//   pedestal_run.close();

  canvas->SaveAs(Form("pedestal/macro/ramp_pedestal_%i.C", run_number));

  std::cout << "Finished" << std::endl;

//   theApp.Run();

  return 0;
}

Bool_t FileSearch(TString filename, TChain *chain)
{

  TString file_directory;
  Bool_t c_status = kFALSE;

  file_directory = gSystem->Getenv("QW_ROOTFILES");

  c_status = chain->Add(Form("%s/%s",file_directory.Data(), filename.Data()));
  std::cout << "Trying to open :: "
            << Form("%s/%s",file_directory.Data(), filename.Data())
            << std::endl;

  if(c_status){
    TString chain_name = chain->GetName();
    TObjArray *fileElements = chain->GetListOfFiles();
    TIter next(fileElements);
    TChainElement *chain_element = NULL;

    while((chain_element = (TChainElement*)next())){
      std::cout << "Adding :: "
		<< filename
		<< " to data chain"
		<< std::endl;
    }
  } 
    return c_status;

}

void LoadRootFile(TString filename, TChain *tree)
{
  Bool_t found = FileSearch(filename, tree);
  
  if(!found){
    filename = Form("Qweak_%d.*.trees.root", run_number);
    found = FileSearch(filename, tree);
    std::cerr << "Couldn't find QwPass<#>_*.trees.root trying "
	      << filename
	      << std::endl;
    if(!found){
      std::cerr << "Unable to locate requested file :: "
		<< filename
		<< std::endl;
      exit(1);
    }
  }
}
