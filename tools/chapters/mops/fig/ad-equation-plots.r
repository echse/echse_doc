
setwd("/home/dkneis/progress/echse_tools/doc_latex/current/chapters/mops/fig")

rm(list=ls())

# Model equation
c_xt= function (x,t,m,a,d,u) {
  m/a/sqrt(4*3.1415*d*t) * exp(-(x-u*t)^2 / (4*d*t))
}

# Example parameters
p= list(m=100, a=1, d=30, u=0.5)


################################################################################
setEPS()
postscript(file= "ad-equation_fixedTimes.eps", width=3, height=3, pointsize=10)
x= seq(from= 0, to=5000, by=10)
t= seq(from= 900, to=3600, by=900)
clr= rainbow(length(t))
plot(x,c_xt(x,t[1],p$m, p$a, p$d, p$u), type="l", col=clr[1], xlab="x", ylab="c(x,t)")
for (i in 2:length(t)) {
  lines(x,c_xt(x,t[i],p$m, p$a, p$d, p$u), col=clr[i], lty=i)
}
legend("topright",bty="n",lty=1:length(t),col=clr,legend=paste("t=",t),cex=0.8)
graphics.off()

################################################################################
setEPS()
postscript(file= "ad-equation_fixedStations.eps", width=3, height=3, pointsize=10)
x= seq(from= 500, to=5000, by=1000)
t= seq(from= 0, to=7200, by=20)
clr= rainbow(length(x))

plot(t,c_xt(x[1],t,p$m, p$a, p$d, p$u), type="l", col=clr[1], xlab="t", ylab="c(x,t)")
for (i in 2:length(x)) {
  lines(t,c_xt(x[i],t,p$m, p$a, p$d, p$u), col=clr[i], lty=i)
}
legend("topright",bty="n",lty=1:length(x),col=clr,legend=paste("x=",x),cex=0.8)
graphics.off()

