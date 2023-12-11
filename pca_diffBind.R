### FUNCTIONS ###
FX1=function(sample_sheet,out_name,n_cores=1,stats_out=F){
  dba_data = dba(sampleSheet=sample_sheet,  minOverlap=2,filter=0, bRemoveM=T) ## Generate a DBA objects
  dba_data$config$cores = n_cores
  dba_data = dba.count(dba_data,
                     minOverlap=2,
                     bUseSummarizeOverlaps = F,
                     bParallel = T,
                     filter=1,
                     summits = 200)
  dba_data = dba.normalize(dba_data,normalize=DBA_NORM_LIB,bFullLibrarySize=TRUE)
  stats=dba.show(dba_data)
  stats=stats[,-4]
  print(stats)
  write.csv(stats, paste0("stats_",out_name,".csv"),row.names = F,quote=F)
  pdf(paste0("pca_",out_name,".pdf"))
  dba.plotPCA(dba_data,attributes = DBA_ID,label="ID",labelSize=0.5)
  dev.off()
  
  if(stats_out) {return(stats)}
}

### RUN ###
group_by1="Factor"
group_by2="Tissue"
group_by3="Treatment"
ss_file="samples.diffBind.csv"
n_cores=8

library(DiffBind)

options(scipen = 999)
ss = read.csv(ss_file)
ss[is.na(ss)]=0

groups1=unique(ss[,group_by1])
groups2=unique(ss[,group_by2])
groups3=unique(ss[,group_by3])

## add replicate ID
# for (group1 in groups1){
#   for (group2 in groups2){
#     for (group3 in groups3){
#     idx = ss[,group_by1]==group1 & ss[,group_by2]==group2 & ss[,group_by3]==group3
#     ss$Replicate[idx]=1:sum(idx)
#     }
#   }
# }

# make PCAs
for (group1 in groups1){
  print(group1)
  ss_i = ss[ss[,group_by1]==group1,]
  if(nrow(ss_i)>2){
    x=FX1(sample_sheet=ss_i,
        out_name=group1,
        n_cores = n_cores,stats_out=T)
  }
  if(group1==groups1[1]){ X = x } else { X=rbind(X,x) }

  for (group2 in groups2){
    print(group2)
    ss_i = ss[ss[,group_by1]==group1 & ss[,group_by2]==group2,]
    if(nrow(ss_i)>2){
      FX1(sample_sheet=ss_i,
          out_name=paste0(group1,"_",group2),
          n_cores=n_cores)
      }
    }
}

write.csv(X,"stats_diffBind.csv",row.names = F,quote=F)

