#include <iostream>
#include <vector>
#include <valarray>
#include <ctime>

using namespace std;

// The test functions
void fun_vector (const vector<double> &x, vector<double> &y);
void fun_valarray (const valarray<double> &x, valarray<double> &y);
void fun_valarray_slice (const valarray<double> &x, valarray<double> &y);
void fun_carray (const double x[], const unsigned nx, double y[]);

int main () {

  // Parameters
  const unsigned int N=10000000;
  const unsigned int NTRIALS=20;

  // Timing variables
  int t_start;
  double time_vector, time_valarray, time_valarray_slice, time_carray; 

  // Declare arrays
  vector<double> x_vector, y_vector;
  valarray<double> x_valarray, y_valarray;
  double *x_carray, *y_carray;

  // Allocate arrays
  x_vector.resize(N);
  y_vector.resize(N);
  x_valarray.resize(N);
  y_valarray.resize(N);
  x_carray= new double[N];
  y_carray= new double[N];

  // Initialize arrays
  for (unsigned int i=0; i<N; i++) x_vector[i]= static_cast<double>(i);
  for (unsigned int i=0; i<N; i++) x_valarray[i]= static_cast<double>(i);
  for (unsigned int i=0; i<N; i++) x_carray[i]= static_cast<double>(i);

  // Time function calls
  time_vector= 0.;
  time_valarray= 0.;
  time_valarray_slice= 0.;
  time_carray= 0.;
  for (unsigned int t=1; t<=NTRIALS; t++) {

    t_start= clock();
    fun_vector(x_vector, y_vector);
    time_vector= time_vector + (clock()-t_start) / CLOCKS_PER_SEC;

    t_start= clock();
    fun_valarray(x_valarray, y_valarray);
    time_valarray= time_valarray + (clock()-t_start) / CLOCKS_PER_SEC;

    t_start= clock();
    fun_valarray_slice(x_valarray, y_valarray);
    time_valarray_slice= time_valarray_slice + (clock()-t_start) / CLOCKS_PER_SEC;

    t_start= clock();
    fun_carray(x_carray, N, y_carray);
    time_carray= time_carray + (clock()-t_start) / CLOCKS_PER_SEC;

  }

  cout << "Vector:           " << time_vector / NTRIALS << endl;
  cout << "Valarray:         " << time_valarray / NTRIALS << endl;
  cout << "Valarray(sclice): " << time_valarray_slice / NTRIALS << endl;
  cout << "C-Array:          " << time_carray / NTRIALS << endl;

  // Clean up
  x_vector.resize(0);
  y_vector.resize(0);
  x_valarray.resize(0);
  y_valarray.resize(0);
  delete [] x_carray;
  delete [] y_carray;
}

// The test functions
void fun_vector (const vector<double> &x, vector<double> &y) {
  for (unsigned int i=0; i<x.size(); i++) y[i]= pow(x[i], 2.0) * sin(x[i]);
}
void fun_valarray (const valarray<double> &x, valarray<double> &y) {
  for (unsigned int i=0; i<x.size(); i++) y[i]= pow(x[i], 2.0) * sin(x[i]);
}
void fun_valarray_slice (const valarray<double> &x, valarray<double> &y) {
  y[slice(1, x.size(), 1)]= pow(x[slice(1, x.size(), 1)], 2.0) *
    sin(x[slice(1, x.size(), 1)]);
}
void fun_carray (const double x[], const unsigned nx, double y[]) {
  for (unsigned int i=0; i<nx; i++) y[i]= pow(x[i], 2.0) * sin(x[i]);
}

