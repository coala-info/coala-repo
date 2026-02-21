# GmicR\_vignette

# Abstract

In this example, we will generate a gene module-immune cell signature network using the GmicR pacakge. This package uses WGCNA to compresses high-dimensional expression data into module eigenegenes, which are used with bayesian learning and xCell cell signatures to infer causal relationships between gene modules and cell signatures. Expression data must be normalized (RPKM/FPKM/TPM/RSEM) and annotated with official gene symbols.

## Installation of Bioconductor packages

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install('GmicR')
```

For macosx users experiencing WGCNA installation errors, try downloading a compiled version from:

* <https://horvath.genetics.ucla.edu/html/CoexpressionNetwork/Rpackages/WGCNA/#manualInstall>

For macosx users experiencing installation errors, try downloading OS X binaries from:

* [https://CRAN.R-project.org/package=gRain](https://CRAN.R-project.org/package%3DgRain)
* [https://CRAN.R-project.org/package=gRbase](https://CRAN.R-project.org/package%3DgRbase)

# Step 1 for GMIC building: Accessing Expression data

For this example, we are downloading microarray expression data provided by the xCell web portal. This dataset contains the expression profiles of twelve different types of human leukocytes from peripheral blood and bone marrow, before and after different treatments.

Detailed information about this dataset is available:

* <https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE22886>

## Downloading expression data

### NOTE: GmicR requires official gene symbols

```
url <- "http://xcell.ucsf.edu/iris_u133a_expr.txt"

dat_download <- data.frame(read.delim(url),
row.names = 1, stringsAsFactors = FALSE, check.rows = FALSE)

# data are transposed for processing
datExpr0<-data.frame(t(dat_download))
```

## QC of expression data

WGCNA is used to for quality control of genes via the goodSamplesGenes function

```
library(WGCNA)
gsg = goodSamplesGenes(datExpr0, verbose = 3) # columns must be genes
#>  Flagging genes and samples with too many missing values...
#>   ..step 1
gsg$allOK
#> [1] TRUE
```

A sampleTree can be used to check for outlier samples. For this example all samples are kept.

```
sampleTree = hclust(dist(datExpr0), method = "average");

par(cex = 0.6);
par(mar = c(0,4,2,0))
plot(sampleTree, main = "Sample Filtering",
labels = FALSE)
```

![](data:image/png;base64...)

```
# final expression set ----------------------------------------------------
datExpr = datExpr0
```

## Exporting expression data for xCell signature analysis

For cell signature detection using xCell, the expression data can be written to a csv file. The file can be uploaded at: <http://xcell.ucsf.edu>

```
Exps_for_xCell_analysis<-data.frame(t(datExpr), check.names = FALSE)

write.csv(Exps_for_xCell_analysis, file = "Exps_for_xCell_analysis.csv")
```

### The xCell results will be emailed to you.

Once you have the xCell data processed by <http://xcell.ucsf.edu>, you will receive an email linking to three text files. Download these files. For GmicR, the “xCell results” file is required for Step 3. ![](data:image/png;base64...)

# Step 2 for GMIC building: gene module detection and annotation

For simplicity, we will carryout WGCNA using 1000 randomly selected genes from 50 randomly selected samples

## WGCNA module detection

Auto\_WGCNA is a wrapper for WGCNA. Not all options are avaible. For more advanced features please use WGCNA.

```
library(GmicR)

GMIC_Builder<-Auto_WGCNA(sample_dat,
  mergeCutHeight = 0.35, minModuleSize = 10,
  deepSplit = 4, networkType = "signed hybrid", TOMType = "unsigned",
  corFnc = "bicor",  sft_RsquaredCut = 0.85,
  reassignThreshold = 1e-06, maxBlockSize = 25000)
#> verify that colnames contain official gene symbols
#> Table for modules and gene counts
```

Viewing input parameters

```
GMIC_Builder$Input_Parameters
#> $networkType
#> [1] "signed hybrid"
#>
#> $TOMType
#> [1] "unsigned"
#>
#> $corFnc
#> [1] "bicor"
#>
#> $sft_RsquaredCut
#> [1] 0.85
#>
#> $softPower
#> [1] 5
#>
#> $minModuleSize
#> [1] 10
#>
#> $deepSplit
#> [1] 4
#>
#> $mergeCutHeight
#> [1] 0.35
#>
#> $reassignThreshold
#> [1] 1e-06
#>
#> $maxBlockSize
#> [1] 25000
```

Soft threshold plot

```
GMIC_Builder$Output_plots$soft_threshold_plot
```

![](data:image/png;base64...)

module clustering

```
GMIC_Builder$Output_plots$module_clustering
#> Warning in restoreRecordedPlot(x, reloadPkgs): snapshot recorded in different R
#> version (3.5.3)
#> Warning in doTryCatch(return(expr), name, parentenv, handler): snapshot
#> recorded with different graphics engine version (12 - this is version 16)
```

![](data:image/png;base64...)

dendrogram

```
GMIC_Builder$Output_plots$net_dendrogram
#> Warning in restoreRecordedPlot(x, reloadPkgs): snapshot recorded in different R
#> version (3.5.3)
#> Warning in doTryCatch(return(expr), name, parentenv, handler): snapshot
#> recorded with different graphics engine version (12 - this is version 16)
```

![](data:image/png;base64...)

## Module annotation

WGCNA functions intramodularConnectivity and chooseOneHubInEachModule are used to build a dataframe with gene module information.

```
# Module hubs and Gene influence
GMIC_Builder<-Query_Prep(GMIC_Builder,
  calculate_intramodularConnectivity= TRUE,
  Find_hubs = TRUE)
