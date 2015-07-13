
# Todini (1996)
#
# Signs have been corrected !!!
#
Qd_arno= function(p, w, wmax, b) {
  x= (b+1)*wmax*(1-w/wmax)^(1/(b+1))
  if (p < x) {
   r= p - (wmax - w) + wmax*((1-w/wmax)^(1/(b+1)) - p/(b+1)/wmax)^(b+1)
   # IN PAPER: q= p + (wmax - w) - wmax*((1-w/wmax)^(1/(b+1)) - p/(b+1)/wmax)^(b+1)
  } else {
   r= p - (wmax - w)
   # IN PAPER: q= p + (wmax - w)
  }
  return(r)
}

# Bremicker (2000)
Qd_larsim= function(p, w, wmax, b) {
  x= (1-w/wmax)^(1/(b+1)) - p/(1+b)/wmax
  if (x > 0) {
   r= p - (wmax - w) + wmax*((1-w/wmax)^(1/(b+1)) - p/(b+1)/wmax)^(b+1)
  } else {
   r= p - (wmax - w)
  }
  return(r)
}


b= 0.45
wmax= 100
w= 80

# Comparison of Eqn.s
vp= seq(0, 100, 0.5)
plot(range(vp), range(vp), type="n", xlab="p", ylab="Qd")
for (p in vp) {
  points(p, Qd_arno(p, w, wmax, b), pch=3)
  points(p, Qd_larsim(p, w, wmax, b), pch=20)
}

ofile= "/home/dkneis/progress/echse_apps/doc/doc_latex/current/chapters/part_processes/runoffGeneration/fig/arno.eps"
postscript(file=ofile, width=4, height=4)

# Plot for documentation
plot(range(vp), range(vp), type="n", asp=1, xlab="Water input (mm)", ylab="Direct runoff (mm)")
for (i in 2:length(vp)) {
  lines(c(vp[i-1],vp[i]), c(Qd_larsim(vp[i-1], w, wmax, b),Qd_larsim(vp[i], w, wmax, b)))
}
legend("topleft",bty="n",legend=c(paste("Maximum storage: ",wmax," mm",sep=""),
  paste("Initial storage: ",w," mm",sep="")))
graphics.off()


