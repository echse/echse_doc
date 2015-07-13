
#
# Illustrates the dynamics of the albedo as affected by precipitation and temperature
#

rm(list=ls())

ofile= "/home/dkneis/progress/echse_core/doc_latex/chapters/hydro/fig/snow-albedo-simExample.eps"

postscript(file=ofile,width=3,height=5,horizontal=F)

require("odesolve")

dt= 86400

albMin= 0.38
albMax= 0.83
k_warm= k=-0.12/dt *log(albMax-albMin)  # k > 0
k_cold= k=-0.05/dt *log(albMax-albMin)  # k > 0
temp_rainsnow= 0

# Vector of times
times= seq(from=0, to=dt*40, by=dt)
# Sample temperatures
temp_ampl= 2
temps= temp_ampl*sin(3.1415*4*times/max(times))
# Sample precipitations
precseq= c(0,0,0,0,0,1)
precs= rep(precseq,ceiling(length(times)/length(precseq)))[1:length(times)]

layout(matrix(1:2,nrow=2), widths=1, heights=c(1,1), respect = FALSE)
par(mar=c(4,4,1,2))

# Plot temperature and precipitation
plot(range(times), c(min(c(temps,precs)),1.5*max(c(temps,precs))), type="n", xlab="Days", ylab="mm, °C",xaxt="n")
axis(side=1,at=times,labels=times/dt)
abline(h=0)
lines(times,temps,lty=2)
lines(times,precs,type="s")
legend("top",horiz=T,bty="n",lty=c(1,2),legend=c("Prec","Temp"),cex=0.8)


# Derivative of the albedo with respect to time (exponential formulation)
ddt_alb = function (t, y, parms) {
  if (parms["renew"]) {
    tmp= (parms["albMax"]-y)
  } else {
    tmp= -1 * parms["k"]*(y-parms["albMin"])
  }
  return(list(tmp,NA))
}

plot(range(times),c(albMin,albMax),type="n",xlab="Days",ylab="Albedo",xaxt="n")
axis(side=1,at=times,labels=times/dt)
y_start= albMax
for (it in 1:length(times)) {

  # Set parameters
  if (temps[it] >= 0) {
    k= k_warm
  } else {
    k=k_cold
  }
  if ((temps[it] < temp_rainsnow) && (precs[it] > 0)) {
    renew= 1
  } else {
    renew= 0
  }
  parms= c(albMin=albMin, albMax=albMax, k=k, renew=renew)

  # Integrate
  res= lsoda(y=y_start, times=c(0,dt), func=ddt_alb, parms=parms,
    rtol=0.001, atol=0.001, tcrit=NULL, jacfunc=NULL, verbose=FALSE,
    dllname=NULL, hmin=0, hmax=Inf)
  # Plot result
  if (it==1) {
    points(times[it]+res[1,1],res[1,2],pch=20)
  }
  points(times[it]+res[2,1],res[2,2],pch=20)
  y_start= res[2,2]
}

graphics.off()





