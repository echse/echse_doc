############ PART 0 ############################################################
rm(list=ls())
library("mops")

# Set working direcory ( A D J U S T   T O   Y O U R    S E T T I N G S  !)
setwd("~/progress/echse/echse_doc/tex/tools/current/chapters/mops/fig/mcs_example")

############ PART 1 ############################################################
# Define variables for folders and files 
dir_run= paste(tempdir(),"run",sep="/")       # Output of current run
dir_mcs= paste(tempdir(),"mcs",sep="/")       # Output of MCS
if (!file.exists(dir_run)) dir.create(dir_run)
if (!file.exists(dir_mcs)) dir.create(dir_mcs)

ifile= paste(dir_run,"input.txt",sep="/")  # Model input (generated from template)
ofile= paste(dir_run,"output.txt",sep="/") # Output file of the model

############ PART 2 ############################################################
# Table with sampling ranges for the parameters
rangeTbl= data.frame(parameter= c("u", "d"), min= c(0.1, 10), max= c(2.0, 200))

# Table defining the files to be edited automatically
updateTbl= data.frame(file_template=c("in_template.txt"), file_result=c(ifile))

############ PART 3 ############################################################
# Call to the Monte-Carlo method from package mops
mcs_run(
  ranges_table= rangeTbl,
  nSamples= 500,
  updating_table= updateTbl,
  model_path= "./adModel",         # on Linux, the "./" is required
  model_args= c(ifile, ofile),
  outdir_model= dir_run,
  outdir_mcs= dir_mcs,
  silent=FALSE
)

############ PART 4 ############################################################
# Analyze the results of all model runs and create useful graphics
mcs_eval(
  outdir_mcs= dir_mcs,
  obs_files= c(all="observations.txt"),
  obs_colsTime= "time",
  obs_colsValue= "conc",
  obs_colsep="\t",
  obs_timeConv= function(x) { ISOdatetime(1970,1,1,0,0,0) + x },
  sim_file= basename(ofile),
  sim_colTime= "t",
  sim_colValue= "c",
  sim_colsep="\t",
  sim_timeConv= function(x) { ISOdatetime(1970,1,1,0,0,0) + x },
  obs_nodata= -9999,
  periods= data.frame(begin=c(), end=c()),
  gof_function= function(obs,sim) { c(rmse= sqrt(mean((sim-obs)^2))) },
  showStats=TRUE
)

print(paste("Outputs, incl. a PDF with graphics, are in '",dir_mcs,"'.",sep=""))


