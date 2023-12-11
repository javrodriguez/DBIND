bam_dir = "/BAM-DD"
peak_dir = "/PEAK_DIR"

bam_suffix = ".dd.bam"
peak_suffix = ".peaks.bed"

bams_files = list.files(bam_dir,pattern = paste0(bam_suffix,"$"),full.names = F,include.dirs = F,recursive = F)
peak_files = list.files(peak_dir,pattern = paste0(peak_suffix,"$"),full.names = F,include.dirs = F,recursive = F)

sampleName_bams=gsub(bams_files,pattern=bam_suffix,replacement = "")
sampleName_peaks=gsub(peak_files,pattern=peak_suffix,replacement = "")
sampleName = sampleName_bams[sampleName_bams %in% sampleName_peaks]

ss=data.frame(SampleID=sampleName,
              Tissue=NA,
              Factor=NA,
              Condition=NA,
              TimePoint=NA,
              Treatment=NA,
              Replicate=NA,
              bamReads=paste0(bam_dir,"/",sampleName,bam_suffix),
              Peaks=paste0(peak_dir,"/",sampleName,peak_suffix),
              PeakCaller = "bed",stringsAsFactors = F)

write.csv(ss,"samples.diffBind.csv",row.names = F)
