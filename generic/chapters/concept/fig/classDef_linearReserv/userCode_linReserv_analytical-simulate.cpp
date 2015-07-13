// Compute the new value of the state variable (v) at the end of the time
// step. We save the value in a temporary variable instead of updating v.
// This is because we still need the initial value in the next statement.
double v_new= (stateScal(v) - inputSim(q_in) * paramNum(k)) *
  exp(- delta_t / paramNum(k));

// Update the output variable (q_ex). We use the reservoir's mass balance
// to compute the time-step averaged outflow rate. Alternatively, we could
// simply return the instantaneous value at the end of the time step.
set_output(q_ex)= inputSim(q_in) - (v_new - stateScal(v)) / delta_t;

// We can now update v (since the initial value is no longer needed).
set_stateScal(v)= v_new;

