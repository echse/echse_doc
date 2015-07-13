
# Comparison of approaches to estimate clear-sky emissivity cited at p. 373 of
# Hock, R. (2005): Glacier melt: A review of processes and their modelling,
# Progress in Physical Geography, 29(3), 362-391.

rm(list=ls())

ofile= "/home/dkneis/progress/echse/doc_latex/chapters/hydro/fig/clearskyEmissivity.eps"

postscript(file=ofile,width=3,height=3.5,horizontal=F)

# Input for all formulas (if applicable)
# - temperature, t, in °C
# - vapor pressure, e, in hPa

Brutsaert1975 = function (e,t) {
  t= t + 273.15
  1.24 * (e/t)^(1/7)
}

Brunt1932 = function (e) {
  0.51 + 0.066*(e)^0.5
}

# Parameters taken from Wikipedia site for 'Atmosphärische Gegenstrahlung'
Angstroem1916 = function (e) {
  0.790 - 0.174 * 10^(-0.041 * e)
}

# Vectors of test values
vect_e= seq(from=2, to=40, by=1)
vect_t= seq(from=-20,to=20,by=20)

plot(range(vect_e),c(0.45,1),type="n",xlab="Vapor pressure (hPa)",ylab="Emissivity (-)")
for (it in 1:length(vect_t)) {
  lines(vect_e, Brutsaert1975(vect_e,vect_t[it]), lwd=1, lty=1+it)
  lines(vect_e, Angstroem1916(vect_e), lwd=2)
  lines(vect_e, Brunt1932(vect_e), lwd=3)
}
legend("bottomright",bty="n",cex=0.8,lwd=c(1,2,3),lty=c(2,1,1),
  legend=c("Brutsaert 1975\n(-20...+20°C)","Angstroem 1916","Brunt 1932")
)

dev.off()



