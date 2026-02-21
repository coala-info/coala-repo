# CaMutQC: Cancer Somatic Mutation Quality Control

Xin Wang   sylviawang555@gmail.com

#### 2025-10-29

![](data:image/png;base64...)

## 0.1 Introduction

The quality control of cancer somatic mutations is of great significance in cancer genomics. It helps to eliminate false positive mutations arisen during the sequencing process, thereby improving the efficiency and accuracy of downstream analysis. Here, we developed an R package CaMutQC, for the quality control and selection of cancer somatic mutations. It offers both common and customized strategies for the filtration of cancer somatic mutations based on the MAF data frame, which also can select key somatic mutations related to tumorigenesis. In addition, we believe that the union of CaMutQC-filtered mutations returned by multiple variant caller contains more true positive somatic mutations than that from a single variant caller or the intersection of multiple callers. The package, including source code and documentation, is available through Github (<https://github.com/likelet/CaMutQC>). A Shiny web application is also provided for interactive use.

### 0.1.1 Citation

If you find this tool useful, please cite:

***Xin Wang, Tengjia Jiang, Ao Shen, Yaru Chen, Yanqing Zhou, Jie Liu, Shuhan Zhao, Shifu Chen, Jian Ren, and Qi Zhao. CaMutQC: An R package for integrative quality control and filtration of cancer somatic mutations. Computational and Structural Biotechnology Journal. 2025;27:3147–3154. <https://doi.org/10.1016/j.csbj.2025.07.011>***

## 0.2 Installation

### 0.2.1 Via Bioconductor (recommended)

Install the latest and most stable version of CaMutQC with [Bioconductor](https://www.bioconductor.org/) by typing the commands below in R console:

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
# the latest version is on the devel branch, but might not be the most stable version
# BiocManager::install(version='devel')

# the most stable version is on the release branch (by default)
BiocManager::install("CaMutQC")
```

### 0.2.2 Via GitHub

Install the latest version of CaMutQC by typing the commands below in R console:

```
if (!requireNamespace("devtools", quietly = TRUE)) {
    install.packages("devtools")
}
devtools::install_github("likelet/CaMutQC")
```

## 0.3 An Overview

For now, there are three main functional modules in CaMutQC. The first section is to filter cancer somatic mutations through common strategies, and the following section offers users customized filtration criteria based on cancer types and published papers. CaMutQC is also capable of measuring TMB (Tumor Mutational Burden) through various assays. Required input of most functions in CaMutQC can be obtained by applying `vcfToMAF` function on VCF files.

MAF data frame with special labels from CaMutQC will be returned after each filtration. And a filter report will be generated, offering detailed and organized information.

![](data:image/png;base64...)

## 0.4 Input File

### 0.4.1 Single VCF

[VCF](https://samtools.github.io/hts-specs/VCFv4.3.pdf) is a widely used text file format in bioinformatics for storing gene sequence variations. All VCF files should be annotated by [VEP](https://useast.ensembl.org/info/docs/tools/vep/index.html) first before analyzing through CaMutQC because annotated VCF files contain more detailed information that has clinical significance. Information about VEP and how to run it on VCF file can be found [here](https://asia.ensembl.org/info/docs/tools/vep/script/vep_options.html#opt_check_existing).

### 0.4.2 Multiple VCF

CaMutQC supports VEP annotated multi-sample or multi-caller VCF files as inputs, which should be under the same file path. **Supported caller: MuTect2, VarScan2, MuSE.**

## 0.5 From VCF to MAF

VCF and MAF both are important formats in oncology and bioinformatics, but additional tools are needed when transforming between these two formats. `vcfToMAF` function in CaMutQC is able to perform this transformation using one line command in a few seconds when the input VCF file is VEP-annotated. In addition, parameter `filterGene` can filter variants without Hugo Symbol when it is set as `TRUE`.

```
library(CaMutQC)
MAFdat <- vcfToMAF(system.file("extdata", "WES_EA_T_1_mutect2.vep.vcf", package="CaMutQC"))
MAFdat[1:5, 1:13]
```

Load multi-caller data that consists of several VCF files by setting `multiVCF` as `TRUE`.

```
vcfPath <- system.file("extdata/Multi-caller", package="CaMutQC")
multiVCFs <- vcfToMAF(vcfPath, multiVCF=TRUE)
unique(multiVCFs$Tumor_Sample_Barcode)
```

```
## [1] "WES_EA_T_1" "TUMOR"
```

There are two Tumor\_Sample\_Barcode(s) after reading two VCF files under the `Multi-caller` folder.

## 0.6 Common filtering strategies

After reading a number of classical papers, we collected, sorted and summarized some widely used parameters and their thresholds when performing cancer somatic mutation filtration. These strategies are implemented through a number of sub-functions that cover widely used criteria like sequencing quality, strand of bias and database selection. Besides, sub-functions are integrated into bigger functions to enable . Each of the functions takes MAF data frame generated by `vcfToMAF` function in CaMutQC as an input, and returns a labeled MAF data frame as results.

### 0.6.1 Single filtration function

**Sub-functions and their corresponding flags**

| **Main function** | **Sub-function** | **Flag** |
| --- | --- | --- |
| mutFilterTech | mutFilterQual | **Q** |
|  | mutFilterSB | **S** |
|  | mutFilterAdj | **A** |
|  | mutFilterNormalDP | **N** |
|  | mutFilterPON | **P** |
|  | FILTER | **F** |
| mutSelection | mutFilterDB | **D** |
|  | mutFilterType | **T** |
|  | mutFilterReg | **R** |

**Note: A variant labeled by certain flag indicates it fails to pass this filter function, and all variants start from tag '0’**

#### 0.6.1.1 Sequencing quality filtration

Sequencing quality parameters like allele depth (`AD`), total depth (`DP`) and variant allele frequency (`VAF`) are widely used to filter potential artifacts.
To provide more convenience as well as more flexibility, the `panel` parameter in this function is able to apply a set of filtration strategies related to sequencing quality, where user can choose between panels like `WES` and `MSKCC` and they can also set freely under any panel.

**Parameters for Customized, WES and MSKCC panel**

| **Parameter** | **Customized panel (default)** | **WES panel** | **MSKCC panel** |
| --- | --- | --- | --- |
| normalDP | 10 | 10 | 10 |
| normalAD | Inf\* | 1 | 1 |
| tumorDP | 20 | 20 | 20 |
| tumorAD | 5 | 5 | 10 |
| VAF | 0.05 | 0.05 | 0.05 |
| VAFratio | 0 | 0 | 5 |

**\*: Inf here means normalAD is not a filtration criterion in this panel**

```
MAF_qual <- mutFilterQual(MAFdat, panel="Customized", VAF=0.01, VAFratio=4)
table(MAF_qual$CaTag)
```

```
##
##  0 0Q
## 30 57
```

Here we can see that 57 mutations get an extra **Q** flag, which means they fail to pass the filtration on sequencing quality with VAF < 0.01 or VAFratio < 4, or both.

#### 0.6.1.2 Strand of Bias filtration

Strand bias occurs when the genotype inferred from information presented by the forward strand and the reverse strand disagrees. A study showed that post-analysis procedures can cause strand bias, which introduce more SNPs with higher strand bias, and in turn result in more false-positive SNPs [1](#refer). Therefore, it is necessary to detect and minimize the effect of strand bias.

At present, there are four widely-used methods for strand bias detection. One approach was mentioned in a mitochondria heteroplasmy study [2](#refer). And GATK calculates a strand bias score for each SNP identified while [Samtools](https://github.com/samtools/samtools) put forwards another strand bias score based on Fisher’s exact test. Additionally, GATK introduced an updated form of the Fisher Strand Test, [StrandOddsRatioSOR](https://gatk.broadinstitute.org/hc/en-us/articles/360041849111-StrandOddsRatio) annotation (SOR), which is believed to be better at measuring strand bias of data in high coverage.

In CaMutQC, either Fisher Strand Test or SOR algorithm can be used to evaluate strand bias and filter variants based on the results. By default, strand bias is detected through SOR algorithm and the cutoff for strand of bias score is set as **3**.

```
MAF_sb <- mutFilterSB(MAFdat, SBscore=2)
table(MAF_sb$CaTag)
```

```
##
##  0 0S
## 68 19
```

In our case, 19 mutations are labeled by **S** flag because CaMutQC believes they have strand bias when the cutoff is set to 2.

#### 0.6.1.3 Adjacent indel filtration

The Adjacent Indel tag is used when a somatic SNP/DNP/TNP was possibly caused by misalignment around a germline or somatic insertion/deletion (indel). By default, CaMutQC filters any SNV within **10** bp of an indel with length <= **50** bp found in the tumor sample.

```
MAF_adj <- mutFilterAdj(MAFdat, maxIndelLen=40, minInterval=15)
table(MAF_adj$CaTag)
```

```
##
##  0 0A
## 85  2
```

There are 2 point mutations labeled by flag **A** in the above example, because they are within 15 bps of an indel with length <= 40.

#### 0.6.1.4 Normal depth filtration

To avoid miscalling germline variants and to improve the quality of variants [3](#refer), CaMutQC supports filtration on normal depth for both dbsnp/non-dbsnp variants, where cutoffs are **19** and **8** respectively.

```
MAF_normaldp <- mutFilterNormalDP(MAFdat, dbsnpCutoff=19, nonCutoff=8)
table(MAF_normaldp$CaTag)
```

```
##
##  0
## 87
```

Based on the results, all mutations pass this filtration under default settings.

#### 0.6.1.5 Panel of Normals filtration

Panel of Normals (PON) is a type of resource used in somatic variant analysis. Basically, if a variant is found in a panel of normals, or is found in more than two normal samples, it is unlikely to be a driven variant during tumorigenesis or tumor development. PON filtration has been widely used in many researches and projects to discard non-driven variants [4](#refer) [5](#refer)
[6](#refer).

A PON data set can be generated by users through sequencing a number of normal samples that are as technically similar as possible to the tumor (same exome or genome preparation methods, sequencing technology and so on). Or, the PON data set can also be directly obtained from GATK, which is viewed as one of the most effective filters for false-positive, contamination, and germline variants [3](#refer).

Due to potential copyright issues, **PON files are NOT contained in CaMutQC package**. But we recommend public GATK panels of normals data as PON files, and they can be easily accessed from GATK resource bundle:

GRCh38: **`gs://gatk-best-practices/somatic-hg38/1000g_pon.hg38.vcf.gz`**

GRCh37: **`gs://gatk-best-practices/somatic-b37/Mutect2-exome-panel.vcf`**

```
MAF_pon <- mutFilterPON(MAFdat,
                        PONfile=system.file("extdata", "PON_test.txt",
                                            package="CaMutQC"), PONformat="txt")
table(MAF_pon$CaTag)
```

```
##
##  0 0P
## 86  1
```

Here, we use a random PON file as an example to display how this function works, and 1 mutation is found in the PON file, and thus labeled by **P** flag.

#### 0.6.1.6 Database filtration

Some database published germline variants and recurrent artifacts in distinct races. In CaMutQC, based on the parameters we collected [3](#refer) [4](#refer) [7](#refer), potential germline variants is removed based on annotation from those databases (if available) unless the allele frequency of a mutation recorded in those databases is lower than the VAF threshold (**0.01**) or the CliVar/OMIM/HGMD flags it as pathogenic.

[COSMIC](https://cancer.sanger.ac.uk/cosmic/) (the Catalogue of Somatic Mutations In Cancer) has the most comprehensive resource for exploring the impact of somatic mutations in oncology. The team has assembled a list of genes that are somatically mutated and causally implicated in human cancer [8](#refer), which is called the The Cancer Gene Census and is updated periodically with new genes. In VCF file annotated by VEP, the `Existing_variation` column indicates a gene is in this COSMIC list if it has an annotation ID starts with `COSV`, `COSM` or `COSN`.

By default, CaMutQC filters variants recorded in **ExAC**, **Genomesprojects1000**, **ESP6500** and **gnomAD**, and always keeps variants in **COSMIC** no matter they are present in any germline database or not.

```
# labels can be added
MAF_db <- mutFilterDB(MAFdat, dbSNP=TRUE, dbVAF=0.01)
table(MAF_db$CaTag)
```

```
##
##  0 0D
## 46 41
```

We can see from the results that 41 mutations are labeled by **D** flag when we set the database VAF cutoff as 0.01 and filter mutations in the dbSNP database, much more than the mutations labeled in previous steps. Since this function is a part of the candidate variant selection process, more mutations might be labeled due to strict conditions and thresholds.

#### 0.6.1.7 Variant type filtration

Most studies relate to cancer somatic mutations keep certain types of variants in order to better target candidate variants, among which **`exonic`** and **`nonsynonymous`** are two of the most widely used categories for filtration [3](#refer) [9](#refer) [10](#refer).

In CaMutQC, these two categories can be chosen in this step and **`exonic`** is the default option, while **`nonsynonymous`** will leave users non-synonymous variants. More details could be found at [Ensembl Variation](https://m.ensembl.org/info/genome/variation/prediction/predicted_data.html).

* Variant classifications filtered when set as exonic: **`RNA`, `Intron`, `IGR`, `5\'Flank`, `3\'Flank`, `5\'UTR`, `3\'UTR`**
* Variant classifications filtered when set as nonsynonymous: **`3'UTR`, `5\'UTR`, `3\'Flank`, `Targeted_Region`, `Silent`, `Intron`, `RNA`, `IGR`, `Splice_Region`, `5\'Flank`, `lincRNA`,`De_novo_Start_InFrame`, `De_novo_Start_OutOfFrame`, `Start_Codon_Ins`, `Start_Codon_SNP`, `Stop_Codon_Del`**

```
MAF_type <- mutFilterType(MAFdat, keepType='nonsynonymous')
table(MAF_type$CaTag)
```

```
##
##  0 0T
## 12 75
```

```
table(MAF_type$Variant_Classification[which(MAF_type$CaTag == '0')])
```

```
##
##      In_Frame_Del Missense_Mutation
##                 1                11
```

75 synonymous mutations are labeled in this step, and the remained nonsynonymous mutations are more likely to be related to cancer development and progress.

#### 0.6.1.8 Region selection

In this step, users can further select variants related to cancer development by providing an additional BED file (or a `.rds` file with a `bed` variable in it), and variants will be searched only in target regions covered in the BED file. Besides, parameter `bedFilter` can be set as `TRUE` to clean the bed file (only leaves segments in `Chr1-Chr22`, `ChrX` and `ChrY`).

```
MAF_reg <- mutFilterReg(MAFdat, bedFilter = TRUE,
                        bedFile=system.file("extdata/bed/panel_hg19",
                                            "FlCDx-hg19.rds", package="CaMutQC"))
table(MAF_reg$CaTag)
```

```
##
## 0R
## 87
```

No mutation is within the target region provided in this case, so all mutations get an **R** flag.

### 0.6.2 Overall filtration

sub-functions mentioned above are divided into two groups according to their definitions and the categories they belong to, which can be reached through advanced function `mutFilterTech` and `mutSelection` respectively. Each advanced function is composed of multiple sub-functions that apply filtration on variants from different aspects but the same category. After passing through the advanced filter function, each variant may be labeled with more than one flag that shows the filtration results.

In addition, `mutFilterCom` function is an upper function that combines `mutFilterTech` and `mutSelection`, so any parameter in sub-functions can be set in `mutFilterCom`.

#### 0.6.2.1 Potential artifacts filtration

Function `mutFilterTech` combines filtration strategies for removing potential artifacts, including sequencing quality, strand of bias, normal DP, PON and adjacent indel filtration.

Some variant callers add a tag if a variant pass the post-filtration after calling. With CaMutQC, users can set a standard tag found in the FILTER column of VCF file to keep variants. **`PASS`** is set as the default tag.

```
MAF_tech <- mutFilterTech(MAFdat, panel="Customized", tumorDP=8, minInterval=9,
                          tagFILTER=NULL, progressbar=FALSE,
                          PONfile=system.file("extdata", "PON_test.txt",
                                              package="CaMutQC"), PONformat="txt")
table(MAF_tech$CaTag)
```

```
##
##   0  0A  0P  0Q 0QA  0S
##  46   1   1  32   1   6
```

There are 41 mutations labeled by `mutFilterTech` in the above example, and 1 mutations have 2 flags, suggesting it is more likely to be a false positive under current settings.

#### 0.6.2.2 Candidate variant selection

In most cases, basic filtration by removing potential artifacts is not enough for selecting candidate variants that participate in the formation and development of tumor, because a number of germline variants or variants that do not influence phenotype are still remained in the data set. Therefore, candidate variant selection is a necessary step for downstream analyses.

The whole selection process in CaMutQC is composed of database filtration, variant type filtration and region selection, all incorporated in the `mutSelection` function.

```
MAF_selec <- mutSelection(MAFdat, dbVAF=0.02, keepType='nonsynonymous', progressbar=FALSE)
table(MAF_selec$CaTag)
```

```
##
##   0 0DT  0T
##  12   7  68
```

12 mutations are selected as candidates by `mutSelection` after filtering synonymous mutations and mutations with VAF >= 0.02 in databases.

#### 0.6.2.3 Combined function: `mutFilerCom`

A main function of CaMutQC is `mutFilterCom`, which integrates all sub-functions into a big function. And it includes other functions that make CaMutQC an interactive and powerful tool, for example, you can export the code, along with the parameters you set by turning on the `codelog` setting and specify `codelogFile`.

```
MAFCom <- mutFilterCom(MAFdat, panel="WES", report=FALSE, TMB=FALSE, progressbar=FALSE,
                       PONfile=system.file("extdata", "PON_test.txt",
                                           package="CaMutQC"), PONformat="txt")
table(MAFCom$CaTag)
```

```
##
##     0    0Q  0QAT  0QDT  0QPT 0QSDT  0QST   0QT    0T
##    10    12     2     6     1     1     5    33    17
```

`mutFilterCom` function is the combination of `mutFilterTech` and `mutSelection`, which labels 77 mutations in our case. The results above clearly show the status of each mutation, offering users much information for further filtration and analyses.

##### 0.6.2.3.1 Filter report

By default, a vivid and detailed filter report will be saved automatically each time after running `mutFilterCom`. An example filter report can be found [here](https://github.com/likelet/CaMutQC/blob/WX/docs/FilterReport.html).

##### 0.6.2.3.2 TMB calculation

`mutFilterCom` also supports the calculation of TMB. Details about TMB can be found in [Mutational analysis](#tmb) section.

```
MAFCom_tmb <- mutFilterCom(MAFdat, panel="WES", assay="Customized", report=FALSE, TMB=TRUE,
                           bedFile=system.file("extdata/bed/panel_hg38",
                                               "Pan-cancer-hg38.rds", package="CaMutQC"),
                           PONfile=system.file("extdata", "PON_test.txt", package="CaMutQC"),
                           PONformat="txt", progressbar=FALSE, verbose=FALSE)
```

```
## Warning in calTMB(maf, bedFile = bedFile, assay = assay, genelist = genelist, : Bed files in CaMutQC are not accurate. The result serves only as a reference.
```

```
## Method used to calculate TMB: Customized.
```

```
## Estimated TMB is: 0.847.
```

When running `mutFilterCom`, `mutFilterTech` or `mutSelection`, a progress bar and some messages will display by default to notify users how the task goes, as well as some potential issues. Users can turn off the message by setting `verbose=FALSE`. When `TMB=TRUE`, the TMB will be calculated using a specific assay and printed out on the screen. TMB is 0.847 in this case.

## 0.7 Customized filtration

### 0.7.1 Cancer type-based filtration

With CaMutQC, users are able to filter and select cancer somatic mutations according to cancer types, where thresholds for parameters all come from classical studies. `mutFilterCan` function integrates 11 cancer types so far, with different parameters for each cancer type, to achieve more precise and customized filtrations.

Cancer types supported in CaMutQC: **COADREAD**, **BRCA**, **LIHC**, **LAML**, **LCML**, **UCEC**, **UCS**, **BLCA**, **KIRC**, **KIRP** and **STAD**.

```
MAFCan <- mutFilterCan(MAFdat, cancerType='LAML', report=FALSE, TMB=FALSE,
                       progressbar=FALSE,
                       PONfile=system.file("extdata", "PON_test.txt",
                                           package="CaMutQC"), PONformat="txt")
table(MAFCan$CaTag)
```

```
##
##   0  0D 0PD  0Q
##  33  48   1   5
```

After applying the filtering strategies of Acute myeloid leukemia (LAML), 33 out of 87 mutations are kept.

### 0.7.2 Reference-based filtration

Sometimes, we may want to apply the same set of strategies in another study, to become comparable with it. So far, filtering strategies used in five studies are provided in CaMutQC. By passing one of the references in the correct format into `mutFilterRef` function, all filtering strategies in that study will be applied automatically on your data.

```
MAFRef <- mutFilterRef(MAFdat, reference="Zhu_et_al-Nat_Commun-2020-KIRP",
                       report=FALSE, TMB=FALSE, progressbar=FALSE,
                       PONfile=system.file("extdata", "PON_test.txt",
                                           package="CaMutQC"), PONformat="txt")
table(MAFRef$CaTag)
```

```
##
##   0  0D 0PD  0Q 0QD
##  34  30   1  12  10
```

After applying the same strategies used in `Zhu_et_al-Nat_Commun-2020-KIRP`, 34 mutations are left without any flag.

## 0.8 Mutational analysis

Tumor Mutational Burden (TMB) refers to the number of somatic non-synonymous mutations per megabase pair (Mb) in a specific genomic region. In 2015, tumor non-synonymous mutation burden was first confirmed to be related to PD1/PD-L1 cancer immunotherapy [11](#refer). Through the analysis of mutation burden of patients with non-small cell lung cancer, the clinical response and survival rate and other indicators, researchers confirmed that the higher TMB of cancer patients have, the better effect of tumor immunotherapy would get. This conclusion was subsequently verified in other cancer types such as malignant melanoma [12](#refer) and small cell lung cancer [13](#refer). Therefore, TMB has become one of the predictive biomarkers of immune checkpoint and inhibitor immunotherapy in cancer treatment [14](#refer).

There are many assays for TMB measurement, including WGS, WES, targeted sequencing using gene panels, and sequencing of circulating tumor DNA in tumor samples or blood [15](#refer). Different from scientific research, conventional method of calculating TMB in clinical practice is to target-sequence tumor samples, which is to hybridize and capture the exon and intron regions of a certain number of cancer-related genes, without the need for WES sequencing. Currently, the most widely used panels are [FoundationOneCDx](https://www.foundationmedicine.com/test/foundationone-cdx) (F1CDx) and [MSK-IMPACT](https://www.mskcc.org/msk-impact) [9](#refer). The former only needs to sequence tumor samples, while the latter requires both the tumor sample and its matched normal sample to be sequenced. Both of them have certification from US Food and Drug Administration (FDA).

CaMutQC supports four assays for TMB calculation, including FoundationOne, MSK-IMPACT (3 versions of genelist), Pan-cancer panel [16](#refer) and WES. By default, TMB is calculated using MSK-IMPACT method (gene panel version 3, 468 genes). Also, users are free to apply their own methods by setting parameter `assay` as `Customized`.

**Note: the bed region files mentioned above are generated only from CDS regions, NOT the exact bed region, so the TMB results are only for reference.**

```
tmb_value <- calTMB(MAFdat, assay='Customized',
                    bedFile=system.file("extdata/bed/panel_hg38","Pan-cancer-hg38.rds",
                                        package="CaMutQC"))
```

```
## Warning in calTMB(MAFdat, assay = "Customized", bedFile = system.file("extdata/bed/panel_hg38", : Bed files in CaMutQC are not accurate. The result serves only as a reference.
```

```
tmb_value
```

```
## [1] 0.847
```

TMB value estimated by CaMutQC for this random MAF is 0.847. This is only an example case so it does not have any clinical meaning to be interpreted, but yours may have.

## 0.9 Union strategy

After verifying on published data sets, We believed combining CaMutQC-filtered mutations from multiple variant callers is a great approach to better eliminate the bias of single mutation caller while rescuing potential false negative mutations. In this pipeline, the same data set processed by three variant callers ([MuSE](http://bioinformatics.mdanderson.org/main/MuSE), ([MuTect2](https://gatk.broadinstitute.org/hc/en-us/articles/360037593851-Mutect2) and [VarScan2](http://varscan.sourceforge.net/)) first goes through CaMutQC filtration respectively and removes labeled mutations. Then `processMut` function takes three MAF data frames and returns the union of mutations. And `processMut` can also take intersection of MAFs when asked.

![](data:image/png;base64...)

```
maf_MuSE <- vcfToMAF(system.file("extdata/Multi-caller",
                                 "WES_EA_T_1.MuSE.vep.vcf", package="CaMutQC"))
maf_MuSE_f <- mutFilterCom(maf_MuSE, report=FALSE, TMB=FALSE,
                           PONfile=system.file("extdata",
                                               "PON_test.txt", package="CaMutQC"),
                           PONformat = "txt", progressbar=FALSE)
maf_VarScan2 <- vcfToMAF(system.file("extdata/Multi-caller",
                                     "WES_EA_T_1_varscan_filter_snp.vep.vcf", package="CaMutQC"))
maf_VarScan2_f <- mutFilterCom(maf_VarScan2, report=FALSE, TMB=FALSE,
                               PONfile=system.file("extdata",
                                                   "PON_test.txt", package="CaMutQC"),
                               PONformat="txt", progressbar=FALSE)
MAFdat_f <- mutFilterCom(MAFdat, report=FALSE, TMB=FALSE,
                         PONfile=system.file("extdata", "PON_test.txt", package= "CaMutQC"),
                         PONformat="txt", progressbar=FALSE)
mafs <- list(maf_MuSE_f, maf_VarScan2_f, MAFdat_f)
maf_union <- processMut(mafs, processMethod = "union")
maf_union
```

Here, three dataset are first converted from VCF to MAF, then filtered by `mutFilterCom`, and finally taken union. Due to the fact that even the same mutation have different depths, VAFs, etc in different dataset, only 7 columns will be kept after taking union, as displayed above.

## 0.10 Call strategy set by your name

Tired of finding or memorizing best parameters? You can share your own filtration strategies/parameters set in the [CaMutQC community](https://github.com/likelet/CaMutQC/issues) by opening a new issue with a `parameter set` label. Every six months, CaMutQC will be updated to include top-rated parameter sets in `mutFilterRef` function, with the name of author’s Github username. Start using, sharing and contributing NOW!

## 0.11 SessionInfo

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] CaMutQC_1.6.0    BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3      shape_1.4.6.1           jsonlite_2.0.0
##   [4] magrittr_2.0.4          ggtangle_0.0.7          farver_2.1.2
##   [7] rmarkdown_2.30          GlobalOptions_0.1.2     fs_1.6.6
##  [10] vctrs_0.6.5             memoise_2.0.1           ggtree_4.0.0
##  [13] htmltools_0.5.8.1       gridGraphics_0.5-1      pracma_2.4.6
##  [16] sass_0.4.10             bslib_0.9.0             htmlwidgets_1.6.4
##  [19] plyr_1.8.9              cachem_1.1.0            igraph_2.2.1
##  [22] lifecycle_1.0.4         iterators_1.0.14        pkgconfig_2.0.3
##  [25] Matrix_1.7-4            R6_2.6.1                fastmap_1.2.0
##  [28] gson_0.1.0              clue_0.3-66             digest_0.6.37
##  [31] aplot_0.2.9             enrichplot_1.30.0       colorspace_2.1-2
##  [34] maftools_2.26.0         patchwork_1.3.2         AnnotationDbi_1.72.0
##  [37] S4Vectors_0.48.0        RSQLite_2.4.3           org.Hs.eg.db_3.22.0
##  [40] vegan_2.7-2             httr_1.4.7              mgcv_1.9-3
##  [43] compiler_4.5.1          withr_3.0.2             bit64_4.6.0-1
##  [46] fontquiver_0.2.1        doParallel_1.0.17       S7_0.2.0
##  [49] BiocParallel_1.44.0     DBI_1.2.3               R.utils_2.13.0
##  [52] MASS_7.3-65             MesKit_1.20.0           rappdirs_0.3.3
##  [55] rjson_0.2.23            DNAcopy_1.84.0          permute_0.9-8
##  [58] tools_4.5.1             ape_5.8-1               quadprog_1.5-8
##  [61] R.oo_1.27.1             glue_1.8.0              nlme_3.1-168
##  [64] GOSemSim_2.36.0         grid_4.5.1              cluster_2.1.8.1
##  [67] reshape2_1.4.4          memuse_4.2-3            fgsea_1.36.0
##  [70] generics_0.1.4          gtable_0.3.6            R.methodsS3_1.8.2
##  [73] tidyr_1.3.1             pinfsc50_1.3.0          data.table_1.17.8
##  [76] XVector_0.50.0          BiocGenerics_0.56.0     ggrepel_0.9.6
##  [79] foreach_1.5.2           pillar_1.11.1           stringr_1.5.2
##  [82] yulab.utils_0.2.1       circlize_0.4.16         splines_4.5.1
##  [85] dplyr_1.1.4             treeio_1.34.0           lattice_0.22-7
##  [88] survival_3.8-3          bit_4.6.0               tidyselect_1.2.1
##  [91] fontLiberation_0.1.0    GO.db_3.22.0            ComplexHeatmap_2.26.0
##  [94] Biostrings_2.78.0       knitr_1.50              fontBitstreamVera_0.1.1
##  [97] bookdown_0.45           IRanges_2.44.0          Seqinfo_1.0.0
## [100] stats4_4.5.1            xfun_0.53               Biobase_2.70.0
## [103] matrixStats_1.5.0       DT_0.34.0               stringi_1.8.7
## [106] lazyeval_0.2.2          ggfun_0.2.0             yaml_2.3.10
## [109] evaluate_1.0.5          codetools_0.2-20        gdtools_0.4.4
## [112] tibble_3.3.0            qvalue_2.42.0           BiocManager_1.30.26
## [115] ggplotify_0.1.3         cli_3.6.5               systemfonts_1.3.1
## [118] jquerylib_0.1.4         dichromat_2.0-0.1       Rcpp_1.1.0
## [121] vcfR_1.15.0             png_0.1-8               parallel_4.5.1
## [124] ggplot2_4.0.0           blob_1.2.4              mclust_6.1.1
## [127] clusterProfiler_4.18.0  DOSE_4.4.0              phangorn_2.12.1
## [130] viridisLite_0.4.2       tidytree_0.4.6          ggiraph_0.9.2
## [133] ggridges_0.5.7          scales_1.4.0            purrr_1.1.0
## [136] crayon_1.5.3            GetoptLong_1.0.5        rlang_1.1.6
## [139] cowplot_1.2.0           fastmatch_1.1-6         KEGGREST_1.50.0
```

## 0.12 Reference

1. Guo Y, Li J, Li CI, Long J, Samuels DC, Shyr Y. The effect of strand bias in Illumina short-read sequencing data. BMC Genomics. 2012;13:666. Published 2012 Nov 24. doi:10.1186/1471-2164-13-666
2. Guo Y, Cai Q, Samuels DC, et al. The use of next generation sequencing technology to study the effect of radiation therapy on mitochondrial DNA mutation. Mutat Res. 2012;744(2):154-160. doi:10.1016/j.mrgentox.2012.02.006
3. Ellrott K, Bailey MH, Saksena G, et al. Scalable Open Science Approach for Mutation Calling of Tumor Exomes Using Multiple Genomic Pipelines. Cell Syst. 2018;6(3):271-281.e7. doi:10.1016/j.cels.2018.03.002
4. Pereira B, Chin SF, Rueda OM, et al. The somatic mutation profiles of 2,433 breast cancers refines their genomic and transcriptomic landscapes. Nat Commun. 2016;7:11479. Published 2016 May 10. doi:10.1038/ncomms11479
5. Brastianos PK, Carter SL, Santagata S, et al. Genomic Characterization of Brain Metastases Reveals Branched Evolution and Potential Therapeutic Targets. Cancer Discov. 2015;5(11):1164-1177. doi:10.1158/2159-8290.CD-15-0369
6. Sethi NS, Kikuchi O, Duronio GN, et al. Early TP53 alterations engage environmental exposures to promote gastric premalignancy in an integrative mouse model. Nat Genet. 2020;52(2):219-230. doi:10.1038/s41588-019-0574-9
7. Xue R, Chen L, Zhang C, et al. Genomic and Transcriptomic Profiling of Combined Hepatocellular and Intrahepatic Cholangiocarcinoma Reveals Distinct Molecular Subtypes. Cancer Cell. 2019;35(6):932-947.e8. doi:10.1016/j.ccell.2019.04.007
8. Futreal PA, Coin L, Marshall M, et al. A census of human cancer genes. Nat Rev Cancer. 2004;4(3):177-183. doi:10.1038/nrc1299
9. Cheng DT, Mitchell TN, Zehir A, et al. Memorial Sloan Kettering-Integrated Mutation Profiling of Actionable Cancer Targets (MSK-IMPACT): A Hybridization Capture-Based Next-Generation Sequencing Clinical Assay for Solid Tumor Molecular Oncology. J Mol Diagn. 2015;17(3):251-264. doi:10.1016/j.jmoldx.2014.12.006
10. Sakamoto H, Attiyeh MA, Gerold JM, et al. The Evolutionary Origins of Recurrent Pancreatic Cancer. Cancer Discov. 2020;10(6):792-805. doi:10.1158/2159-8290.CD-19-1508
11. Rizvi NA, Hellmann MD, Snyder A, et al. Cancer immunology. Mutational landscape determines sensitivity to PD-1 blockade in non-small cell lung cancer. Science. 2015;348(6230):124-128. doi:10.1126/science.aaa1348
12. Snyder A, Makarov V, Merghoub T, et al. Genetic basis for clinical response to CTLA-4 blockade in melanoma [published correction appears in N Engl J Med. 2018 Nov 29;379(22):2185]. N Engl J Med. 2014;371(23):2189-2199. doi:10.1056/NEJMoa1406498
13. Hellmann MD, Callahan MK, Awad MM, et al. Tumor Mutational Burden and Efficacy of Nivolumab Monotherapy and in Combination with Ipilimumab in Small-Cell Lung Cancer [published correction appears in Cancer Cell. 2019 Feb 11;35(2):329]. Cancer Cell. 2018;33(5):853-861.e4. doi:10.1016/j.ccell.2018.04.001
14. Lee M, Samstein RM, Valero C, Chan TA, Morris LGT. Tumor mutational burden as a predictive biomarker for checkpoint inhibitor immunotherapy. Hum Vaccin Immunother. 2020;16(1):112-115. doi:10.1080/21645515.2019.1631136
15. Stenzinger A, Allen JD, Maas J, et al. Tumor mutational burden standardization initiatives: Recommendations for consistent tumor mutational burden assessment in clinical samples to guide immunotherapy treatment decisions. Genes Chromosomes Cancer. 2019;58(8):578-588. doi:10.1002/gcc.22733
16. Xu Z, Dai J, Wang D, et al. Assessment of tumor mutation burden calculation from gene panel sequencing data. Onco Targets Ther. 2019;12:3401-3409. Published 2019 May 6. doi:10.2147/OTT.S196638