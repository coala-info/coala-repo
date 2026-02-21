# NoRCE: Noncoding RNA Set Cis Annotation and Enrichment

# NORCE

## General Information

NoRCE provides a comprehensive, systematical, user-friendly pipeline for preprocessing, annotation, and enrichment of all types of ncRNA genes, such as lncRNA, mature and precursor miRNA, snoRNA, siRNA, and circular RNA. NoRCE analyses are based on spatially proximal mRNAs at a certain distance for a set of non-coding RNA genes or regions of interest. Moreover, specific analyses such as biotype filtering, miRNA-mRNA co-expression analysis, and miRNA target predictions can be performed for filtering. Besides, it allows curating the gene set according to the topologically associating domain (TAD) boundaries. NoRCE accepts gene lists and gene regions as input.

![NoRCE Workflow](data:image/png;base64...)

### Supported Assemblies and Organisms

NoRCE supports many organisms and assemblies. To work with supported organisms, the user must provide the organism assembly, `org_assembly`, with a keyword listed in the below table.

| Organisms | Assemblies | Keyword |
| --- | --- | --- |
| Homo Sapiens | hg19 | hg19 |
| Homo Sapiens | hg38 | hg38 |
| Mus Musculus | mm10 | mm10 |
| Rattus Norvegicus | rn6 | rn6 |
| Danio Rerio | danRer10 | dre10 |
| Caenorhabditis Elegans | ce11 | ce11 |
| Saccharomyces Cerevisiae | sc3 | sc3 |
| Drosophila Melanogaster | dm6 | dm6 |

## Installation

To install and load NoRCE:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("NoRCE")
```

To load the NoRCE:

```
library(NoRCE)
```

Moreover, NoRCE can be downloaded from the [GitHub repository](https://github.com/guldenolgun/NoRCE).

## Changing Parameter Setting

NoRCE gives freedom to the user. However, most of the parameters are set to their default value. To change those parameters listed in the [Default Parameters](#default-parameters) section, the `setParameters` function should be called, and parameters and their user-defined values should be defined. The table in the [Default Parameters](#default-parameters) section illustrates the possible parameters and their values.

```
type <- c('downstream','upstream')

value <- c(2000,30000)
setParameters(type,value)

#To change the single parameter
setParameters("pathwayType","reactome")
```

## GO Enrichment

GO enrichment analysis can be performed based on gene neighborhood, predicted targets, co-expression values, and/or considering topological domain boundaries. *HUGO*, *ENSEMBL gene*, *ENSEMBL transcript gene*, *ENTREZ ID*, and *miRBase* names are supported formats for the input gene list. Moreover, NoRCE accepts a list of genomic regions. The input genomic region list should be in a BED format.

Each analysis is controlled by corresponding parameters. When related parameters are set, the gene sets resulting from the intersection of those analyses will be considered for enrichment analysis. However, co-expression analysis can be augmented with other analyses.

GO enrichment pipeline analysis is carried out with `geneGOEnricher` and `geneRegionGOEnricher` functions for an input gene set and regions, respectively. Also, the miRNA gene enrichment pipeline is carried out with `mirnaGOEnricher` and `mirnaRegionGOEnricher` functions. However, the user can use other functions to perform the analysis’s subparts. Species assembly must be defined using the `org_assembly` parameter provided in the Keyword column in the table above. NoRCE allows the user to use a background gene set.

### Enrichment Analysis Based on Gene Neighbourhood

When the `near` parameter is set to `TRUE`, the closest genes for the input gene list are retrieved. The gene neighborhood taken into consideration is controlled by the `upstream` and `downstream` parameters. By default, those parameters are set to 10 kb, and all genes that fall into 10 kb upstream and downstream of the input genes are retrieved. Also, using the `searchRegion` parameter, the analysis can be performed for only those genes whose exon or intron regions fall into the specified upstream and downstream range of the input genes.

To perform enrichment analysis based on considering only gene neighborhood:

```
#Set the neighbourhood region as exon
ncGO<-geneGOEnricher(gene = brain_disorder_ncRNA, org_assembly='hg19', near=TRUE, genetype = 'Ensembl_gene')
```

To perform enrichment analysis based on exon neighbourhood:

```
#Set the neighbourhood region as exon
setParameters("searchRegion", "exon")

