// Created: Tue Jul  3 11:06:24 2012

////////////////////////////////////////////////////////////////////////////////
//////////////////// THIS IS A GENERATED FILE - DO NOT EDIT ////////////////////
////////////////////////////////////////////////////////////////////////////////

// The function defined below returns an array of the objectGroups.
//
// Details: For each objectGroup, a single instance is created and
// pointers to these instances are stored in the output array.
// Note that the objectGroup instances must be declared as STATIC
// for the pointers to be valid outside the function.

// Base headers
#include <string>
#include <vector>

// Constant headers
#include "echse_coreClass_abstractObjectGroup.h"
#include "echse_coreClass_templateObjectGroup.h"

// Generated headers
#include "AUTOechse_userClass_linReserv.h"

void instantiateObjectGroups(
  vector<abstractObjectGroup*> &objectGroups
) {

  vector<string> paramFun;
  vector<string> paramNum;
  vector<string> inputExt;
  vector<string> inputSim;
  vector<string> stateScal;
  vector<string> stateVect;
  vector<string> output;
  vector<string> sharedParamFun;
  vector<string> sharedParamNum;

  // PART 1: Instantiation of objectGroups from template class

  // OBJECT GROUP 'linReserv':
  paramFun = {
  };
  paramNum = {
     "k"
  };
  inputExt = {
  };
  inputSim = {
     "q_in"
  };
  stateScal = {
     "v"
  };
  stateVect = {
  };
  output = {
     "q_ex"
  };
  sharedParamFun = {
  };
  sharedParamNum = {
  };
  static templateObjectGroup<object_linReserv> objectGroup_linReserv("linReserv",
    paramFun,
    paramNum,
    inputExt,
    inputSim,
    stateScal,
    stateVect,
    output,
    sharedParamFun,
    sharedParamNum
  );
 

  // PART 2: Set array of pointers to static objectGroups

  objectGroups.resize(1);
  objectGroups[0]= &objectGroup_linReserv;
} // End of function

