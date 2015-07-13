
ofile= "/home/dkneis/progress/echse_apps/doc_latex/current/chapters/part_processes/runoffGeneration/fig/powerExpression.eps"

rel_sat= seq(0, 1, 0.001)
expo= c(0.2, 0.5, 1, 2, 5)

f= function (rel_sat, expo) {
  rel_sat^expo
}


xlab= "s"
ylab= "f"

postscript(file=ofile, width=4, height=4)

plot(range(rel_sat), c(0,1), type="n", xlab=xlab, ylab=ylab)
for (i in 1:length(expo)) {
  lines(rel_sat, f(rel_sat, expo[i]), lty=1+(expo[i]<1)+(expo[i]>1)*2)
  leg= substitute(paste("E","=",e),list(e=expo[i]))
  rect(xleft=0.4,xright=0.6,ybottom=f(0.5, expo[i])-0.05, ytop=f(0.5, expo[i])+0.05, col="white", border=NA)
  text(x=0.5, y=f(0.5, expo[i]), leg, cex=0.8)
}
legend("bottomright",bty="n", legend="f=s^E")
graphics.off()

