## step13d_cladesTable.R
## make a data structure with information about primate transposons and their classfications
options(stringsAsFactors=F)
setwd("C:/Users/sepid/Documents/Geschwind_Lab/CONTE_NHP_MIA")

clades<-read.csv("TE_clades.csv",header=T,na.strings=c("","NA"))
fasta<-readLines("primateTE.fa")
keeplines=fasta[grep("^>",fasta)]
n_elements=length(keeplines)

TE_list=data.frame(matrix(NA,n_elements,3))
colnames(TE_list)=c("element","classification","organism")

## define functions
## takes in index of line and parses into TE name, classification, and organism
## stores those values in TE_list
parseLine <- function(index){
  line=keeplines[index]
  line=sub(">","",line)
  entries<-unlist(strsplit(line,"\t"))
  TE_list$element[index]<<-entries[1]
  TE_list$classification[index]<<-entries[2]
  TE_list$organism[index]<<-entries[3]
  return(NULL)
}

## go through taxa from lowest to highest--if the keyword is found, return that level
findLowestLevel <- function(keyword){
  level=NA
  families=na.omit(unique(clades$family))
  superfamilies=unique(clades$superfamily)
  classes=unique(clades$class)
  
  if (keyword %in% families){level="family"}
  else if(keyword %in% superfamilies){level="superfamily"}
  else if(keyword %in% classes){level="class"}
  
  return(level)
}
  

  
## write name, classficiation, organism for elements to TE_list  
invisible(sapply(1:n_elements,parseLine))

## match the elements/their classifcation from the FASTA to the taxonomic levels in TE_clades.csv
lowest_level=sapply(TE_list$classification,findLowestLevel)

## append full taxonomic info and drop classification column from data frame
TE_list$class=NA
TE_list$superfamily=NA
TE_list$family=NA
for (i in 1:n_elements){
    ll=lowest_level[i]
    c=TE_list$classification[i]
  if (is.na(ll)){
    next
  }else if (ll=="family"){ 
    TE_list$family[i]=c
    clade_row=which(clades$family==c)[1]
    TE_list$superfamily[i]=clades$superfamily[clade_row]
    TE_list$class[i]=clades$class[clade_row]
  }else if (ll=="superfamily"){
    TE_list$superfamily[i]=c
    clade_row=which(clades$superfamily==c)[1]
    TE_list$class[i]=clades$class[clade_row]
  }else if (ll=="class"){
    TE_list$class[i]=c
  }
}

TE_list<-TE_list[-match("classification",colnames(TE_list))]
write.csv(TE_list,"TE_list.csv")


sig=c("L1PB4","HERVL","MER39B","MER1B","LTR5A","LTR13A","HERV9","MLT2A2","AluSx4","SVA_F","MER68B","L1MA3","MSTD","HSMAR1")
TE_list[TE_list$element %in% sig,]
