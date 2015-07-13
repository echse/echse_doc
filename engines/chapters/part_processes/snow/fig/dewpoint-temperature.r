
ofile= "/home/dkneis/progress/echse/doc_latex/chapters/hydro/fig/dewpoint-temperature.eps"

postscript(file=ofile,width=4.5,height=4.5,horizontal=F)

eSat= function(celsius, overIce) {
  if (overIce) {
    E= 6.11 * 10^((9.5 * celsius)/(265.5 + celsius))
  } else {
    E= 6.11 * 10^((7.5 * celsius)/(237.3 + celsius))
  }
  return(E)
}

tDew= function(celsius, relhum, overIce) {
  # Compute actual vapor pressure from relative humidity and temperature
  e= relhum/100 * eSat(celsius,overIce)
  # Compute dewpoint temperature (re-arranged Magnus formula)
  if (overIce) {
    t= (265.5*log10(e/6.11)) / (9.5-log10(e/6.11))
  } else {
    t= (237.3*log10(e/6.11)) / (7.5-log10(e/6.11))
  }
}

temps= seq(from=-25, to=25, by=1)
relhum= seq(from=0, to=100, by=1)

t_overWat= matrix(NA, ncol=length(temps), nrow=length(relhum))
t_overIce= matrix(NA, ncol=length(temps), nrow=length(relhum))
for (ic in 1:ncol(t)) {
  for (ir in 1:nrow(t)) {
    t_overWat[ir,ic]= tDew(celsius= temps[ic], relhum= relhum[ir], overIce=F)
    t_overIce[ir,ic]= tDew(celsius= temps[ic], relhum= relhum[ir], overIce=T)
  }
}

lev= seq(from=-100,to=50,by=10)
contour(relhum, temps, t_overWat, levels=lev, ylim= range(temps)*c(1,1.25), xlab="Relative humidity (%)", ylab="T (°C)", labcex=1)
par(new=T)
contour(relhum, temps, t_overIce, levels=lev, ylim= range(temps)*c(1,1.25),
  labels="            ", xlab="", ylab="", lty=3)
legend("top",horiz=T,bty="n",lty=c(1,3), legend=c("Over water","Over ice"))

dev.off()


