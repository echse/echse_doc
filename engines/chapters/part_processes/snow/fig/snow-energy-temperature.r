
ofile= "/home/dkneis/progress/echse/doc_latex/chapters/hydro/fig/snow-energy-temperature.eps"

# Physical constants
density=        1000  # kg/m3
specHeatLiquid= 4.18  # kJ/kg/K
specHeatSolid=  2.09  # kJ/kg/K
formHeatIce=   333.5 # kJ/kg

# Variables
snowWaterEquivalent= 0.05 # m

# Critical energy content where all ice has melted (all water is liquid)
u_crit  = snowWaterEquivalent * density * formHeatIce
# kJ/m2 =       m                kg/m3       kJ/kg    

# Increase of temperature with increasing energy
dt_du     = function (waterEquivalent, density, specHeat) {
            1 / (waterEquivalent * density * specHeat)
# K*m2/kJ   1 /      m              kg/m3     kJ/kg/K   
}

# Show snow temperature as a function of energy content

range_u= c(-0.3*u_crit,u_crit*1.2)
range_t= c(-20,10)

postscript(file=ofile,width=5,height=3.5,horizontal=F)

plot(range_u, range_t, type="n", bty="n", xaxt="n", yaxt="n",
  xlab="Energy content (kJ/kg)", ylab="Temperature (°C)")
# x-axis
axis(side=1, pos=0, labels=NA)
axis(side=1, lwd=0)
# y-axis
axis(side=2, pos=0, labels=NA)
axis(side=2, lwd=0)
# Critical energy content
abline(v=u_crit, lty=2)
# t(u) for solid water (ice)
u= seq(from=0, to=min(range_u), length.out=5)
t= (u - 0) * dt_du(snowWaterEquivalent, density, specHeatSolid)
lines(u, t, lty=2, lwd=3)
# t(u) for liquid water
u= seq(from=u_crit, to=max(range_u), length.out=5)
t= (u - u_crit) * dt_du(snowWaterEquivalent, density, specHeatLiquid)
lines(u, t, lty=2, lwd=3)
# t(u) during melt
u= c(0, u_crit)
t= c(0, 0)
lines(u, t, lty=2, lwd=3)

# Labels
text(x=0.5*u_crit, y=0.8*max(range_t), "Solid-liquid mixture")
text(x=-0.18*u_crit, y=0.8*max(range_t), "Solid")
text(x=1.15*u_crit, y=0.3*min(range_t), "Liquid")
text(x=0.5*u_crit, y=0.5*min(range_t), paste("Calculated for\nSWE= ",snowWaterEquivalent," m",sep=""), cex=0.8)

dev.off()


