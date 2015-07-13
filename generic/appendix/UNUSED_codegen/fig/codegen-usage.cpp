#include <iostream>
#include <map>
#include "params.h"
using namespace std;

// Anwendung der Funktion
int main() {

  // Parameter mögen in einer Map gesammelt sein
  typedef map<string, double> parmap;
	parmap p;
  p["a"]= 2.0;
  p["b"]= 5.0;

  // Parameter in der Struktur speichern (mit Prüfung auf Kompatibilität)
  for (unsigned int i=0; i<sizeof(params)/sizeof(params[0]); i++) {
	  parmap::iterator iter= p.find(params[i].name);
    if (iter == p.end()) {
      cout << "Wert für Parameter '" << params[i].name << "' nicht gesetzt." << endl;
      return(1);
    } else {
      params[i].value= p[params[i].name];
    }
  }
  p.clear();

  // Funktion anwenden
  cout << fun(params) << endl;
  return(0);
}

