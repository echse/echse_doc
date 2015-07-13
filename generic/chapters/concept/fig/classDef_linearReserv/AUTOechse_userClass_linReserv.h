// Created: Tue Jul  3 11:06:24 2012

////////////////////////////////////////////////////////////////////////////////
//////////////////// THIS IS A GENERATED FILE - DO NOT EDIT ////////////////////
////////////////////////////////////////////////////////////////////////////////

// This file provides the declaration of class 'linReserv'.
//
// To make this class usable, this header files must be supplemented
// by the body code of the class methods. The code is assumed to
// reside in the following files:
//   <some_directory>/userCode_linReserv_aux.cpp
//   <some_directory>/userCode_linReserv_simulate.cpp
//   <some_directory>/userCode_linReserv_derivsScal.cpp
// Note that the last file may be empty, if the 'derivsScal' method
// of this class is not used. The first file may contain definitions
// (of functions, for example) that should be available in the two methods.
// This file may also be empty.

#ifndef AUTOECHSE_USERCLASS_LINRESERV_H
#define AUTOECHSE_USERCLASS_LINRESERV_H

// Include standard headers
#include <cmath>    // Math functions
#include <sstream>  // For generating error messages
#include "echse_coreClass_abstractObject.h" // Abstract base class
#include "echse_coreFunct_solveODE.h"       // Access to ODE solver

using namespace std;

class object_linReserv: public abstractObject {
  public:
    object_linReserv() { };   // Constructor - Definition not required
    ~object_linReserv() { };  // Destructor - Definition not required
    // Virtual methods inherited from abstract base class
    void simulate(const unsigned int delta_t);
    void derivsScal(const double t, const vector<double> &u,
      vector<double> &dudt, const unsigned int delta_t);
};

// ----- Frames of method implementations follow -----

// Import auxiliary definitions to be used in 'simulate' and 'derivsScal'
#include "userCode_linReserv_aux.cpp"

// The 'simulate' method
namespace object_linReserv_simulate {
  static const T_index_paramNum k= {0};
  static const T_index_inputSim q_in= {0};
  static const T_index_stateScal v= {0};
  static const T_index_output q_ex= {0};
}
void object_linReserv::simulate(const unsigned int delta_t) {
  using namespace object_linReserv_simulate;
  try {
    #include "userCode_linReserv_simulate.cpp"
  } catch (except) {
    stringstream errmsg;
    errmsg << "Simulation failed for time step of length " << delta_t << ".";
    except e(__PRETTY_FUNCTION__,errmsg,__FILE__,__LINE__);
    throw(e);
  }
}

// The 'derivsScal' method
namespace object_linReserv_derivsScal {
  static const T_index_paramNum k= {0};
  static const T_index_inputSim q_in= {0};
  static const unsigned int INDEX_v= 0; // for use with vectors u & dudt
  static const T_index_output q_ex= {0};
}
void object_linReserv::derivsScal(const double t,
  const vector<double> &u, vector<double> &dudt, const unsigned int delta_t) {
  using namespace object_linReserv_derivsScal;
  try {
    #include "userCode_linReserv_derivsScal.cpp"
  } catch (except) {
    stringstream errmsg, data;
    for (unsigned int i=0; i<u.size(); i++) data << u[i] << " ";
    errmsg << "Calculation of derivatives failed (Time: " << t << " Number" <<
      " of deriv.s: " << dudt.size() << " Value(s) of state(s): " << data <<
      " Length of time step: " << delta_t << ").";
    except e(__PRETTY_FUNCTION__,errmsg,__FILE__,__LINE__);
    throw(e);
  }
}

#endif

