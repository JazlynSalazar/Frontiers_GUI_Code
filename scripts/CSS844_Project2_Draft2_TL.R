#Tom's .trt file creator (WIP)
#Use trait.list for the input responses (traits to include checklist)
trait.list<-c("Endosperm Color", "Oil Percentage", "Plant Height", "Notes and Remarks")
trait_file<-data.frame("trait"=trait.list,"format"="","defaultValue"="","minimum"="","maximum"="",
                       "details"="","categories"="","isVisible"=TRUE,"realPosition"=seq(from=1, to=length(trait.list), by=1))

category1<-c("White/Yellow/Purple/Green/Blue/Red/Pink/Orange/None")
descriptor1<-c("Color")

for (i in 1:nrow(trait_file)){
  if (trait_file[i,1]=="Primary Race"){
    trait_file[i,2]<-"text"
  }
  else if (trait_file[i,1]=="Secondary Race"){
    trait_file[i,2]<-"text"
  }
  else if (trait_file[i,1]=="Kernel Type"){
    trait_file[i,2]<-"text"
  }
  else if (trait_file[i,1]=="Kernel Color"){
    trait_file[i,2]<-"multicat"
    trait_file[i,6]<-descriptor1
    trait_file[i,7]<-category1
  }
  else if (trait_file[i,1]=="Cob Color"){
    trait_file[i,2]<-"multicat"
    trait_file[i,6]<-descriptor1
    trait_file[i,7]<-category1
  }  
  else if (trait_file[i,1]=="Kernel Row Arrangement"){
    trait_file[i,2]<-"text"
  }  
  else if (trait_file[i,1]=="Upper Kernel Shape"){
    trait_file[i,2]<-"text"
  }  
  else if (trait_file[i,1]=="Plant Vigor"){
    trait_file[i,2]<-"text"
  }  
  else if (trait_file[i,1]=="Root lodging"){
    trait_file[i,2]<-"text"
  }  
  else if (trait_file[i,1]=="Stalk lodging"){
    trait_file[i,2]<-"text"
  }  
  else if (trait_file[i,1]=="AES Maturity"){
    trait_file[i,2]<-"text"
  }  
  else if (trait_file[i,1]=="Endosperm Color"){
    trait_file[i,2]<-"multicat"
    trait_file[i,6]<-descriptor1
    trait_file[i,7]<-category1
  }  
  else if (trait_file[i,1]=="Ear Shape"){
    trait_file[i,2]<-"text"
  }  
  else if (trait_file[i,1]=="Aleurone Color"){
    trait_file[i,2]<-"multicat"
    trait_file[i,6]<-descriptor1
    trait_file[i,7]<-category1
  }  
  else if (trait_file[i,1]=="Pericarp Color"){
    trait_file[i,2]<-"multicat"
    trait_file[i,6]<-descriptor1
    trait_file[i,7]<-category1
  }  
  else if (trait_file[i,1]=="Glume development"){
    trait_file[i,2]<-"text"
  }  
  else if (trait_file[i,1]=="Colored Silk Scar"){
    trait_file[i,2]<-"text"
  }  
  else if (trait_file[i,1]=="Notes and Remarks"){
    trait_file[i,2]<-"text"
  }  
  else if (trait_file[i,1]=="Popping Expansion"){
    trait_file[i,2]<-"text"
  }  
  else if (trait_file[i,1]=="Stewarts Wilt"){
    trait_file[i,2]<-"text"
  }  
  else if (trait_file[i,1]=="Gray Leaf Spot"){
    trait_file[i,2]<-"text"
  }  
  else if (trait_file[i,1]=="Maize Dwarf Mosaic Virus"){
    trait_file[i,2]<-"text"
  }  
  else if (trait_file[i,1]=="Eyespot"){
    trait_file[i,2]<-"text"
  }  
  else if (trait_file[i,1]=="Diploidia Ear Rot"){
    trait_file[i,2]<-"text"
  }  
  else if (trait_file[i,1]=="Antracnose Stalk Rot"){
    trait_file[i,2]<-"text"
  }  
  else if (trait_file[i,1]=="Northern Leaf Blight Race O"){
    trait_file[i,2]<-"text"
  }  
  else if (trait_file[i,1]=="Common Rust Race RP1-D"){
    trait_file[i,2]<-"text"
  }  
  else if (trait_file[i,1]=="Tassel Type"){
    trait_file[i,2]<-"text"
  }  
  else if (trait_file[i,1]=="Goss's Wilt"){
    trait_file[i,2]<-"text"
  }  
  else if (trait_file[i,1]=="Head Smut"){
    trait_file[i,2]<-"text"
  }  
  else trait_file[i,2]<-"numeric"}

#Creating .trt file
write.table<-write.table(trait_file, sep=",", quote=T, file="traits.trt", row.names=F, col.names=T)

