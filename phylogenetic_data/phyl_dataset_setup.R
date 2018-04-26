library('picante')

superclades<-c("amphibia","aves","crocodylia","mammalia","squamata","testudines")

add_superclade_name<-function(phylogenies,superclade){
  tmp_names<-names(phylogenies)
  for(i in seq_along(phylogenies)){
    phylogenies[[i]]<-c(phylogenies[[i]],"superclade"=superclade)
  }
  names(phylogenies)<-tmp_names
  return(phylogenies)
}

all_phylogenies<-c()
for(i in seq_along(superclades)){
  curr_phylogenies<-readRDS(sprintf('%s_phylogenies.rds',superclades[i]))
  all_phylogenies<-c(all_phylogenies,add_superclade_name(curr_phylogenies,superclades[i]))
  rm(curr_phylogenies)
}

phylogenetic_dataset<-c()
all_names<-c()

for(i in seq_along(all_phylogenies)){
  if(Ntip(all_phylogenies[[i]]$tree) >= 100){
    current_name<-names(all_phylogenies)[i]
    print(current_name)
    all_names<-append(all_names,current_name)
    phylogenetic_dataset <- append(phylogenetic_dataset,all_phylogenies[i])
    rm(current_name)
  }
}
names(phylogenetic_dataset)<-all_names
print(names(phylogenetic_dataset))

saveRDS(phylogenetic_dataset,'phylo_dataset.rds')
