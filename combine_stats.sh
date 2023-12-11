#!/bin/bash -l

stats_combined="summary-combined.chip.csv"
stats_dbind="stats_diffBind.csv "
stats_peaks="summary.peaks-macs-broad-nocontrol-q-0.1.csv"

echo "#SAMPLE,R1 RAW READS,R2 RAW READS,TOTAL READS,MAPPED READS %,CHR M READS %,MAPPED READS MQ30 %,MAPPED READS,DEDUPLICATED READS,DUPLICATES %,Tissue,Factor,Intervals,Reads,FRiP,#PEAK" > QC_chip.csv

awk 'NR>1' ${stats_combined} | sort -k1 > combined.csv
awk 'NR>1' ${stats_dbind} | sort -k1 > stats1.csv
awk 'NR>1' ${stats_peaks}  | sort -k1 > stats2.csv

join -t"," -j 1 combined.csv stats1.csv > QC_chip1.csv
join -t"," -j 1 QC_chip1.csv stats2.csv >> QC_chip.csv

rm -f combined.csv stats1.csv stats2.csv  QC_chip1.csv
