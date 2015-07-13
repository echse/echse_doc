
ofile= "/home/dkneis/progress/echse_apps/doc_latex/current/chapters/part_processes/runoffConcentration/fig/singleLinearReservoir.eps"

d= data.frame(
  times= seq(from=0, to=48, by=1),
  qin= 0,
  v= NA,
  qex= NA
)

# Input pulse
d$qin[5]= 5
d$qin[6]= 5
d$qin[7]= 5
d$qin[8]= 5
d$qin[9]= 5

v0= 0

# Storage constants
k= c(2, 5, 10)


# Workhorse function
v.new= function(v0, qin, k, dt) {
  (v0 - qin * k) * exp(-dt / k) + qin * k
}

# Fill data frame with solutions for a particular k
update= function(k,d,v0) {
  d$v[1]= v0
  d$qex[1]= 1/k * v0
  for (i in 2:nrow(d)) {
    d$v[i]= v.new(v0=d$v[i-1], qin=d$qin[i-1], k=k, dt= abs(diff(d$times[(i-1):i])))
    d$qex[i]= 1/k * d$v[i]
  }
  return(d)
}

xlab= "Time (h)"
ylab= expression(paste("Flow rate (m",{}^3,")",sep=""))

postscript(file=ofile, width=4, height=4)

op= par(mar= c(4,5,1,1))
plot(d$times, d$qin, type="l", lty=1, xlab=xlab, ylab=ylab)
for (i in 1:length(k)) {
  d= update(k[i],d,v0)
  lines(d$times, d$qex, lty=i+1)
}
legend("topright",bty="n",lty=seq(1,length(k)+1,1),
  legend=c("Inflow",paste("Outflow (k=",k,")",sep="")))
par(op)
graphics.off()

