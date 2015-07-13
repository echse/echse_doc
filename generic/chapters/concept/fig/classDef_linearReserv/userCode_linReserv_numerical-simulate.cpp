// Save initial volume for use mass balance
double v_ini= stateScal(v); 

// Compute new value of v using the built-in ODE solver with arg.s 1--6
odesolve_nonstiff(
  stateScal_all(),              // 1: Initial value(s) of state variable(s)
  delta_t,                      // 2: Lenght of time step
  1.e-08,                       // 3: Accuracy (adjustable)
  1000,                         // 4: Max. number of sub-steps (adjustable)
  this,                         // 5: Pointer to active object
  set_stateScal_all());         // 6: New value(s) of state variable(s)

// Set q_ex using the mass balance
set_output(q_ex)= inputSim(q_in) - (stateScal(v) - v_ini) / delta_t;

