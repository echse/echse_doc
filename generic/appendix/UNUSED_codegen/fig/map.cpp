#include <iostream>
#include <map>
using namespace std;

// Typ der Map (String als Schlüssel für double-Wert)
typedef map<const char*, double> parmap;

// Funktion die die Parameter verwendet
// Übergabe als const ist hier leider nicht möglich
double fun (parmap &params) {
  return( params["a"] * params["b"] );
}

// Anwendung der Funktion
int main() {
  parmap params;
  params["a"]= 2.0;
  params["b"]= 5.0;
  cout << fun(params) << endl;
  return(0);
}

