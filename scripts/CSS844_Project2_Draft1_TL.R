#Preliminary .trt file creation script
#3/31/2026
#Tomas Lopes

trait_names<-c("height", "stem_color", "insect_damage", "flower_color")
format<-c("numeric", "categorical", "boolean", "multicat")

trait_file<-data.frame("trait"=trait_names,"format"=format,"defaultValue"=NA,"minimum"=NA,"maximum"=NA,
                       "details"=NA,"categories"=NA,"isVisible"=TRUE,"realPosition"=seq(from=1, to=length(format), by=1))
#Specifying categories/units
category1<-c("Blue/Green/Orange/Teal")
descriptor1<-c("Color")
#Changing trait_file values depending on format (i.e: if percent, minvalue=0, max=100)

for (i in 1:nrow(trait_file)){
  if (trait_file[i,2]=="numeric"){
    trait_file[i,6]<-"units"
  }
  else if (trait_file[i,2]=="categorical"){
    trait_file[i,6]<-descriptor1
    trait_file[i,7]<-category1
  }
  else if (trait_file[i,2]=="percent"){
    trait_file[i,4]<-"0"
    trait_file[i,5]<-"100"
  }
  else if (trait_file[i,2]=="boolean"){
    trait_file[i,3]<-"FALSE"
  }
  else if (trait_file[i,2]=="multicat"){
    trait_file[i,7]<-category1
  }
  else if (trait_file[i,2]=="angle"){
    trait_file[i,6]<-"degrees"
  }
}

#Creating .trt file
write.csv(trait_file, "traitcsv.csv")
traitcsv<-read.csv("")
write.table<-write.table(trtcsv, sep=",", quote=T, file="traits.trt", row.names=F, col.names=F)