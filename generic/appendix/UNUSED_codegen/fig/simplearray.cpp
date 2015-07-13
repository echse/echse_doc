#include <iostream>
using namespace std;

// Funktion die die Parameter verwendet
double fun (const double* params) {
  // Element 0 == Parameter "a", Element [1] == Parameter "b"
  return( params[0] * params[1] );
}

// Anwendung der Funktion
int main() {
  double params[2]= {2.0, 5.0};
  cout << fun(params) << endl;
  return(0);
}