#NoRCE automatically consider only the exon of the genes
ncGO<-geneGOEnricher(gene = brain_disorder_ncRNA, org_assembly='hg19', near=TRUE, genetype = 'Ensembl_gene')
```

NoRCE accepts the BED formatted input gene regions. To perform the enrichment analysis on gene regions:

```
#Change back to all search regions
setParameters("searchRegion", "all")

#Import the gene set regions
regions<-system.file("extdata", "ncRegion.txt", package = "NoRCE")
regionNC <- rtracklayer::import(regions, format = "BED")

#Perform the analysis on the gene regions
regionGO<-geneRegionGOEnricher(region = regionNC, org_assembly= 'hg19', near = TRUE)
```

### Enrichment Analysis Based on Target Prediction

For a set of miRNA genes, the user can filter the gene set using miRNA target predictions. This analysis is controlled by the `target` parameter. Once the `target` parameter is set to `TRUE`, TargetScan predictions are used to curate the gene list that will be enriched.

To perform GO enrichment based on neighboring coding genes of brain miRNA targeted by the same brain miRNA gene set.

```
mirGO<-mirnaGOEnricher(gene = brain_mirna, org_assembly='hg19', near=TRUE, target=TRUE)
```

### Enrichment Analysis Based on Topological Associating Domain Analysis

Gene annotation based on topologically associating domain regions is conducted whether ncRNAs fall into the TAD boundaries and coding gene assignment; only those that are in the same TAD boundaries are included in the neighborhood coding gene set. If cell line (s) for TAD boundaries are specified, only regions that are associated with the given cell line (s) are considered. User-defined and pre-defined TAD boundaries can be used to find potential gene set list for enrichment. For human, mouse, and fruit fly, pre-defined TAD boundaries are supplied, and custom TAD boundaries must be in a BED format. The `cellline` parameter controls cell lines. Cell lines can be listed with the `listTAD` function.

To perform enrichment based on TAD boundaries that also fall into the noncoding gene’s neighborhood

```
mirGO<-mirnaGOEnricher(gene = brain_mirna, org_assembly='hg19', near=TRUE, isTADSearch = TRUE, TAD = tad_hg19)
```

User-defined TAD regions can be used as input for the TAD regions, and gene enrichment can be performed based on these custom TAD regions. The `TAD` parameter is provided to input the bed formatted TAD regions.

```
# Read the custom TAD boundaries
cus_TAD<-system.file("extdata", "DER-18_TAD_adultbrain.txt", package = "NoRCE")
tad_custom <- rtracklayer::import(cus_TAD, format = 'bed')

