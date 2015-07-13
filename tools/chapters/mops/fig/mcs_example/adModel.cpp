#include<iostream>
#include<fstream>
#include<string>
#include<cmath>
using namespace std;

// Analytical solution of the 1-dimensional convection-dispersion eqn.
double c_xt (const double x, const double t, const double m, const double a,
  const double d, const double u)
{ return(m/a/sqrt(4.*3.1415*d*t) * exp(-pow(x-u*t,2.) / (4.*d*t))); }

// Driver program
int main (int argc, char **argv) {
  //////////// Read file names from command line ///////////////////////////////
  string cmd(argv[0]);
  if (argc != 3) {
    cout << "Usage: " << cmd << " inputfile outputfile" << endl; return(1); }
  string name_ifile(argv[1]); 
  string name_ofile(argv[2]); 
  //////////// Read parameters from input file /////////////////////////////////
  ifstream ifile(name_ifile.c_str());
  if (!ifile.is_open()) {
    cout << "Input file '" + name_ifile + "' not found." << endl; return(1); }
  double x, m, a, d, u, tmax, dt;
  try {
    string key;
    for (unsigned int i=0; i<7; i++) {
      ifile >> key;
      if (key == "x") {ifile >> x;} else if (key == "m") {ifile >> m;}
      else if (key == "a") {ifile >> a;} else if (key == "d") {ifile >> d;}
      else if (key == "u") {ifile >> u;} else if (key == "dt") {ifile >> dt;}
      else if (key == "tmax") {ifile >> tmax;}
      else {throw("Unexpected parameter in input file.");}
    }
  } catch(...) {
    cout << "Cannot read data from '" + name_ifile + "'." << endl; return(1); }
  ifile.close();
  //////////// Open output /////////////////////////////////////////////////////
  ifile.open(name_ofile.c_str());
  if (ifile.is_open()) {
    ifile.close();
    cout << "Output file '" + name_ofile + "' exists." << endl; return(1); }
  ofstream ofile(name_ofile.c_str());
  if (!ofile.is_open()) {
    cout << "Cannot open file '" + name_ofile + "'." << endl; return(1); }
  //////////// Print solution for the times of interest ////////////////////////
  double t=0.;
  while (t <= tmax) {
    if (t == 0.) { ofile << "t\tc" << endl << t << "\t" << 0. << endl; }
    else { ofile << t << "\t" << c_xt(x,t,m,a,d,u) << endl; }
    t= t + dt;
  }
  //////////// Finish //////////////////////////////////////////////////////////
  ofile.close();
  return(0);
}

