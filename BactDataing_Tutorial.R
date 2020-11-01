---
  title: "Application of BactDating on S. aureus ST239"
author: "Xavier Didelot"
---
  #In this vignette we demonstrate the usage of BactDating on a dataset of
  #Staphylococcus aureus ST239 published by Harris et al (2010).
  #The data for this example can be loaded using the command `data(staph)`.
  #This will load in your environment the object `staph` which is made of two parts. 
  #The first part, `staph$tree`, is a phylogenetic tree class `phylo` from the `ape` package.
  #The second part, `staph$dates`, is a vector containing the dates of isolations of the genomes.
  #Note that this vector is in the same order as the tips of the tree listed in `staph$tree$tip.label`.
  
  ##INSTALLATION OF NECESSARY PACKAGES AND LOAD THE LIBRARIES 
  #install phylogenetic program ape
  install.packages("ape")

#Install the program BactDating
install.packages("devtools")
library(devtools)

#Install the program BactDatcing
devtools::install_github("xavierdidelot/BactDating")

#Load the libraries
library(ape)
library(BactDating)


set.seed(0)
#Load the dataset for the tutorial/vignette
data(staph)

#Plot the phylogeny
#staph$tree is a phylogenetic tree with 58 tips and 57 internal nodes.
plot(staph$tree, show.tip.label = F)
axisPhylo(backward = F)

#Conduct Root-to-tip analysis to test for temporal signal
#The phylogeny on the left has the tips colored by collection date
#The figure on the right shows the correlation between sampling time and root-2-tip distance
res=roottotip(staph$tree,staph$dates)

## Coalescent Analysis

#We can run BactDating as follows. Note that here we only perform 1000 iterations of the MCMC to keep to building time of this vignette low, but in practice you should run the MCMC for as long as possible.

res=bactdate(unroot(staph$tree),staph$dates,nbIts=1000)
plot(res,'treeCI',show.tip.label = F)

#We can see what the MCMC traces look like:
plot(res,'trace')

#Let's see where the root is likely to be:
plot(res,'treeRoot',show.tip.label=F)
