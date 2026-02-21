# MAGAR: Methylation-Aware Genotype Association in R

#### Michael Scherer

#### October 20, 2021

# 1 Introduction

This vignette describes the package *Methylation-Aware Genotype Association with R* ([*MAGAR*](https://github.com/MPIIComputationalEpigenetics/MAGAR)) available from GitHub. *MAGAR* uses DNA methylation data obtained using the Illumina BeadArrays, and genotyping data from Illumina genotyping microarrays or whole genome sequencing to compute methylation quantitative trait loci (methQTL). The package provides mutliple flavors of linear modeling strategies to compute *methQTL* as statistically significant interactions between single nucleotide polymorphisms (SNPs) and changes in the DNA methylation state of individual CpGs. DNA methylation values at single CpGs are first summarized into correlation blocks, and a representative of this correlation block (tag-CpG) is used in the methQTL calling.

# 2 Installation

*MAGAR* can be installed using the basic Bioconductor installation functions.

```
if(!requireNamespace("BiocManager")){
    install.packages("BiocManager")
}
if(!requireNamespace("MAGAR")){
    BiocManager::install("MAGAR")
}
```

```
suppressPackageStartupMessages(library(MAGAR))
```

```
## No methods found in package 'oligoClasses' for request: 'mean' when loading 'crlmm'
```

## 2.1 Required external software tools

*MAGAR* depends on a funtional installation of *PLINK* for handling genotyping data. Follow the installation instructions available [here](https://www.cog-genomics.org/plink2/) and specify the path to the installation for the package `qtlSetOption(plink.path="path_to_plink")`.

Additionally, depending on the type of the analysis, more external software tools are required (). More specifically, if you want to perform imputation *bgzip* and *tabix* from the [*htslib*](http://www.htslib.org/download/) package are needed, as well as [*vcftools*](https://vcftools.github.io/downloads.html) for sorting VCF files. Lastly, if methQTL calling is to be performed through [*fastQTL*](http://fastqtl.sourceforge.net/), the software tool needs to be installed and the location of the executable specified to *MAGAR* using the `qtlSetOption` function with the value `bgzip.path, tabix.path, vcftools.path, fast.qtl.path`.

| **Tool** | **Description** | **Required for** | **URL** |
| --- | --- | --- | --- |
| PLINK | Toolsuite for processing genotyping data | *Import*, Processing genotyping data in binary PLINK format or as VCF files | <http://zzz.bwh.harvard.edu/plink/> |
| bgzip | Tool for compression of files | *Imputation*, Formating data for upload to the Michigan Imputation Server | <http://www.htslib.org/download/> |
| tabix | Tool for indexing sequencing files | *Imputation*, Formating data for upload to the Michigan Imputation Server | <http://www.htslib.org/download/> |
| vcftools | Tool for handling VCF files | *Imputation*, Formating data for upload to the Michigan Imputation Server | <https://vcftools.github.io/downloads.html> |
| fastQTL | Tool for determining eQTLs (methQTLs) from genotyping and DNA methylation data | *methQTL calling*, Alternative methQTL calling method in comparison to the default linear model | <http://fastqtl.sourceforge.net/> |

# 3 Input data

*MAGAR* uses two types of data as input: DNA methylation data obtained using the Illumina Infinium BeadArrays or bisulfite sequencing and genotyping data obtained using genotyping microarrays or whole genome sequencing.

## 3.1 DNA methylation data (microarrays)

*MAGAR* utilizes the widely used [*RnBeads*](http://rnbeads.org/) software package for DNA methylation data import. Thus, *MAGAR* supports the various input options available in *RnBeads*, including a direct download from the Gene Expression Omnibus (GEO), IDAT, and BED files. For further options, we refer to the [RnBeads vignette](http://bioconductor.org/packages/release/bioc/vignettes/RnBeads/inst/doc/RnBeads.pdf) and documentation. In addition to the raw methylation data, a sample annotation sheet specifying the samples to be analyzed needs to be provided. The sheet contains a line for each sample and looks as follows:

```
SampleID,age,sex,barcode
Sample_1,14,f,209054857842_R01C01
Sample_2,42,f,209054857842_R02C01
Sample_3,45,m,209054857842_R03C01
```

For further details on the import process, we refer to the [RnBeads vignette](http://bioconductor.org/packages/release/bioc/vignettes/RnBeads/inst/doc/RnBeads.pdf). Most importantly, analysis options need to be specified for the import and preprocessing modules of *RnBeads*. *MAGAR* provides a default setting, which is available in *extdata/rnbeads\_options.xml*. You can use this file as a template for your own setting and then specify it to the package:

```
opts <- rnb.xml2options(system.file("extdata","rnbeads_options.xml",package="MAGAR"))
rnb.options(identifiers.column="geo_accession",
    import.idat.platform="probes450")
xml.fi <- file.path(getwd(),"rnbeads_options.xml")
cat(rnb.options2xml(),file=xml.fi)
qtlSetOption(rnbeads.options = xml.fi)
```

## 3.2 Genotyping data

### 3.2.1 PLINK files

*MAGAR* supports data that has already been processed by [*PLINK*](http://zzz.bwh.harvard.edu/plink/) and that is available either in the form of binary *.bed*, *.bim* and *.fam* files, as *.ped* and *.map*, as variant calling files (*.vcf*), or as imputed files in the dosage format (*.dos*). For further processing, we use the command line tool *PLINK*, which is shipped together with *MAGAR*. However, this installation is only valid for Linux systems. For Windows and MacOS users, please install the *PLINK* tool from [here](https://www.cog-genomics.org/plink/1.9/) and specify it using the option `plink.path`. The sample identifier specified earlier also needs to match the sample IDs of the genotype calls. To import PLINK data, it’s best to store the *.bim*, *.bed*, and *.fam* files in a single folder (here `plink_data`) and to specify the location of the folder to the package.

```
geno.dir <- "plink_data"
rnb.set <- load.rnb.set("rnb_set_dir")
s.anno <- "sample_annotation.csv"
data.loc <- list(idat.dir=rnb.set,geno.dir=plink.dir)
qtlSetOption(geno.data.type="plink",
    meth.data.type="rnb.set")
meth.qtl <- doImport(data.location=data.loc,
    s.anno=s.anno,
    s.id.col="SampleID",
    out.folder=getwd())
```

### 3.2.2 IDAT files

*MAGAR* also supports raw IDAT files and uses the [*CRLMM*](https://www.bioconductor.org/packages/release/bioc/html/crlmm.html) R-package, together with PLINK to perform genotype calling and data import. The package requires a single sample annotation sheet in the format described in the [DNA methylation data](DNA%20methylation%20data%20%28microarray%29) section. In addition to the column names specified above, a column named *GenoSentrixPosition* has to be added, which specifies the IDAT file IDs.

```
SampleID,age,sex,barcode,GenoSentrixPosition
Sample_1,14,f,209054857842_R01C01,9701756058_R05C01
Sample_2,42,f,209054857842_R02C01,9701756058_R07C01
Sample_3,45,m,209054857842_R03C01,9742011016_R04C01
```

### 3.2.3 Imputation

Since Illumina SNP BeadArray data is typically imputed before further analysis, the package integrates a imputation functionality through the [Michigan Imputation Server](https://imputationserver.sph.umich.edu/index.html#!). Using the option setting described below, the package will automatically submit imputation jobs to the server and process the resulting files. In order to be able to perform computation on the server, an account is required. After the account is created, one has to request an API token in the user settings and specify it to *MAGAR* using the option `imputation.user.token`. During the imputation process, the package will stall for a while and wait for the job to finish. After the job is completed, the package will prompt for entering the password send via e-mail to the user account. The imputation process has to be split according to chromosomes, which is why multiple e-mails will be send to the account, and the imputation process can take up to several days. However, after imputation, the imputed data will be available as PLINK files, such that the imputation has to be performed only once. For preprocessing the data for upload to the imputation server, the package requires the [bgzip](http://www.htslib.org/doc/bgzip.html) and [tabix](http://www.htslib.org/doc/tabix.html) tools from the [htslib](http://www.htslib.org/) package. Also see further options to configure the imputation jobs at the Michigan Imputation Server [documentation](https://imputationserver.readthedocs.io/en/latest/):

```
qtlSetOption(
  impute.geno.data=TRUE,
  imputation.reference.panel="apps@hrc-r1.1",
  imputation.phasing.method="shapeit",
  imputation.population="eur"
)
```

## 3.3 Perform data import

The `doImport` function requires the paths to the respective genotyping and DNA methylation data, as well as a sample annotation sheet as discussed earlier. In this vignette, we will describe the import of DNA methylation data in *IDAT* format and genotyping data as *PLINK* files. First, you’ll have to specify the paths to the corresponding *IDAT* and *plink* files. Additionally, you have to specify the sample identifier column in the sample annotation sheet that determines the samples in both the genotyping and DNA methylation data. For larger files, we recommend to activate the option to store large matrices on disk rather than in main memory (`hdf5dump`).

For imputed data, no further processing is performed on the genotyping data and the dosage values are used as they are:

```
idat.dir <- "idat_dir"
geno.dir <- "geno_dir"
anno.sheet <- "sample_annotation.tsv"
qtlSetOption(hdf5dump=TRUE)
imp.data <- doImport(data.location = c(idat.dir=idat.dir,geno.dir=geno.dir),
                    s.anno = anno.sheet,
                    s.id.col = "ID",
                    tab.sep = "\t",
                    out.folder = getwd())
```

Please note that the `recode.allele.frequencies` option specifies, if, according to the cohort analyzed, SNP reference and alternative allele are to be recoded according to the allele frequencies in the available samples. Alternatively, a path to a local version of dbSNP (Sherry et al. 2001) can be provided through `db.snp.ref`, and reference/alternative allele information will be automatically parsed from the database. This is especially crucial, if imputation is to be performed, since the Michigan Imputation Server is sensitive to reference mismatches.

# 4 methQTL calling

Although *MAGAR* conceptually splits the methQTL calling into two steps ((i) compute correlation block, (ii) call methQTL per correlation block), only a single function call is needed. The function only requires the input `methQTLInput` object produced in the previous step, but further options, such as covariates and the p-value cutoff can be directly specified as a function parameter, or as global parameters using `?qtlSetOption`.

```
imp.data <- loadMethQTLInput(system.file("extdata","reduced_methQTL",package="MAGAR"))
qtlSetOption(standard.deviation.gauss=100,
    cluster.cor.threshold=0.75)
meth.qtl.res <- doMethQTL(imp.data,default.options=FALSE,p.val.cutoff=0.05)
```

```
## 2025-10-30 00:48:27     1.5  STATUS STARTED Imputation procedure knn
## 2025-10-30 00:48:27     1.5  STATUS COMPLETED Imputation procedure knn
##
## 2025-10-30 00:48:27     1.5  STATUS STARTED Computing methQTLs
## 2025-10-30 00:48:27     1.5  STATUS     STARTED Computing methQTL for chromosome chr18
## 2025-10-30 00:48:27     1.5  STATUS         STARTED Compute correlation blocks
## 2025-10-30 00:48:27     1.5  STATUS             STARTED Compute correlation matrix
## 2025-10-30 00:48:28     1.5  STATUS             COMPLETED Compute correlation matrix
## 2025-10-30 00:48:28     1.5  STATUS             STARTED Compute pairwise distances
## 2025-10-30 00:48:29     1.5  STATUS             COMPLETED Compute pairwise distances
## 2025-10-30 00:48:30     1.5  STATUS             STARTED Weight distances
## 2025-10-30 00:48:30     1.5  STATUS             COMPLETED Weight distances
## 2025-10-30 00:48:31     1.5  STATUS             STARTED Compute graph
## 2025-10-30 00:48:31     1.5  STATUS             COMPLETED Compute graph
## 2025-10-30 00:48:31     1.5  STATUS             STARTED Compute clustering
## 2025-10-30 00:48:33     1.5  STATUS             COMPLETED Compute clustering
## 2025-10-30 00:48:33     1.5  STATUS         COMPLETED Compute correlation blocks
```

```
## Saving 7 x 5 in image
```

```
## 2025-10-30 00:48:33     1.5  STATUS         STARTED Compute methQTL per correlation block
## 2025-10-30 00:48:33     1.5  STATUS             STARTED Setting up Multicore
## 2025-10-30 00:48:33     1.5    INFO                 Using 1 cores
## 2025-10-30 00:48:33     1.5  STATUS             COMPLETED Setting up Multicore
## 2025-10-30 00:48:52     1.9  STATUS         COMPLETED Compute methQTL per correlation block
## 2025-10-30 00:48:52     1.9  STATUS     COMPLETED Computing methQTL for chromosome chr18
## 2025-10-30 00:48:54     1.9  STATUS COMPLETED Computing methQTLs
```

We will now present the two steps of the methQTL calling procedure in more detail.

## 4.1 Compute CpG correlation blocks

Since neighboring CpGs are often highly correlated, using each CpG independently as a potential methQTL candidate leads to many redundant results. We thus aimed to approximate *DNA methylation haplotypes* by determining highly correlated CpGs in close vicinity. The procedure itself is split into six steps, and is performed for each chromosome independently:

1. Compute the (Pearson) correlation matrix between all CpGs (futher correlation types available in option `correlation.type`)
2. Construct the distance matrix from the correlation matrix
3. Discard all interactions with a correlation lower than a given threshold (option: `cluster.cor.threshold`)
4. Weight the distance according to the genomic distance between the two CpGs with a Gaussian (option: `standard.deviation.gauss`). Higher values for the standard deviation lead to a lower penalty on distal CpGs, thus the clusters will become larger.
5. Discard all interactions ranging longer than the option `absolute.distance.cutoff`
6. Compute the Louvain clustering on the undirected, weighted graph induced by the distance matrix

This will return a clustering according to the correlation structure between neighboring CpGs that we will later use for methQTL calling. Note that we used simultation experiments to determine the parameters for each data type individually. They will be automatically loaded for the dataset that is used and are:

* **450k:** `cluster.cor.threshold`=0.2, `standard.deviation.gauss`=5,000, `absolute.distance.cutoff`=500,000
* **EPIC:** `cluster.cor.threshold`=0.2, `standard.deviation.gauss`=3,000, `absolute.distance.cutoff`=500,000
* **RRBS/WGBS:** `cluster.cor.threshold`=0.2, `standard.deviation.gauss`=250, `absolute.distance.cutoff`=500,000

## 4.2 Call methQTL per correlation block

From the list of correlation blocks, *MAGAR* computes methQTL interactions with all SNPs on the same chromosome. The process is split into three steps:

1. Compute a representative CpG (tag-CpG) per correlation block, as specified with the option `representative.cpg.computation` (default: *row.medians*).
2. Discard all SNPs that are further than `absolute.distance.cutoff` (default: 1,000,000) away from the representative CpG
3. Call methQTL by using linear models. Multiple options of methQTL calling are available and can be selected via the option `linear.model.type` (default: *classical.linear*). Alternatively, *fastQTL* can be set as an option for `meth.qtl.type`. This will tell the package to use the fastQTL software (Ongen et al. 2016).

The `meth.qtl.type` tells, how a methQTL interaction is defined and provides three options, in addition to the already mentioned *fastQTL*:

1. *oneVSall*: A CpG can only be influenced by one SNP. We choose the one with the lowest p-value.
2. *twoVSall*: A CpG can both positively and negatively be influenced by two independent SNPs. The package will output those fulfilling the p-value cutoff.
3. *allVSall*: For each CpG, all SNPs showing a p-value lower than the p-value cutoff will be returned.

In the methQTL calling process, potential covariates can be specified using the option *sel.covariates*. We recommend to include at least *age* and *sex* as covariates, as they have a strong influence on the DNA methylation pattern.

# 5 Downstream analysis and interpretation

## 5.1 How to use *methQTLResult*

The above procedure will create an object of class `methQTLResult`, which contains the methQTL that are called in the previous step. To get a table of all the methQTL, you need to extract the information from the object. In the majority of the function calls below, there is the option `type`, which takes on the values: \* ‘SNP’: To characterize the SNPs that influence any DNA methylation state \* ‘CpG’: To characterize the representative CpGs per correlation block that are influences by any SNP genotype \* ‘cor.block’: To characterize all CpGs, which are part of a correlation block, whose representative CpG is influenced by any genotype

Furthermore, you can obtain genomic annotations for both the CpGs and the SNPs involved in the methQTL interactions:

```
result.table <- getResult(meth.qtl.res)
head(result.table)
```

```
anno.meth <- getAnno(meth.qtl.res,"meth")
head(anno.meth)
```

```
anno.geno <- getAnno(meth.qtl.res,"geno")
head(anno.geno)
```

For more detailed information about the output, also see the function `getResultsGWASMap`.

## 5.2 Plots

To visualize methQTL, *MAGAR* provides some plotting functions. Most functions return an object of type `ggplot`, which can be subsequently stored or viewed. Either all methQTL can be simultaneously visualized in a single plot, or a specific methQTL can be visualized:

```
result.table <- result.table[order(result.table$P.value,decreasing=FALSE),]
qtlPlotSNPCpGInteraction(imp.data,result.table$CpG[1],result.table$SNP[1])
```

```
## `geom_smooth()` using formula = 'y ~ x'
```

![](data:image/png;base64...)

```
qtlDistanceScatterplot(meth.qtl.res)
```

![](data:image/png;base64...)

## 5.3 Interpretation functions

The package provides a bunch of interpretation functions to characterize the detected methQTLs. This includes LOLA enrichment analysis(Sheffield and Bock 2016) (`qtlLOLAEnrichment`), genomic annotation enrichment based on putative regulatory elements defined by the Ensembl Regulatory Build(Zerbino et al. 2015) (`qtlAnnotationEnrichment`), enrichment analysis of different base substitutions in SNPs (`qtlBaseSubstitutionEnrichment`), or TFBS motif enrichment using [TFBSTools](http://bioconductor.org/packages/release/bioc/html/TFBSTools.html). Enrichment is compared for the methQTLs that are available in the provided `methQTLResult` (for a single input), or to the overlapping QTLs for a list of `methQTLResult`. The background of the enrichment is defined as all the SNPs/CpGs that have been used as input to the methQTL calling.

```
res <- qtlBaseSubstitutionEnrichment(meth.qtl.res)
```

## 5.4 Lists of methQTL results

Most of the functions discussed above either support a single `methQTLResult` as input, or a list of such objects. In case a list is specified, the functions will typically overlap the methQTLs found and compare those with all SNPs/CpGs that have been used for methQTL calling. Additionally, there are functions that particularly work on a list of `methQTLResult` objects and that perform overlapping, or determine the methQTLs specific to a dataset.

```
meth.qtl.res.2 <- loadMethQTLResult(system.file("extdata","MethQTLResult_chr18",package="MAGAR"))
meth.qtl.list <- list(First=meth.qtl.res,Second=meth.qtl.res.2)
qtlVennPlot(meth.qtl.list,out.folder=getwd())
```

```
## Loading required namespace: VennDiagram
```

```
qtlUpsetPlot(meth.qtl.list,type = "cor.block")
```

```
## 2025-10-30 00:48:56     1.9  STATUS STARTED Constructing universe
## 2025-10-30 00:48:56     1.9  STATUS     STARTED Obtaining correlation blocks for object 1
## 2025-10-30 00:48:56     1.9  STATUS     COMPLETED Obtaining correlation blocks for object 1
## 2025-10-30 00:48:56     1.9  STATUS     STARTED Obtaining correlation blocks for object 2
## 2025-10-30 00:48:56     1.9  STATUS     COMPLETED Obtaining correlation blocks for object 2
## 2025-10-30 00:48:56     1.9  STATUS     STARTED Overlapping
## 2025-10-30 00:48:56     1.9  STATUS         STARTED Obtaining correlation blocks for object 1
## 2025-10-30 00:48:56     1.9  STATUS         COMPLETED Obtaining correlation blocks for object 1
## 2025-10-30 00:48:56     1.9  STATUS         STARTED Obtaining correlation blocks for object 2
## 2025-10-30 00:48:56     1.9  STATUS         COMPLETED Obtaining correlation blocks for object 2
## 2025-10-30 00:48:56     1.9  STATUS     COMPLETED Overlapping
```

![](data:image/png;base64...)

```
spec.first <- getSpecificQTL(meth.qtl.list$First,meth.qtl.list[-1])
```

# 6 Advanced configuration

## 6.1 *MAGAR* options

*MAGAR* is a flexible software packages that allows for multiple flavors of methQTL analyses. Here, we present the different options that describe the analysis in a table and also discuss possible problems with choosing non-default options. Most options have reasonable default values that have been determined using a simulation experiment. For further information, see the documentation of `qtlSetOption`

| **Option** | **Description** | **Note** |
| --- | --- | --- |
| **External tools** |  |  |
| `vcftools.path` | Path to an installation of VCFtools for handling VCF files for genotyping data |  |
| `plink.path` | Path to an executable version of PLINK for processing genotyping data |  |
| `fast.qtl.path` | Path to an executable version of FastQTL for calling methQTLs | Only required, when `meth.qtl.type='fastQTL'` |
| `bgzip.path` | Path to an executable version of bgzip from the HTSlib package for compressing genomic data |  |
| `tabix.path` | Path to an executable version of tabic from the HTSlib package for indexing genomic data |  |
| **External tool configuration** |  |  |
| `rnbeads.options` | Path to an XML file specifying the methylation data processing conducted through RnBeads |  |
| `rnbeads.report` | Path to an existing directory, where the RnBeads report is to be stored |  |
| `rnbeads.qc` | Flag indicating if the QC module of RnBeads is to be executed |  |
| `hardy.weinberg.p` | Hardy-Weinberg test p-value cutoff as used for filtering SNPs in PLINK |  |
| `minor.allele.frequency` | Minimum required minor allele frequency for a SNP to be considered in PLINK |  |
| `missing.values.samples` | Maximum number of missing genotypes per SNP across the samples for a SNP to be considerd by PLINK |  |
| `plink.geno` | Minimum genotyping rate for samples in PLINK |  |
| `n.permutations` | Number of permutations used to correct for multiple testing in fastQTL |  |
| **Imputation options** |  |  |
| `impute.geno.data` | Flag indicating if genotyping data is to be executed or not |  |
| `imputation.user.token` | User token generated by the Michigan Imputation server that allows for communicating with the Server API | Needs to be generated at <https://imputationserver.sph.umich.edu> |
| `imputation.reference.panel` | Reference panel used for the imputation | See <https://imputationserver.readthedocs.io/en/latest/api/> for further information |
| `imputation.phasing.method` | Phasing method used for the imputation | See <https://imputationserver.readthedocs.io/en/latest/api/> for further information |
| `imputation.population` | The population of the reference panel to be used for the imputation | See <https://imputationserver.readthedocs.io/en/latest/api/> for further information |
| **Import options** |  |  |
| `meth.data.type` | The type of methylation data that is about to be processed | Accepted values are `idat.dir`, `data.dir`, `data.files`, `GS.report`, `GEO`, or `rnb.set` |
| `geno.data.type` | The type of genotyping data that is about to be processed | Accepted values are `idat` or `plink` |
| **Correlation Block Calling** |  |  |
| `compute.cor.blocks` | Flag indicating if correlation blocks are to be identified from the methylation data |  |
| `correlation.type` | The type of correlation to be employed for computing correlation blocks | Accepted values are `pearson`, `spearman`, and `kendall` |
| `cluster.cor.threshold` | The correlation threshold leading to an entry of zero in the correlation matrix |  |
| `standard.deviation.gauss` | The standard deviation of the Gaussian that is used for weighting similarities according to the genomic distance |  |
| `absolute.distance.cutoff` | The distance cutoff for the genomic distance. Higher distances lead to a zero in the similarity matrix |  |
| `max.cpgs` | Maximum number of CpGs used for computing correlation blocks | Depends on the main memory available |
| **MethQTL Calling** |  |  |
| `meth.qtl.type` | This options determines how a methQTL is defined | Accepted values are `oneVSall`, `allVSall`, `twoVSall`, or `fastQTL`. |
| `linear.model.type` | Determines how the linear model is defined for calling methQTLs | Accepted values are `categorical.anova`, `classical.linear`, or `fastQTL` |
| `representative.cpg.computation` | Determines how a representative CpG is identified per correlation block, which is associated with the SNP genotype | Accepted values are `row.medians`, `mean.center`, or `best.all` |
| `n.prin.comp` | Numeric value indicating how many of the PCs are to be used as covariates in the identification of methQTLs |  |
| **General options** |  |  |
| `hdf5dump` | Flag indicating if large matrices are to be stored on disk rather than in main memory using the `HDF5Array` package | Consider further options for `HDF5Array` such as `setHDF5DumpDir` and `setHDF5DumpFile` |
| `db.snp.ref` | A path to a downloaded version of dbSNP. With dbSNP, SNP identifiers can be extracted and annotated SNPs can be removed from the methylation data | dbSNP should be in vcf.gz format and can be downloaded from <https://ftp.ncbi.nih.gov/snp/organisms/human_9606_b150_GRCh37p13/VCF/> |
| `cluster.config` | Configuration for a high perfomance computing cluster. Currently supported are SLURM and SGE. |  |
| `cluster.architecture` | String indicating which high performance computing architecture is used | Currently supported are ‘slurm’ and ‘sge’ |
| `recode.allele.frequencies` | Flag indicating if the allele frequencies are to be computed from the genotype data. |  |

## 6.2 Employ *MAGAR* on a scientific compute cluster

*MAGAR* can automatically distribute jobs across a high performance compute cluster, which has been setup using the Sun Grid Engine (SGE) technology. You can pass the option `cluster.submit` to `doMethQTL` and thus activate the cluster submission. Note that you’ll also have to specify a path to an executable *Rscript* and potentially specify resource requirements using the option setting `cluster.config`.

```
qtlSetOption(cluster.config = c(h_vmem="60G",mem_free="20G"))
qtlSetOption(rscript.path = "/usr/bin/Rscript")
meth.qtl.res <- doMethQTL(meth.qtl = imp.data,
                        cluster.submit = T)
```

# References

Ongen, Halit, Alfonso Buil, Andrew Anand Brown, Emmanouil T. Dermitzakis, and Olivier Delaneau. 2016. “Fast and efficient QTL mapper for thousands of molecular phenotypes.” *Bioinformatics* 32 (10): 1479–85. <https://doi.org/10.1093/bioinformatics/btv722>.

Sheffield, Nathan C., and Christoph Bock. 2016. “LOLA: enrichment analysis for genomic region sets and regulatory elements in R and Bioconductor.” *Bioinformatics* 32 (4): 587–89. <https://doi.org/10.1093/bioinformatics/btv612>.

Sherry, S. T., M. H. Ward, M. Kholodov, J. Baker, L. Phan, E. M. Smigielski, and K. Sirotkin. 2001. “dbSNP: the NCBI database of genetic variation.” *Nucleic Acids Research* 29 (1): 308–11. <https://doi.org/10.1093/nar/29.1.308>.

Zerbino, Daniel R., Steven P. Wilder, Nathan Johnson, Thomas Juettemann, and Paul R. Flicek. 2015. “The Ensembl Regulatory Build.” *Genome Biology* 16 (1): 1–8. <https://doi.org/10.1186/s13059-015-0621-5>.