# Use custom TAD boundaries for enrichment
ncGO_tad <- geneGOEnricher(gene = brain_disorder_ncRNA, org_assembly = 'hg19', genetype = 'Ensembl_gene', isTADSearch = TRUE, TAD = tad_custom)
```

To retrieve the list of cell-lines from the given TAD boundaries:

```
a<-listTAD(TADName = tad_hg19)
```

### Enrichment Analysis Based on Correlation Analysis

Enrichment based on correlation analysis is conducted with the binary `express` parameter. For a given cancer, a pre-calculated Pearson correlation coefficient between miRNA-mRNA and miRNA-lncRNA expressions can be used to augment or filter the results. Users can define the correlation coefficient cutoff and cancer of interest with the `minAbsCor` and `cancer` parameters, respectively. [miRCancer.db](https://figshare.com/articles/miRCancer_db_gz/5576329), the pre-computed miRNA-mRNA and miRNA-lncRNA correlation database must be downloaded to the local, and the path of the database must be given as an input to a `databaseFile` parameter.

```
ncGO_tad <- geneGOEnricher(gene = brain_disorder_ncRNA, org_assembly = 'hg19', genetype = 'Ensembl_gene',near = TRUE, express = TRUE, databaseFile = '\\miRCancer\\miRCancer.db', cancer = 'GBMLGG')
```

Two custom-defined expression data can be utilized to augment or filter the coding genes that are found using the previous analysis. To make this option on, the `isCustomExp` parameter has to be set to `TRUE`, and custom expressions should be inputted into the `exp1` and `exp2` parameters. Expression data must be patient by gene data, and headers should be gene names. If no header is defined, `label1` and `label2` must be used to define the headers. The correlation cutoff can be specified with the `minAbsCor` parameter.

To perform GO enrichment for the intersection of the miRNA targets and custom RNAseq expression of miRNA and mRNA data in the NoRCE repository:

```
# miRNA targets and custom RNAseq expression of miRNA and mRNA are used
miGO1 <- mirnaGOEnricher(gene = brain_mirna, org_assembly = 'hg19', target = TRUE, express = TRUE, isCustomExp = TRUE, exp1 = mirna, exp2 = mrna)
```

To augment the results, `isUnionCorGene` parameter has to set to `TRUE`.

```
# Union of miRNA targets and custom RNAseq expression of miRNA and mRNA is utilized for enrichment analysis
miGO1 <- mirnaGOEnricher(gene = brain_mirna, org_assembly = 'hg19', target = TRUE, express = TRUE, isCustomExp = TRUE, exp1 = mirna, exp2 = mrna, isUnionCorGene = TRUE)
```

## Pathway Enrichment

### Enrichment on KEGG, Reactome, WikiPathways

As in GO enrichment analysis, pathway enrichment analysis can be performed based on gene neighborhood, predicted targets, correlation coefficient, and/or topological domain analysis. Each parameter is controlled by the related parameters, and *HUGO*, *ENSEMBL gene*, *ENSEMBL transcript*, *ENTREZ ID*, and *miRBase* name is supported for the input gene list. Non-coding genes can be annotated and enriched with KEGG, Reactome, and Wiki pathways. `genePathwayEnricher` and `geneRegionPathwayEnricher` functions fulfill the pathway enrichment for the genes and regions expect the miRNA genes and for the miRNA `mirnaPathwayEnricher` and `mirnaRegionPathwayEnricher` is used. By default, KEGG enrichment is performed.

```
# KEGG enrichment is performed
miPathway <- mirnaPathwayEnricher(gene = brain_mirna, org_assembly = 'hg19', near = TRUE, target = TRUE)
```

To perform Reactome and Wiki enrichment

```
# Change the pathway database
setParameters("pathwayType","reactome")

nc2 <- genePathwayEnricher(gene = brain_disorder_ncRNA, org_assembly =  'hg19', near = TRUE, genetype = 'Ensembl_gene')

# Wiki pathway Enrichment

# Change the pathway database type and multiple testing correction method
type <- c('pathwayType', 'pAdjust')
value<-c('wiki', 'bonferroni')
setParameters(type,value)
nc2 <- genePathwayEnricher(gene = brain_disorder_ncRNA, org_assembly =  'hg19', near = TRUE, genetype = 'Ensembl_gene')
```

### Enrichment on Custom GMT File

Moreover, pathway enriched can be performed based on a custom GMT file. GMT file supports both gene format of ENTREZ ID, Symbol and it is controlled by the `isSymbol` parameter.

```
setParameters("pathwayType","other")

# Name of the gmt file in the local
wp.gmt <- "custom.gmt"

# GMT file should be on the working directory
ncGO_bader <- genePathwayEnricher(gene = brain_disorder_ncRNA, org_assembly = 'hg19',genetype = 'Ensembl_gene',gmtName = wp.gmt)
```

## Biotype Specific Analysis

Users can work with only biotypes of interest or extract some biotypes from the gene list of interest. The `filterBiotype` function should be called to get the biotype-specific gene list. The path of the GTF file or the path of the zipped GTF file must be provided.

```
biotypes <- c('unprocessed_pseudogene','transcribed_unprocessed_pseudogene')

