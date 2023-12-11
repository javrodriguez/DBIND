bams_files = list.files(path="./",pattern="chip_sorted.bam$",recursive=T,include.dirs = F)
peak_files = list.files(path="./",pattern="chip_peaks.broadPeak",recursive=T,include.dirs = F)

sampleName_bams=gsub(bams_files,pattern="/chip_sorted.bam",replacement = "")
sampleName_peaks=gsub(peak_files,pattern="/chip_peaks.broadPeak",replacement = "")
sampleName = sampleName_bams[sampleName_bams %in% sampleName_peaks]

ss=data.frame(SampleID=sampleName,
              Tissue=NA,
              Factor=NA,
              Condition=NA,
              TimePoint=NA,
              Treatment=NA,
              Replicate=NA,
              bamReads=bams_files,
              Peaks=peak_files,
              PeakCaller = "bed",stringsAsFactors = F)

write.csv(ss,"samples.diffBind.csv",row.names = F)
