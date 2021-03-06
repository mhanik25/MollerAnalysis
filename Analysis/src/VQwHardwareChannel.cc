#include "VQwHardwareChannel.h"

// Qweak database headers
#include "QwLog.h"
#include "QwDBInterface.h"
#include "QwParameterFile.h"

VQwHardwareChannel::VQwHardwareChannel():
  fNumberOfDataWords(0),
  fNumberOfSubElements(0), fDataToSave(kRaw)
{
  fULimit = 0.0;
  fLLimit = 0.0;
  fErrorFlag = 0;
  fErrorConfigFlag = 0;
}

VQwHardwareChannel::VQwHardwareChannel(const VQwHardwareChannel& value)
  :VQwDataElement(value),
   fNumberOfDataWords(value.fNumberOfDataWords),
   fNumberOfSubElements(value.fNumberOfSubElements),
   fDataToSave(value.fDataToSave),
   fTreeArrayIndex(value.fTreeArrayIndex),
   fTreeArrayNumEntries(value.fTreeArrayNumEntries),
   fPedestal(value.fPedestal),
   fCalibrationFactor(value.fCalibrationFactor),
   kFoundPedestal(value.kFoundPedestal),
   kFoundGain(value.kFoundGain),
   bEVENTCUTMODE(value.bEVENTCUTMODE),
   fULimit(value.fULimit),
   fLLimit(value.fLLimit),
   fStability(value.fStability)
{
}

VQwHardwareChannel::VQwHardwareChannel(const VQwHardwareChannel& value, VQwDataElement::EDataToSave datatosave)
  :VQwDataElement(value),
   fNumberOfDataWords(value.fNumberOfDataWords),
   fNumberOfSubElements(value.fNumberOfSubElements),
   fDataToSave(datatosave),
   fTreeArrayIndex(value.fTreeArrayIndex),
   fTreeArrayNumEntries(value.fTreeArrayNumEntries),
   fPedestal(value.fPedestal),
   fCalibrationFactor(value.fCalibrationFactor),
   kFoundPedestal(value.kFoundPedestal),
   kFoundGain(value.kFoundGain),
   bEVENTCUTMODE(value.bEVENTCUTMODE),
   fULimit(value.fULimit),
   fLLimit(value.fLLimit),
   fStability(value.fStability)
{
}


void VQwHardwareChannel::SetSingleEventCuts(Double_t min, Double_t max)
{
  fULimit=max;
  fLLimit=min;
}

void VQwHardwareChannel::SetSingleEventCuts(UInt_t errorflag,Double_t min, Double_t max, Double_t stability)
{
  fErrorConfigFlag=errorflag;
  fStability=stability;
  SetSingleEventCuts(min,max);
  QwMessage << "Set single event cuts for " << GetElementName() << ": "
	    << "Config-error-flag == 0x" << std::hex << errorflag << std::dec
	    << ", global? " << ((fErrorConfigFlag & kGlobalCut)==kGlobalCut) << ", stability? " << ((fErrorConfigFlag & kStabilityCut)==kStabilityCut)<<" cut "<<fStability << QwLog::endl;
}


void VQwHardwareChannel::AddEntriesToList(std::vector<QwDBInterface> &row_list)
{
  QwDBInterface row;
  TString name    = GetElementName();
  UInt_t  entries = GetGoodEventCount();
  //  Loop over subelements and build the list.
  for(UInt_t subelement=0; 
      subelement<GetNumberOfSubelements();
      subelement++) {
    row.Reset();
    row.SetDetectorName(name);
    row.SetSubblock(subelement);
    row.SetN(entries);
    row.SetValue(GetValue(subelement));
    row.SetError(GetValueError(subelement));
    row_list.push_back(row);
  }
}

void VQwHardwareChannel::ConstructBranch(TTree *tree, TString &prefix, QwParameterFile& modulelist){
  if (GetElementName()!=""){
    TString devicename;
    devicename=GetElementName();
    devicename.ToLower();
    if (modulelist.HasValue(devicename)){
      ConstructBranch(tree,prefix);
    }
  }
}