#Temp.gft is a subset of GENCODE Long non-coding RNA gene annotation
fileImport<-system.file("extdata", "temp.gtf", package = "NoRCE")

extrResult <- filterBiotype(fileImport, biotypes)
```

Moreover, users can collect the input gene list’s gene biotype relationships using `extractBiotype` function from the given GTF formatted file.

```
#Extract biotype gene interactions from the given GTF formatted file
fileImport<-system.file("extdata", "temp.gtf", package = "NoRCE")

#Creates 2 dimensional input Gene-Biotype matrix
gtf <- extractBiotype(gtfFile = fileImport)
```

## Visualization

NoRCE allows us to visualize the enrichment results for pathway and GO enrichments in several forms.

### Tabular Format

Users can write the results in a tabular format in a TXT file. The `writeEnrichment` function should be called to save the result in a tabular format. Users can write sorted all or their defined number of enrichment results using the `n` parameter. If the `n` parameter is not specified, all results will be included in the tabular format. Results are sorted based on p-value or p-adjusted value. Users should use the `type` parameter to identify their sort preferences. By default, results are sorted based on the p-adjusted value. By default, it is tab-separated, but the users can use their preferred separator.

The tabular format contains those fields: GO/pathway ID, pathway/GO term, p-value, p-adjust, gene ratio, background gene ratio, number of enriched genes, annotated gene list with the enriched terms, input noncoding gene list that is annotated with enriched protein-coding genes.

```
writeEnrichment(mrnaObject = ncGO,fileName = "result.txt",sept = "\t",type = "pvalue")

writeEnrichment(mrnaObject = ncGO,fileName = "result.txt",sept = "\t",type = "pvalue", n = 5)
```

### Dot Plot

Results can be visualized in the dot plot. Top enrichment results according to p-value or p-adjust value are provided. Also, the number of annotated genes with the enriched term is supplied. Users have the option to select a p-value or p-adjust value for visualization with the `type` parameter; also, the `n` parameter should be used for top enrichment results. Dot plots can be used for pathway and GO enrichment.

```
drawDotPlot(mrnaObject = ncGO, type = "pvalue", n = 25)
```

![](data:image/png;base64...)

### Network

NoRCE generates gene - enriched terms network to present the relationship between terms and enriched results. Same with dot plots, `type` parameter and `n` parameter can be utilized. By default, nodes are the enriched terms and annotated genes; edges represent the relationship. However, the users can choose to generate a network where nodes input noncoding gene lists that are annotated with enriched protein-coding genes instead of protein-coding genes. This is controlled by the boolean `isNonCode` parameter. If `isNonCode` parameter is set to `TRUE`, input noncoding genes are utilized. Also, by default, they are used for network generation, but users can construct a network with GO IDs or pathway IDs instead of GO-term/pathway-terms. This option is controlled by the boolean  `takeID` parameter. If it is set to `TRUE`, the naming decision of the GO/pathway node is GO ID-pathway ID. This network can be used for the pathway and GO enrichment findings.

```
createNetwork(mrnaObject = ncGO, type = 'pvalue', n = 2, isNonCode = TRUE)
```

![](data:image/png;base64...)

### GO DAG

NoRCE draws the GO directed acyclic graph for a given number of enrichments. Enriched GO terms are colored in terms of their p-value or p-adjust value. Users can download PNG or SVG formatted DAGs.

```
getGoDag(mrnaObject = ncGO,type = 'pvalue', n = 2,filename = 'dag.png', imageFormat = "png")
```

![](data:image/png;base64...)

### Reactome and KEGG Map

Reactome and KEGG pathway maps can be generated in a browser. Users should select the enriched pathway, `pathway`. Even though the Reactome map is visualized in the browser, the user can select PNG or SVG as an image format with `imageFormat` parameter.

```
getKeggDiagram(mrnaObject = ncRNAPathway, org_assembly ='hg19', pathway = ncRNAPathway@ID[1])
```

```
getReactomeDiagram(mrnaObject = ncRNAPathway, pathway = miGO1@ID[3], imageFormat = "png")
```

## Extra Analysis

### Getting miRNA Targets

You can get the miRNA targets for a given input. The output is miRNA-mRNA target pairs.

```
target <- predictmiTargets(gene = brain_mirna[1:100,],
                     org_assembly = 'hg19', type = "mirna")