#> Allowing multi-threading with up to 72 threads.

head(GMIC_Builder$Query)
#>         ref_genes modules     hub Freq    kTotal   kWithin
#> SLC37A4   SLC37A4       0 SLC37A4  100 1.6525368 1.0000000
#> PEX10       PEX10       0 SLC37A4  100 1.6403205 0.8690595
#> GALNT12   GALNT12       0 SLC37A4  100 0.9325671 0.8025879
#> FGF3         FGF3       0 SLC37A4  100 2.2483526 0.7881512
#> ANGEL1     ANGEL1       0 SLC37A4  100 3.4791659 0.7681177
#> PER3         PER3       0 SLC37A4  100 0.8164831 0.7152039
```

This function constructs a library for gene ontology enrichment, which will be used for module naming with the GO\_Module\_NameR function.

```
GMIC_Builder<-GSEAGO_Builder(GMIC_Builder,
  species = "Homo sapiens", ontology = "BP", no_cores = 1)
#>
#> Attaching package: 'generics'
#> The following objects are masked from 'package:base':
#>
#>     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
#>     setequal, union
#>
#> Attaching package: 'BiocGenerics'
#> The following objects are masked from 'package:stats':
#>
#>     IQR, mad, sd, var, xtabs
#> The following objects are masked from 'package:base':
#>
#>     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
#>     as.data.frame, basename, cbind, colnames, dirname, do.call,
#>     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
#>     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
#>     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
#>     unsplit, which.max, which.min
#> Welcome to Bioconductor
#>
#>     Vignettes contain introductory material; view with
#>     'browseVignettes()'. To cite Bioconductor, see
#>     'citation("Biobase")', and for packages 'citation("pkgname")'.
#>
#> Attaching package: 'S4Vectors'
#> The following object is masked from 'package:utils':
#>
#>     findMatches
#> The following objects are masked from 'package:base':
#>
#>     I, expand.grid, unname
```

GO\_Module\_NameR will assign a name to each module based on ontology size. A smaller cut off size will generate a more specific term.

```
GMIC_Builder<-GO_Module_NameR(GMIC_Builder)
```

This table provides a summary of detected modules. “Freq” indicates the total genes within each module

```
head(GMIC_Builder$GO_table, n = 4)
#>                GO_module_name modules     hub Freq
#> ME0                  module 0       0 SLC37A4  100
#> ME1            system process       1    SGCD  319
#> ME2            RNA processing       2  ANP32B  187
#> ME3 alcohol catabolic process       3 CYP27A1   88
```

A searchable dataframe is also generated

```
head(GMIC_Builder$GO_Query, n = 4)
#>         modules ref_genes     hub Freq    kTotal   kWithin GO_module_name
#> SLC37A4       0   SLC37A4 SLC37A4  100 1.6525368 1.0000000       module 0
#> PEX10         0     PEX10 SLC37A4  100 1.6403205 0.8690595       module 0
#> GALNT12       0   GALNT12 SLC37A4  100 0.9325671 0.8025879       module 0
#> FGF3          0      FGF3 SLC37A4  100 2.2483526 0.7881512       module 0
```

# Step 3: Preparing module eigengenes and cell signatures for BN learning

## Specify the “xCell results” file directory

For this example, we are using cell signatures provided by the GmicR package, which were generated using the xCell web portal.

```
file_dir<-system.file("extdata", "IRIS_xCell_sig.txt",
                      package = "GmicR", mustWork = TRUE)
```

## Discretization

This function merges module eigengenes with xCell signatures prior to discretization. Only xCell signatures are supported. Discretization is carried out with bnlearning using “hartemink” method. For detailed information discretization see: <http://www.bnlearn.com/documentation/man/preprocessing.html>

```
GMIC_Builder_disc<-Data_Prep(GMIC_Builder,
  xCell_Signatures = file_dir,
ibreaks=10, Remove_ME0 = TRUE)
#> ImmuneScore, StromaScore, and MicroenvironmentScore removed

head(GMIC_Builder_disc$disc_data[sample(seq(1,64),4)])
#>           Smooth_muscle ME11 DC CMP
#> GSM565337             M    H  L   M
#> GSM565326             M    H  L   M
#> GSM565270             M    H  L   H
#> GSM565341             M    H  L   H
#> GSM565276             M    L  L   M
#> GSM565358             M    L  M   M
```

# Step 4: BN learning

## Bayesian network learing with bootstrapping.

Although the default score for this function is Bayesian Dirichlet equivalent score (bde), for this example we will use the Bayesian Dirichlet sparse score (bds). For sparse data, such as the data used in this example, the bds score is better suited: <https://arxiv.org/abs/1605.03884>.

```
no_cores<-1 # multicore support
cl<-parallel::makeCluster(1)

