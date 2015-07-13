############ PART 0 ############################################################

rm(list=ls())
library("mops")

# Set working direcory ( A D J U S T   T O   Y O U R    S E T T I N G S  !)
setwd("~/progress/echse_tools/doc_latex/current/chapters/mops/fig/mcs_example")

############ PART 1 ############################################################

# Define variables for files
ifile= tempfile()    # Actual input file of the model (generated from template)
ofile= tempfile()    # Output file of the model
logfile= tempfile()  # Output file of the Monte-Carlo experiment

############ PART 2 ############################################################

# Table with sampling ranges for the parameters
rangeTbl= data.frame(parameter= c("u", "d"), min= c(0.1, 10), max= c(2.0, 200))

# Table defining the files to be edited automatically
updateTbl= data.frame(file_template=c("in_template.txt"), file_result=c(ifile))

############ PART 3 ############################################################

# Call to the Monte-Carlo method from package mops
modelError_MCS(
  ranges_table= rangeTbl,
  nSamples= 500,                   # 500 runs
  updating_table= updateTbl,
  placeholder_openChar = "{", placeholder_closeChar = "}",
  model_path= "./adModel",         # on Linux, the "./" is required
  model_args= c(ifile, ofile),
  func_first= function(x) { if (file.exists(x)) file.remove(x) },
  args_first= ofile,
  func_final= function(x) {},
  args_final= NULL,
  sim_file= ofile,
  sim_colTime= "t", sim_colValue= "c", sim_colsep = "\t",
  sim_timeConv = function(x) { ISOdatetime(1970,1,1,0,0,0) + x },
  obs_file= "observations.txt",
  obs_colTime= "time", obs_colValue= "conc", obs_colsep = "\t",
  obs_timeConv = function(x) { ISOdatetime(1970,1,1,0,0,0) + x },
  obs_nodata = -9999,
  time_min = NULL, time_max = NULL,
  gof_function = function(obs, sim) { c(rmse= sqrt(mean((obs - sim)^2))) },
  logfile= logfile
)

############ PART 4 ############################################################

# Plot result (remove the ## comments to save the plot to a file)
##setEPS()
postscript(file="dottyplots.eps",width=6,height=3)
##logfile.plot(file=logfile, ycol="rmse", xcols=NULL)
##graphics.off()

