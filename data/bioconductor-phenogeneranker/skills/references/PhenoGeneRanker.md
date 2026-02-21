# PhenoGeneRanker

#### Cagatay Dursun, Jake Petrie

#### 2/18/2020

```
library(PhenoGeneRanker)
```

## Introduction

PhenoGeneRanker is a gene and phenotype prioritization tool that utilizes random walk with restart (RWR) on a multiplex heterogeneous gene-phenotype network. PhenoGeneRanker allows multi-layer gene and phenotype networks. It also calculates empirical p-values of gene ranking using random stratified sampling of genes/phenotypes based on their connectivity degree in the network. It is based on the work from the following paper:

Cagatay Dursun, Naoki Shimoyama, Mary Shimoyama, Michael Schläppi, and Serdar Bozdag. 2019. PhenoGeneRanker: A Tool for Gene Prioritization Using Complete Multiplex Heterogeneous Networks. In Proceedings of the 10th ACM International Conference on Bioinformatics, Computational Biology and Health Informatics (BCB ’19). Association for Computing Machinery, New York, NY, USA, 279–288. DOI: <https://doi.org/10.1145/3307339.3342155>

# Install and Load PhenoGeneRanker

You can install and load the package by running the following commands on an R console:

```
BiocManager::install("PhenoGeneRanker")
library(PhenoGeneRanker)
```

## Using the Functions

* CreateWalkMatrix
* RandomWalkRestart

## Input File Formatting

The CreateWalkMatrix function takes in an *input file* as a parameter. This file is a “.txt” file with two tab-separated columns which holds the network files that PhenoGeneRanker utilizes. The header row should be “type” and “file\_name”. The type column contains the type of the network file. It can be gene, phenotype, or bipartite. The file\_name column stores the name of your network file along with the “.txt” extension. Any number of gene or phenotype files can be used theoretically, but there are practical limits which depend on the capacity of the computer that will run the PhenoGeneRanker.

An example *input file* is shown below:

```
inputDf <- read.table(system.file("extdata", "input_file.txt", package = "PhenoGeneRanker"), header=TRUE, sep="\t", stringsAsFactors = FALSE)
print(inputDf)
#>        type        file_name
#> 1      gene  gene_layer1.txt
#> 2      gene  gene_layer2.txt
#> 3 phenotype ptype_layer1.txt
#> 4 phenotype ptype_layer2.txt
#> 5 bipartite   gene_ptype.txt
```

Inside each of the file\_name files, there are three tab-separeted columns with header “from”, “to”, and “weight”. For the gene and phenotype networks, the “from” and “to” columns will contain the ids of the genes and phenotypes. The “weight” column stores the weight of the relationship between the nodes. If the network is unweighted then weight column should be 1 for all interactions. For the bipartite file, the “from” column must contain gene ids and the “to” column must have phenotype ids.

An example gene network is shown below:

```
geneLayerDf <- read.table(system.file("extdata", inputDf$file_name[1], package = "PhenoGeneRanker"), header=TRUE, sep="\t", stringsAsFactors = FALSE)
print(head(geneLayerDf))
#>   from   to weight
#> 1 g157 g461  0.320
#> 2  g76 g386  0.081
#> 3  g25 g334  0.690
#> 4  g16 g276  1.000
#> 5  g56 g365  1.000
#> 6 g139 g168  0.272
```

An example phenotype network is shown below:

```
ptypeLayerDf <- read.table(system.file("extdata", inputDf$file_name[3], package = "PhenoGeneRanker"), header=TRUE, sep="\t", stringsAsFactors = FALSE)
print(head(ptypeLayerDf))
#>   from   to weight
#> 1  p93 p206  0.006
#> 2   p4 p117  0.043
#> 3  p50 p162  0.753
#> 4  p65 p177  0.782
#> 5  p30 p142  0.705
#> 6  p60 p172  0.001
```

An example bipartite network is shown below:

```
biLayerDf <- read.table(system.file("extdata", inputDf$file_name[5], package = "PhenoGeneRanker"), header=TRUE, sep="\t", stringsAsFactors = FALSE)
print(head(biLayerDf))
#>   from   to weight
#> 1 g364 p445  1.000
#> 2 g507  p61  0.147
#> 3 g360 p262  0.733
#> 4 g530 p190  0.001
#> 5  g99 p439  0.008
#> 6 g333 p384  0.023
```

## CreateWalkMatrix

