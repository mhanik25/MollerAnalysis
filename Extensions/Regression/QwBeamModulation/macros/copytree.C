#include<iostream>
#include<cstdio>
#include "TFile.h"
#include "TTree.h"
#include "TROOT.h"
#include "TString.h"
#include "TSystem.h"


void copytree(TString filename, TString treename) {
// Example of Root macro to copy a subset of a Tree to a new Tree
// Only selected entries are copied to the new Tree.
// The input file has been generated by the program in $ROOTSYS/test/Event
// with   Event 1000 1 99 1
//Author: Rene Brun
   

   //Get old file, old tree and set top branch address
  TFile *oldfile = new TFile(Form("/net/data2/paschkelab2/DB_rootfiles/run2/%s",
				  filename.Data()));
  TTree *oldtree = (TTree*)oldfile->Get(treename.Data());
  Long64_t nentries = oldtree->GetEntries();
  Int_t run;
  Float_t run_num = 0;
  cout<<1<<endl;
  if(oldtree->SetBranchAddress("run_number",&run)!=0)
    if(oldtree->SetBranchAddress("run",&run)!=0)
      oldtree->SetBranchAddress("run_number_decimal",&run_num);
  cout<<2<<endl;
  Create a new file + a clone of old tree in new file
     TString newfilename = filename;
     newfilename.Remove(newfilename.Length()-5,5);
     newfilename.Append("_trunc.root");
   TFile *newfile = new TFile(Form("/net/data2/paschkelab2/DB_rootfiles/run2/%s",
				   newfilename.Data()),"recreate");
   TTree *newtree = oldtree->CloneTree(0);
   cout<<3<<endl;

   for (Long64_t i=0;i<nentries; i++) {
      oldtree->GetEntry(i);
      if(run_num>9000)
	run = (int) run_num;
      if (run<14252||run>14255 && run>9000) newtree->Fill();
      run = 0;
      run_num = 0;
   }
   newtree->Print();
   newtree->AutoSave();
   delete oldfile;
   delete newfile;
}