GMIC_net<-bn_tabu_gen(GMIC_Builder_disc,
  cluster = cl, debug = FALSE,
  bootstraps_replicates = 50, score = "bds")

parallel::stopCluster(cl) # stop cluster
```

## Detecting arcs for inversly related nodes

For hypothesis generation, it may be helpful to distiguish positive relationships from negative. The InverseARCs function from GmicR identifies these relationships from probability distributions generated from mutilated network queries. A correlation matrix is generated and a threshold is applied to specify a slope cut off for inverse relationships. By default the threhold is set to -0.3.

```
GMIC_Final<-InverseARCs(GMIC_net, threshold = -0.3)
#>
#> Attaching package: 'gRbase'
#> The following objects are masked from 'package:generics':
#>
#>     compile, fit
#>                 from                to      slope
#> 1                ME4        CD8_Tcells  0.9988365
#> 2                ME7               ME4  0.8951673
#> 3                ME1               ME8  0.8094157
#> 4                ME1               ME6 -0.6550932
#> 5                ME2               HSC -0.5903587
#> 6                ME2     Keratinocytes -0.5430769
#> 7                ME2    Megakaryocytes -0.1124876
#> 8                ME5               MPP -0.4999927
#> 9                ME5    Macrophages_M1  0.9959263
#> 10               ME6        Osteoblast  0.9532367
#> 11              ME10               ME6 -0.4757161
#> 12              ME10         Th1_cells -0.6901540
#> 13               ME3        CD4_Tcells -0.5697688
#> 14               ME3    Macrophages_M2  0.9850881
#> 15              ME12               ME9 -0.2607445
#> 16        Adipocytes           Neurons  0.9191450
#> 17        Astrocytes               GMP  0.9016378
#> 18        Astrocytes   Mesangial_cells  0.9583013
#> 19            Bcells               cDC -0.5435684
#> 20        CD4_Tcells CD4_memory_Tcells  0.9627661
#> 21        CD4_Tcells       Melanocytes -0.5694006
#> 22        CD4_Tcells         Monocytes -0.4161255
#> 23 CD4_memory_Tcells         Pericytes -0.6867149
#> 24           CD8_Tem  CD4_naive_Tcells  0.8085374
#> 25           CD8_Tem  Epithelial_cells -0.5903955
#> 26  CD8_naive_Tcells         Th2_cells -0.6802793
#> 27      Chondrocytes        Astrocytes  0.9850366
#> 28      Chondrocytes       Melanocytes -0.1820302
#> 29      Chondrocytes          NK_cells  0.5584474
#> 30      Chondrocytes      naive_Bcells  0.2467898
#> 31      Erythrocytes          Myocytes  0.9988365
#> 32       Fibroblasts  CD8_naive_Tcells -0.6105001
#> 33               MEP               pDC  0.9959263
#> 34               MPP               ME9 -0.6769467
#> 35       Macrophages       Hepatocytes  0.9764462
#> 36    Macrophages_M1            Bcells -0.5745124
#> 37    Megakaryocytes  CD4_naive_Tcells -0.4990409
#> 38     Memory_Bcells         Platelets  0.8544824
#> 39     Memory_Bcells      naive_Bcells  0.5720062
#> 40         Monocytes              ME12 -0.2988857
#> 41         Monocytes           CD4_Tem -0.9210281
#> 42         Monocytes         Sebocytes  0.8802014
#> 43          Myocytes       Fibroblasts  0.9975592
#> 44          Myocytes               GMP  0.8201126
#> 45          NK_cells    Megakaryocytes -0.5349956
#> 46           Neurons               CMP  0.1247581
#> 47           Neurons         Th1_cells -0.5419295
#> 48         Platelets     Keratinocytes -0.7728812
#> 49         Th2_cells              ME10 -0.7035975
#> 50               aDC               ME5  0.9959263
#> 51               aDC               iDC  0.4617575
#> 52               cDC       Macrophages  0.7905525
#> 53               iDC           CD8_Tem -0.5518279
#> 54               iDC                DC  0.9644860
```

## GmicR shiny app

Once complete, the GMIC network can be viewed using the Gmic\_viz shiny app.

```
GMIC_Final_dir<-system.file("extdata", "GMIC_Final.Rdata",
                          package = "GmicR", mustWork = TRUE)
load(GMIC_Final_dir)

if(interactive()){
Gmic_viz(GMIC_Final)
}
```

### GMIC\_network\_Query

You can view the entire network or just a subset of nodes. Inverse relationships can be highlighted based on color and/or edge pattern.

Not all nodes are represented:

* Module must have at least one connection
* xCell signature must have a relationship with a module

![](data:image/png;base64...)

### Module\_names\_Query

You can search for your favorite gene or module of interest. ![](data:image/png;base64...)

### Module\_names\_BP\_table

Or view a module summary table ![](data:image/png;base64...)