```

### Custom Co-expression Analysis

NoRCE can also perform co-expression analysis between two datasets. `exp1` and `exp2` parameters take expression data, and each column must contain gene expression. If the expression data does not contain the header information, `label1` and `label2` parameters must be used for this information. `calculateCorr` function calculates the variance of each gene’s expression, and genes that vary lesser than the user-defined variance cut-off, `varCutoff`, are excluded from the analysis. The users can select their preferred correlation method, `corrMethod`, with an alternative hypothesis, `alternate` for a given p-value, confidence and minimum correlation cut-off, `pcut`, `conf`, and `corCutoff`, respectively.

```
corAnalysis<-calculateCorr(exp1 = mirna, exp2 = mrna )
```

### Identifying GO Annotations For the Given Genes

NoRCE can identify the GO annotatıon for a given gene set. To only annotate the genes with GO terms, `annGO` function should be called. The input gene list should be in the HUGO gene format.

```
geneList <- c("FOXP2","SOX4","HOXC6")

annot <- annGO(genes = geneList, GOtype = 'BP',org_assembly = 'hg19')[[2]]
```

### Get Closeby Genes

User can detect closeby genes in a given upstream and downstream ranges. `annGO`

```
neighbour <- getUCSC(bedfile = regionNC,
                    upstream = 1000,
                    downstream = 1000,
                    org_assembly = 'hg19')
```

## Default Parameters

| Parameter | Possible or Example Values |
| --- | --- |
| upstream | Numeric Interval in bp, Ex: 100 |
| downstream | Numeric Interval in bp. Ex: 100 |
| searchRegion | ‘all’,‘exon’,‘intron’ |
| GOtype | ‘BP’, ‘CC’, ‘MF’ |
| pCut | Threshold value for the pvalue. Range between [0,1]. Ex: 0.05 |
| pAdjCut | Threshold value for the adjusted pvalue. Range between [0,1]. Ex: 0.05 |
| pAdjust | ‘holm’,‘hochberg’,‘hommel’,‘bonferroni’, ‘BH’, ‘BY’,‘fdr’, ‘none’ |
| enrichTest | ‘hyper’, ‘binom’, ‘fisher’, ‘chi’ |
| varCutoff | Variance cutoff. Ex: 0.05 |
| minAbsCor | Cutoff value for correlation. It has to range between [-1,1] |
| pcut | P-value cut off for the correlation. EX: 0.05 |
| conf | Confidence value for correlation. Ex: 0.95 |
| min | Minimum number of genes for enrichment. Ex: 5 |
| cellline | List of cell-lines in TAD boundaries. |
| corrMethod | ‘pearson’, ‘kendall’, ‘spearman’ |
| alternate | ‘greater’, ‘two.sided’, ‘less’ |
| pathwayType | ‘kegg’, ‘reactome’,‘wiki’,‘other’ |
| isSymbol | TRUE, FALSE |
| express | TRUE, FALSE. By default it is FALSE |
| target | TRUE, FALSE. By default it is FALSE |
| near | TRUE, FALSE. By default it is FALSE |
| isTADSearch | TRUE, FALSE. By default it is FALSE |
| cancer | ACC, BLCA, BRCA, CESC, CHOL, COAD, COADREAD, DLBC, ESCA, GBMLGG, HNSC, KICH, KIPAN, KIRC, KIRP, LGG, LIHC, LUAD, LUSC, OV, PAAD, PCPG, PRAD, READ, SARC,SKCM, STAD, STES, TGCT, THCA, THYM, UCEC, UCS, UVM |

Citation : Olgun G, Nabi A, Tastan O (2019). “NoRCE: Non-coding RNA sets cis enrichment tool.” , BMC Bioinformatics, 22 (1), 1-17, doi: 10.1186/s12859-021-04112-9

@Credits: Gulden Olgun