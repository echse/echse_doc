// *** params.h *** Editieren ist nicht sinnvoll da generierter Code ***
#ifndef PARAMS_H
#define PARAMS_H

#include <string>
using namespace std;

// Array mit Parameternamen und zugehörigen Werten (auf 0 initialisiert)
struct par {
  string name;
  double value;
};
struct par params[] {
  {"a", 0.},
  {"b", 0.}
};

// Funktion die die Parameter verwendet
double fun (const par params[]) {
  return( params[0].value * params[1].value );
}

#endif

