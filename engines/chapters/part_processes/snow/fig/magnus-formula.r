
ofile= "/home/dkneis/progress/echse/doc_latex/chapters/hydro/fig/magnus-formula.eps"

postscript(file=ofile,width=3,height=3.5,horizontal=F)

eSat_wat= function(celsius) {
  return(6.11 * 10^((7.5 * celsius)/(237.3 + celsius)))
}

eSat_ice= function(celsius) {
  return(6.11 * 10^((9.5 * celsius)/(265.5 + celsius)))
}

temps_wat= seq(from=-5, to=30, by=1)
temps_ice= seq(from=-25, to=5, by=1)

vprec_wat= eSat_wat(temps_wat)
vprec_ice= eSat_ice(temps_ice)

range_t= range(c(temps_wat,temps_ice))
range_e= range(c(vprec_wat,vprec_ice))
plot(range_t, range_e, type="n", xlab="T in °C", ylab="E(T) in hPa")
lines(temps_wat,vprec_wat,lty=1)
lines(temps_ice,vprec_ice,lty=2)
legend("topleft",bty="n",lty=c(1,2),legend=c("Over water","Over ice"))

dev.off()


