#!/bin/bash


$ECHSE_ROOT/echse_tools/meteofill/current/meteofill ifile_locations="in_locations.txt" ifile_data="in_timeSeries.txt" chars_colsep="	" chars_comment="#" nodata=-99. idw_power=2 nsectors=4 norigins=3 resid_nmin=3 resid_r2min=0.36 resid_llim=-40. resid_ulim=40. ofile_data="out_timeSeries.txt" ofile_locations="out_locations.txt" ndigits_max=2 logfile="out_log.txt" overwrite=true