This function generates a walk matrix (transition matrix) using the gene, phenotype and bipartite networks given in the *inputFileName*. It has to be a ‘.txt’ file. Instructions on how to format the input file and the necessary data files can be found in the [input file formatting](#Input-File-Formatting) section above.

Other parameters have default values. The parameter *numCores* is the number of cores used for parallel processing, it defaults to a value of 1. The parameter *delta* is the probability of jumping between gene layers, and its default value is 0.5. The parameter *zeta* is the probability of jumping between phenotype layers, and its default value is 0.5. The parameter *lambda* is the inter-network jump probability, and its default value is 0.5.

It outputs a list variable which is used by RandomWalkRestart() function.

```
# Generate walk matrix for RandomWalkWithRestart function use
walkMatrix <- CreateWalkMatrix('input_file.txt')
```

This function returns a list containing the walk matrix, a sorted list of genes, a sorted list of phenotypes, the connectivity degree of the genes, the connectivity degree of the phenotypes, the number of gene layers, the number of phenotype layers, the number of genes and the number of phenotypes. You can access each of these elements as shown below.

```
# accesses the walk matrix itself
wm <- walkMatrix[["WM"]]

# sorted genes in the final network
sortedGenes <- walkMatrix[["genes"]]

# sorted phenotypes in the final network
sortedPhenotypes <- walkMatrix[["phenotypes"]]

# the degree of genes in the final network
geneConnectivity <- walkMatrix[["gene_connectivity"]]

# the degree of phenotypes in the final network
phenotypeConnectivity <- walkMatrix[["phenotype_connectivity"]]

# the number of gene layers
numberOfGeneLayers <- walkMatrix[["LG"]]
print(numberOfGeneLayers)
#> [1] 2

# the number of phenotype layers
numberOfPhenotypeLayers <- walkMatrix[["LP"]]
print(numberOfPhenotypeLayers)
#> [1] 2

# the number of genes in the network
numberOfGenes <- walkMatrix[["N"]]
print(numberOfGenes)
#> [1] 712

# the number of phenotypes in the network
numberOfPhenotypes <- walkMatrix[["M"]]
print(numberOfPhenotypes)
#> [1] 450
```

## RandomWalkRestart

This function runs the random walk with restart by utilizing the output of *CreateWalkMatrix* function and gene/phenotype seeds as inputs, and returns the rank of genes/phenotypes with RWR scores and associated p-values if *generatePvalue* parameter is TRUE. *geneSeeds* and *phenoSeeds* parameters are vector type and stores the ids of genes and phenotypes that RWR starts its walk. *generatePValues* determines the generation of P-values along with the ranks of genes and phenotypes. If the parameter *generatePvalue* is FALSE, the function returns a data frame including sorted genes/phenotypes by rank and the RWR scores of the genes/phenotyeps. If *generatePvalue* is TRUE then it generates p-values along with the ranks with respect to offset rank of 100, please see the [paper](https://dl.acm.org/doi/10.1145/3307339.3342155) for details.

The parameter *numCores* takes the number of cores for parallel processing. If *generatePvalue* parameter is TRUE then it is strongly recommended to use all available cores in the computer for shorter run time. Emprical p-values are calculated based on *1000* runs for random gene/phenotype seeds in the network. Number of random runs can be modified using parameter *S*.

In order to control the restart probability of RWR, you can change the *r* parameter value, and it has a default value of 0.7.

The parameter *eta* controls restarting of RWR either to a gene seed or phenotype seeds, higher *eta* means utilizing phenotype network more than gene network, and it has a default value of 0.5.

The parameter *tau* is a vector that stores weights for each of the ‘gene’ layer. Each value of the vector corresponds to the order of the gene layers in the *inputFileName* parameter of CreateWalkMatrix function. The sum of the weights in the *tau* parameter must sum up to the same number of gene layers. *phi* is a vector that stores weights for each of the ‘phenotype’ layer and it has the similar functionality of *tau* parameter for phenotypes. Default values of the two parameters give equal weights to all layers.

Below you can find different examples for *RandomWalkRestart* function calls:

```
# utilizes only gene seeds and generates p-values for ranks using 50 runs with random seeds
ranks <- RandomWalkRestart(walkMatrix, c('g1', 'g5'), c("p1"), S=50)

print(head(ranks))
#>   Node        Score P_value
#> 1 g311 0.0046787019  0.0000
#> 2 g189 0.0043795810  0.0625
#> 3 g315 0.0042789269  0.0000
#> 4 g229 0.0002059928  0.0000
#> 5  g10 0.0000000000  1.0000
#> 6 g100 0.0000000000  1.0000

# utilizes gene and phenotype seeds and does not generate p-values.
ranks <- RandomWalkRestart(walkMatrix, c('g1'), c('p1', 'p2'), generatePValue=FALSE)
print(head(ranks))
#>   Node        Score
#> 1 g311 0.0093574038
#> 2 g189 0.0087591620
#> 3 g229 0.0004119856
#> 4  g10 0.0000000000
#> 5 g100 0.0000000000
#> 6 g101 0.0000000000

# utilizes only gene seeds, custom values for parameters r, eta, tau and phi for a complex network with two gene layers and two phenotype layers.
ranks <- RandomWalkRestart(walkMatrix, c('g1'), c(), TRUE, r=0.8, eta=0.6, tau=c(0.5,  1.5), phi=c(1.5, 0.5))
print(head(ranks))
#>   Node        Score     P_value
#> 1 g311 0.0067117895 0.003003003
#> 2 g189 0.0062980211 0.903614458
#> 3 g229 0.0001891304 0.003003003
#> 4  g10 0.0000000000 1.000000000
#> 5 g100 0.0000000000 1.000000000
#> 6 g101 0.0000000000 1.000000000
```