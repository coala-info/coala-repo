# ClusterJudge

#### Adrian Pasculescu

#### 2025-10-29

## Introduction

The quality of a cluster analysis can be judged based on external information. For example when the clustered entities possess attributes, the total mutual information between the clustering and each of the important and non-redundant attributes of entities might be helpful. Gene Ontology is an example of a system of attributes that can help in assessing gene clustering resulting from genomics or proteomics experiments.
A clustering that `agrees well` with a system of attributes should have a pronounced decrease of the total mutual information when the number of random swaps of entities between clusters is increased (Gibbons and Roth 2002).

The following simple steps must be performed to evaluate a clustering using ClusterJudge:

1. Obtain the clusters as a structure containing entities and their cluster IDs;
2. Obtain the entity-attribute associations and verify the entity-attribute associations for consistency;
3. Often, the number of attributes can be consolidated (reduced) by using a set of *uncertainty* levels;
4. ‘Judge’ the original clustering versus clustering of random changes that are applied to the original data.

## Obtaining the clustering

In most of the cases the clustering is obtained from experimental data after applying some statistical methods such as k-means or cutting a hierarchical clustering at a predefined ‘height’.

The following example extracts the Yeast cell cycle clustering of genes related to the Yeast cell cycle (Cho 1998) (Tavazoie 1999):

```
library('yeastExpData')
```

```
data(ccyclered)
head(ccyclered)
```

```
##   Cluster Distance  Y.name    SGDID  GENE Chromsome  Start    End Introns
## 1       1     0.38 YBL072C S0000168 RPS8A        II  89116  88514       0
## 2       1     0.75 YBL083C S0000179              II  70128  69703       0
## 3       1     0.47 YBR009C S0000213  HHF1        II 255638 255327       0
## 4       1     0.45 YBR010W S0000214  HHT1        II 256285 256695       0
## 5       1     0.47 YBR031W S0000235 RPL4A        II 300122 301210       0
## 6       1     0.53 YBR093C S0000297  PHO5        II 430905 429502       0
##    Exons                                            Description
## 1  1-603              Ribosomal protein S8A (S14A) (rp19) (YS9)
## 2  1-426
## 3  1-312 Histone H4 (HHF1 and HHF2 code for identical proteins)
## 4  1-411 Histone H3 (HHT1 and HHT2 code for identical proteins)
## 5 1-1089                Ribosomal protein L4A (L2A) (rp2) (YL2)
## 6 1-1404                          Acid phosphatase, repressible
```

The clustering should not contain any ambiguities ( i.e. one entity should be assigned to just one cluster) and no NA should be present. For this package, the clusters must be organized as a named vector:

```
clusters <- ccyclered$Cluster
###  convert from Gene names to the new standard of Saccharomyces Genome Database (SGD) gene ids
ccyclered$SGDID <- sub('^S','S00',ccyclered$SGDID)
names(clusters) <- ccyclered$SGDID
str(clusters)
```

```
##  Named int [1:2885] 1 1 1 1 1 1 1 1 1 1 ...
##  - attr(*, "names")= chr [1:2885] "S000000168" "S000000179" "S000000213" "S000000214" ...
```

Note that, in this example, we modified the names of the genes to match the names of entities in the Gene Ontology data (see next section).

## Obtaining Entity Attribute associations

For genomics or proteomics data, one source of attributes is the Gene Ontology (<http://www.geneontology.org/>). For Yeast Gene Ontology attributes can also be downloaded from the [Saccharomyces Genome Database (SGD)] (<http://www.yeastgenome.org/>) In the ClusterJudge R package there is already a downloaded mapping of Yeast genes to attributes:

```
data(Yeast.GO.assocs);
str(Yeast.GO.assocs);
```

```
## 'data.frame':    70487 obs. of  2 variables:
##  $ SGDID: chr  "S000007287" "S000007287" "S000007287" "S000007288" ...
##  $ GOID : chr  "GO:0005763" "GO:0032543" "GO:0003735" "GO:0005762" ...
```

```
head(Yeast.GO.assocs);
```

```
##        SGDID       GOID
## 1 S000007287 GO:0005763
## 2 S000007287 GO:0032543
## 3 S000007287 GO:0003735
## 4 S000007288 GO:0005762
## 5 S000007288 GO:0032543
## 6 S000007288 GO:0003735
```

```
validate_association(Yeast.GO.assocs)
```

```
## [1] "Validation OK!"
```

```
## [1] TRUE
```

The *download\_Yeast\_GO\_mapping()* function is also available to download a fresh copy of the mapping.

For other species one can use specialized R and Bioconductor packages such as biomaRt as in the following `toy` example.

```
library(biomaRt)
rn <-  useDataset("rnorvegicus_gene_ensembl", mart=useMart("ensembl"))
rgd.symbol=c("As3mt", "Borcs7", "Cyp17a1", "Wbp1l", "Sfxn2", "Arl3") ### exemplify for a limited set of  genes
entity.attr  <- getBM(attributes=c('rgd_symbol','go_id'), filters='rgd_symbol', values=rgd.symbol, mart=rn)
```

The *validate\_association()* function quickly verifies if the input structure has two columns, if there are no NAs or NULLs and if there are no duplicated associations.

## Consolidating Entity-Attribute associations

In some cases, the attributes may not bring additional useful information. For example, an attribute may be too specific as it is only assigned to one or two genes (e.g. it may simply be a new name of a gene). In other cases, two or more attributes may be very correlated and appear on almost the same set of genes.

For the first case a consolidated association will ignore those attributes that belong to very few genes (*min.entities.per.attr*)

```
entities_attribute_stats(Yeast.GO.assocs) ### shows number of entities per attribute distribution
```

![](data:image/png;base64...)

```
## [1] 3
```

```
Yeast.GO.assocs.cons1 <- consolidate_entity_attribute(
       entity.attribute = Yeast.GO.assocs
     , min.entities.per.attr =3  ### keep only attributes associated to 3 or more entities
     , mut.inf=FALSE
     )

dim(Yeast.GO.assocs)
```

```
## [1] 70487     2
```

```
dim(Yeast.GO.assocs.cons1) ### shows reduction in the number of associations
```

```
## [1] 64738     2
```

For the second case we use the pre-calculated mutual information (Cover 1991) between attributes and impose a maximum *uncertainty* level where uncertainty is defined as mutual information divided by the maximum of mutual information.

```
data(mi.GO.Yeast)
Yeast.GO.assocs.cons <- consolidate_entity_attribute(
     entity.attribute = Yeast.GO.assocs
   , min.entities.per.attr =3
   , mut.inf=mi.GO.Yeast   ### use precalculated mutual information
   , U.limit = c(0.1, 0.001) ### calculate consolidated association for these uncertainty levels
   ) ### shows distribution of the number of pairs of attributes by Uncertainty
```

![](data:image/png;base64...)

```
## ....
## [1] "For the uncertainty limit 0.1 removed: 74 attributes"
## .........................
## [1] "For the uncertainty limit 0.001 removed: 1939 attributes"
```

```
str(Yeast.GO.assocs.cons)
```

```
## List of 2
##  $ 0.1  :'data.frame':   43899 obs. of  2 variables:
##   ..$ SGDID: chr [1:43899] "S000007287" "S000007287" "S000007288" "S000007288" ...
##   ..$ GOID : chr [1:43899] "GO:0005763" "GO:0032543" "GO:0005762" "GO:0032543" ...
##  $ 0.001:'data.frame':   2517 obs. of  2 variables:
##   ..$ SGDID: chr [1:2517] "S000004660" "S000000289" "S000003916" "S000005275" ...
##   ..$ GOID : chr [1:2517] "GO:0005471" "GO:0005471" "GO:0018456" "GO:0018456" ...
```

The lower the Uncertainty limit the more attributes are ignored and the faster the judging of clusters will be performed.

## Calculating the mutual information

In the case where the entity-attributes associations are downloaded from other organisms or other sources, mutual information can be calculated using this function: *attribute\_mut\_inf* :

```
data(Yeast.GO.assocs)
### because it takes time, we use a small sampled subset of associations
entity.attribute.sampled <- Yeast.GO.assocs[sample(1:nrow(Yeast.GO.assocs),100),]
mi.GO.Yeast.sampled <- attribute_mut_inf(
    entity.attribute = entity.attribute.sampled
  , show.progress    = FALSE  ## for this small example do not print progress
  )
str(mi.GO.Yeast.sampled)
```

```
##  num [1:74, 1:74] NA NA NA NA NA NA NA NA NA NA ...
##  - attr(*, "dimnames")=List of 2
##   ..$ : chr [1:74] "GO:0000122" "GO:0000307" "GO:0000329" "GO:0000400" ...
##   ..$ : chr [1:74] "GO:0000122" "GO:0000307" "GO:0000329" "GO:0000400" ...
```

The mutual information of the pair of attributes A,B is defined as mi(A,b) = H(A)+H(B) - H(cbind(A,B)) where H is the entropy.

## Judging the clustering for selected `uncertainty` levels

The *clusters* named vector prepared above and one of the consolidated entity-attribute associations (for example the one at 0.001 level of Uncertainty) are needed at this step. The *ClusterJudge* will swap at random more and more entities between clusters and will calculate and plot the new total mutual information obtained at each iteration. If the total mutual information decreases by increasing the number of random swaps we can conclude that there is a good agreement between the clustering of experimental data and the ensemble of information provided by the entity-attribute associations.

```
mi.by.swaps<-clusterJudge(
    clusters = clusters
  , entity.attribute=Yeast.GO.assocs.cons[["0.001"]]
  , plot.notes='Yeast clusters judged at uncertainty level 0.001 - Ref: Tavazoie S,& all
`Systematic determination of genetic network architecture. Nat Genet. 1999`'
, plot.saveRDS.file= 'cj.rds') ### save the plot for later use
```

```
## randomizing clusters ..............
```

![](data:image/png;base64...)

```
p <- readRDS('cj.rds') ### retrieve the previous plot
pdf('cj.pdf'); plot(p); dev.off() ### plot on another device
```

```
## png
##   2
```

In most of the cases mutual information should have a decreasing trend when the number of shuffles increases. However, in rare cases, a consistent increasing trend might suggest novel discoveries; only when both experimental data and clustering are *very reliable*. In these rare cases a *high confident* clustering might complement or even contradict information accumulated in time into entity-attribute associations.

*ClusterJudge* can also be seen as a complement to many of the Bioconductor packages related to evaluation and comparison of Clustering (such as [clustComp](http://www.bioconductor.org/packages/devel/bioc/html/clustComp.html), [clusterExperiment](http://www.bioconductor.org/packages/devel/bioc/html/clusterExperiment.html), [clusterSignificance](http://www.bioconductor.org/packages/devel/bioc/html/ClusterSignificance.html), [GOpro](http://www.bioconductor.org/packages/devel/bioc/html/GOpro.html), [multiClust](http://www.bioconductor.org/packages/devel/bioc/html/multiClust.html) ).

## References

Cho, R. C. et all. 1998. “A Genome-Wide Transcriptional Analysis of the Mitotic Cell Cycle.” *Molecular Cell*. Science Direct.

Cover, T. M. et all. 1991. “Elements of Information Theory.” *Book*. Wiley-Interscience.

Gibbons, F. D, and F. P. Roth. 2002. “Judging the Quality of Gene Expression-Based Clustering Methods Using Gene Annotation.” *Genome Research*. Genome Research.

Tavazoie, S. et all. 1999. “Systematic Determination of Genetic Network Architecture.” *Nature Genetics*. Nature Publishing Group.