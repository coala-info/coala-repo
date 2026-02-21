# maftools : Summarize, Analyze and Visualize MAF Files

#### Anand Mayakonda

#### 2025-10-30

![](data:image/svg+xml;base64...)

# 1 Introduction

With advances in Cancer Genomics, [Mutation Annotation Format](https://docs.gdc.cancer.gov/Data/File_Formats/MAF_Format/) (MAF) is being widely accepted and used to store somatic variants detected. [The Cancer Genome Atlas](http://cancergenome.nih.gov) Project has sequenced over 30 different cancers with sample size of each cancer type being over 200. [Resulting data](https://wiki.nci.nih.gov/display/TCGA/TCGA%2BMAF%2BFiles) consisting of somatic variants are stored in the form of [Mutation Annotation Format](https://docs.gdc.cancer.gov/Data/File_Formats/MAF_Format/). This package attempts to summarize, analyze, annotate and visualize MAF files in an efficient manner from either TCGA sources or any in-house studies as long as the data is in MAF format.

## 1.1 Citation

If you find this tool useful, please cite:

---

***Mayakonda A, Lin DC, Assenov Y, Plass C, Koeffler HP. 2018. Maftools: efficient and comprehensive analysis of somatic variants in cancer. [Genome Research. PMID: 30341162](https://doi.org/10.1101/gr.239244.118)***

---

# 2 Generating MAF files

* For VCF files or simple tabular files, easy option is to use [vcf2maf](https://github.com/mskcc/vcf2maf) utility which will annotate VCFs, prioritize transcripts, and generates an MAF. Recent updates to gatk has also enabled [funcotator](https://gatk.broadinstitute.org/hc/en-us/articles/360035889931-Funcotator-Information-and-Tutorial) to genrate MAF files.
* If you’re using [ANNOVAR](http://annovar.openbioinformatics.org/en/latest/) for variant annotations, maftools has a handy function `annovarToMaf` for converting tabular annovar outputs to MAF.

# 3 MAF field requirements

MAF files contain many fields ranging from chromosome names to cosmic annotations. However most of the analysis in maftools uses following fields.

* Mandatory fields: **Hugo\_Symbol, Chromosome, Start\_Position, End\_Position, Reference\_Allele, Tumor\_Seq\_Allele2, Variant\_Classification, Variant\_Type and Tumor\_Sample\_Barcode**.
* Recommended optional fields: non MAF specific fields containing VAF (Variant Allele Frequency) and amino acid change information.

Complete specification of MAF files can be found on [NCI GDC documentation page](https://docs.gdc.cancer.gov/Data/File_Formats/MAF_Format/).

This vignette demonstrates the usage and application of maftools on an example MAF file from TCGA LAML cohort [1](#references).

# 4 Installation

```
if (!require("BiocManager"))
    install.packages("BiocManager")
BiocManager::install("maftools")
```

# 5 Overview of the package

maftools functions can be categorized into mainly Visualization and Analysis modules. Each of these functions and a short description is summarized as shown below. Usage is simple, just read your MAF file with `read.maf` (along with copy-number data if available) and pass the resulting MAF object to the desired function for plotting or analysis.

![](data:image/png;base64...) Besides the MAF files, maftools also facilitates processing of BAM files. Please refer to below vignettes and sections to learn more.

* [Copy number analysis](https://bioconductor.org/packages/devel/bioc/vignettes/maftools/inst/doc/cnv_analysis.html) with [ASCAT](https://github.com/VanLoo-lab/ascat) and [mosdepth](https://github.com/brentp/mosdepth)
* [Generate personalized cancer report](https://bioconductor.org/packages/release/bioc/vignettes/maftools/inst/doc/cancer_hotspots.html) for known somatic [hotspots](https://www.cancerhotspots.org/)
* [Sample mismatch and relatedness analysis](https://bioconductor.org/packages/devel/bioc/vignettes/maftools/inst/doc/maftools.html#12_Sample_swap_identification)

# 6 Reading and summarizing maf files

## 6.1 Required input files

* an MAF file - can be gz compressed. Required.
* an optional but recommended clinical data associated with each sample/Tumor\_Sample\_Barcode in MAF.
* an optional copy number data if available. Can be GISTIC output or a custom table containing sample names, gene names and copy-number status (`Amp` or `Del`).

## 6.2 Reading MAF files.

`read.maf` function reads MAF files, summarizes it in various ways and stores it as an MAF object. Even though MAF file is alone enough, it is recommended to provide annotations associated with samples in MAF. One can also integrate copy number data if available.

Note that by default, Variants with [High/Moderate consequences](https://m.ensembl.org/info/genome/variation/prediction/predicted_data.html) are considered as non-synonymous. You change this behavior with the argument `vc_nonSyn` in `read.maf`.

```
library(maftools)
```

```
#path to TCGA LAML MAF file
laml.maf = system.file('extdata', 'tcga_laml.maf.gz', package = 'maftools')
#clinical information containing survival information and histology. This is optional
laml.clin = system.file('extdata', 'tcga_laml_annot.tsv', package = 'maftools')

laml = read.maf(maf = laml.maf, clinicalData = laml.clin)
```

```
## -Reading
## -Validating
## -Silent variants: 475
## -Summarizing
## -Processing clinical data
## -Finished in 0.323s elapsed (0.364s cpu)
```

## 6.3 MAF object

Summarized MAF file is stored as an MAF object. MAF object contains main maf file, summarized data and any associated sample annotations.

There are accessor methods to access the useful slots from MAF object.

```
#Typing laml shows basic summary of MAF file.
laml
```

```
## An object of class  MAF
##                    ID          summary  Mean Median
##                <char>           <char> <num>  <num>
##  1:        NCBI_Build               37    NA     NA
##  2:            Center genome.wustl.edu    NA     NA
##  3:           Samples              193    NA     NA
##  4:            nGenes             1241    NA     NA
##  5:   Frame_Shift_Del               52 0.269      0
##  6:   Frame_Shift_Ins               91 0.472      0
##  7:      In_Frame_Del               10 0.052      0
##  8:      In_Frame_Ins               42 0.218      0
##  9: Missense_Mutation             1342 6.953      7
## 10: Nonsense_Mutation              103 0.534      0
## 11:       Splice_Site               92 0.477      0
## 12:             total             1732 8.974      9
```

```
#Shows sample summry.
getSampleSummary(laml)
#Shows gene summary.
getGeneSummary(laml)
#shows clinical data associated with samples
getClinicalData(laml)
#Shows all fields in MAF
getFields(laml)
#Writes maf summary to an output file with basename laml.
write.mafSummary(maf = laml, basename = 'laml')
```

# 7 Visualization

## 7.1 Plotting MAF summary.

We can use `plotmafSummary` to plot the summary of the maf file, which displays number of variants in each sample as a stacked barplot and variant types as a boxplot summarized by Variant\_Classification.

```
plotmafSummary(maf = laml, rmOutlier = TRUE, addStat = 'median', dashboard = TRUE, titvRaw = FALSE)
```

![](data:image/png;base64...)

Use `mafbarplot` for a minimal barplot of mutated genes.

## 7.2 Oncoplots

### 7.2.1 Drawing oncoplots

Better representation of maf file can be shown as oncoplots, also known as waterfall plots.

```
#oncoplot for top ten mutated genes.
oncoplot(maf = laml, top = 10)
```

![](data:image/png;base64...)

NOTE: Variants annotated as `Multi_Hit` are those genes which are mutated more than once in the same sample.

For more details on customisation see the [Customizing oncoplots](http://bioconductor.org/packages/devel/bioc/vignettes/maftools/inst/doc/oncoplots.html) vignette.

## 7.3 Transition and Transversions.

`titv` function classifies SNPs into [Transitions and Transversions](http://www.mun.ca/biology/scarr/Transitions_vs_Transversions.html) and returns a list of summarized tables in various ways. Summarized data can also be visualized as a boxplot showing overall distribution of six different conversions and as a stacked barplot showing fraction of conversions in each sample.

```
laml.titv = titv(maf = laml, plot = FALSE, useSyn = TRUE)
#plot titv summary
plotTiTv(res = laml.titv)
```

![](data:image/png;base64...)

## 7.4 Lollipop plots for amino acid changes

`lollipopPlot` function requires us to have amino acid changes information in the maf file. However MAF files have no clear guidelines on naming the field for amino acid changes, with different studies having different field (or column) names for amino acid changes. By default, `lollipopPlot` looks for column `AAChange`, and if its not found in the MAF file, it prints all available fields with a warning message. For below example, MAF file contains amino acid changes under a field/column name ‘Protein\_Change’. We will manually specify this using argument `AACol`.

By default lollipopPlot uses the longest isoform of the gene.

### 7.4.1 MAF as an input

```
#lollipop plot for DNMT3A, which is one of the most frequent mutated gene in Leukemia.
lollipopPlot(
  maf = laml,
  gene = 'DNMT3A',
  AACol = 'Protein_Change',
  showMutationRate = TRUE,
  labelPos = 882
)
```

```
## 3 transcripts available. Use arguments refSeqID or proteinID to manually specify tx name.
```

```
##      HGNC refseq.ID protein.ID aa.length
##    <char>    <char>     <char>     <num>
## 1: DNMT3A NM_022552  NP_072046       912
## 2: DNMT3A NM_153759  NP_715640       723
## 3: DNMT3A NM_175629  NP_783328       912
```

```
## Using longer transcript NM_022552 for now.
```

```
## Removed 3 mutations for which AA position was not available
```

![](data:image/png;base64...)

### 7.4.2 Custom data as an input

Instead of an `MAF` a custom data can also be used for plotting. Input should be a two column data frame with pos and counts.

```
#example data
my_data = data.frame(pos = sample.int(912, 15, replace = TRUE), count = sample.int(30, 15, replace = TRUE))
head(my_data)
```

```
##   pos count
## 1 489    15
## 2 861    27
## 3 632    25
## 4  33    20
## 5 624    18
## 6 375    17
```

```
lollipopPlot(data = my_data, gene = "DNMT3A")
```

```
## 3 transcripts available. Use arguments refSeqID or proteinID to manually specify tx name.
```

```
##      HGNC refseq.ID protein.ID aa.length
##    <char>    <char>     <char>     <num>
## 1: DNMT3A NM_022552  NP_072046       912
## 2: DNMT3A NM_153759  NP_715640       723
## 3: DNMT3A NM_175629  NP_783328       912
```

```
## Using longer transcript NM_022552 for now.
```

![](data:image/png;base64...)

General protein domains can be drawn with the function `plotProtein`

```
plotProtein(gene = "TP53", refSeqID = "NM_000546")
```

![](data:image/png;base64...)

## 7.5 Rainfall plots

Cancer genomes, especially solid tumors are characterized by genomic loci with localized hyper-mutations [5](#references). Such hyper mutated genomic regions can be visualized by plotting inter variant distance on a linear genomic scale. These plots generally called rainfall plots and we can draw such plots using `rainfallPlot`. If `detectChangePoints` is set to TRUE, `rainfall` plot also highlights regions where potential changes in inter-event distances are located.

```
brca <- system.file("extdata", "brca.maf.gz", package = "maftools")
brca = read.maf(maf = brca, verbose = FALSE)
```

```
rainfallPlot(maf = brca, detectChangePoints = TRUE, pointSize = 0.4)
```

```
## Processing TCGA-A8-A08B..
```

```
## Kataegis detected at:
```

```
##    Chromosome Start_Position End_Position nMuts Avg_intermutation_dist  Size
##         <num>          <num>        <num> <int>                  <num> <num>
## 1:          8       98129348     98133560     7               702.0000  4212
## 2:          8       98398549     98403536     9               623.3750  4987
## 3:          8       98453076     98456466     9               423.7500  3390
## 4:          8      124090377    124096810    22               306.3333  6433
## 5:         12       97436055     97439705     7               608.3333  3650
## 6:         17       29332072     29336153     8               583.0000  4081
##    Tumor_Sample_Barcode   C>G   C>T
##                  <fctr> <int> <int>
## 1:         TCGA-A8-A08B     4     3
## 2:         TCGA-A8-A08B     1     8
## 3:         TCGA-A8-A08B     1     8
## 4:         TCGA-A8-A08B     1    21
## 5:         TCGA-A8-A08B     4     3
## 6:         TCGA-A8-A08B     4     4
```

![](data:image/png;base64...)

“Kataegis” are defined as those genomic segments containing six or more consecutive mutations with an average inter-mutation distance of less than or equal to 1,00 bp [5](#references).

## 7.6 Compare mutation load against TCGA cohorts

`tcgaCompare` uses mutation load from TCGA [MC3](https://gdc.cancer.gov/about-data/publications/mc3-2017) for comparing muttaion burden against 33 TCGA cohorts. Plot generated is [similar](http://www.nature.com/nature/journal/v500/n7463/fig_tab/nature12477_F1.html) to the one described in Alexandrov et al [5](#references).

```
laml.mutload = tcgaCompare(maf = laml, cohortName = 'Example-LAML', logscale = TRUE, capture_size = 50)
```

```
## Warning in FUN(X[[i]], ...): Removed 1 samples with zero mutations.
```

![](data:image/png;base64...)

## 7.7 Plotting VAF

This function plots Variant Allele Frequencies as a boxplot which quickly helps to estimate clonal status of top mutated genes (clonal genes usually have mean allele frequency around ~50% assuming pure sample)

```
plotVaf(maf = laml, vafCol = 'i_TumorVAF_WU')
```

![](data:image/png;base64...)

# 8 Processing copy-number data

## 8.1 Reading and summarizing gistic output files.

We can summarize output files generated by GISTIC programme. As mentioned earlier, we need four files that are generated by GISTIC, i.e, all\_lesions.conf\_XX.txt, amp\_genes.conf\_XX.txt, del\_genes.conf\_XX.txt and scores.gistic, where XX is the confidence level. See GISTIC documentation for details.

`readGistic` function can take above files provided manually, or a directory containing GISTIC results and import all the relevant files.

```
gistic_res_folder <- system.file("extdata", package = "maftools")
laml.gistic = readGistic(gisticDir = gistic_res_folder, isTCGA = TRUE)
```

```
## -Processing Gistic files..
## --Processing amp_genes.conf_99.txt
## --Processing del_genes.conf_99.txt
## --Processing scores.gistic
## --Summarizing by samples
```

```
#GISTIC object
laml.gistic
```

```
## An object of class  GISTIC
##           ID summary
##       <char>   <num>
## 1:   Samples     191
## 2:    nGenes    2622
## 3: cytoBands      16
## 4:       Amp     388
## 5:       Del   26481
## 6:     total   26869
```

Similar to MAF objects, there are methods available to access slots of GISTIC object - `getSampleSummary`, `getGeneSummary` and `getCytoBandSummary`. Summarized results can be written to output files using function `write.GisticSummary`.

## 8.2 Visualizing gistic results.

There are three types of plots available to visualize gistic results.

### 8.2.1 genome plot

```
gisticChromPlot(gistic = laml.gistic, markBands = "all")
```

![](data:image/png;base64...)

#### 8.2.1.1 Co-gisticChromPlot

Similarly, two GISTIC objects can be plotted side-by-side for cohort comparison. In this example, the same GISTIC object is used for demonstration.

```
coGisticChromPlot(gistic1 = laml.gistic, gistic2 = laml.gistic, g1Name = "AML-1", g2Name = "AML-2", type = 'Amp')
```

![](data:image/png;base64...)

Above plot shows distribution of amplification events. Change `type = 'Del'` to plot deletions.

### 8.2.2 Bubble plot

```
gisticBubblePlot(gistic = laml.gistic)
```

![](data:image/png;base64...)

### 8.2.3 oncoplot

This is similar to oncoplots except for copy number data. One can again sort the matrix according to annotations, if any. Below plot is the gistic results for LAML, sorted according to FAB classification. Plot shows that 7q deletions are virtually absent in M4 subtype where as it is widespread in other subtypes.

```
gisticOncoPlot(gistic = laml.gistic, clinicalData = getClinicalData(x = laml), clinicalFeatures = 'FAB_classification', sortByAnnotation = TRUE, top = 10)
```

![](data:image/png;base64...)

## 8.3 CBS segments

### 8.3.1 Summarizing chromosomal arm level CN

A multi-sample CBS segments file can be summarized to get the CN status of each cytoband and chromosomal arms. Below plot shows 5q deletions in a subset of AML samples. The function returns the plot data and the CN status of each chromosomal cytoband and arms for every sample.

```
laml.seg <- system.file("extdata", "LAML_CBS_segments.tsv.gz", package = "maftools")
segSummarize_results = segSummarize(seg = laml.seg)
```

![](data:image/png;base64...)

```
## Recurrent chromosomal arm aberrations
```

```
##        arm Variant_Classification     N
##     <char>                 <char> <int>
##  1:    5_q                   Loss     9
##  2:   16_q                   Loss     2
##  3:   21_q                   Gain     2
##  4:    7_q                   Loss     2
##  5:    1_p                   Gain     1
##  6:    1_q                   Gain     1
##  7:   11_p                   Loss     1
##  8:   11_q                   Gain     1
##  9:   12_p                   Loss     1
## 10:   18_p                   Loss     1
## 11:   19_q                   Gain     1
## 12:   19_p                   Gain     1
## 13:   20_q                   Loss     1
## 14:    3_p                   Loss     1
## 15:    7_p                   Loss     1
## 16:    8_q                   Gain     1
## 17:    9_q                   Loss     1
```

### 8.3.2 Visualizing CBS segments

```
tcga.ab.009.seg <- system.file("extdata", "TCGA.AB.3009.hg19.seg.txt", package = "maftools")
plotCBSsegments(cbsFile = tcga.ab.009.seg)
```

```
## No 'tsb' specified, plot head 1 sample. Set tsb='ALL' to plot all samples.
```

![](data:image/png;base64...)

# 9 Analysis

## 9.1 Somatic Interactions

Mutually exclusive or co-occurring set of genes can be detected using `somaticInteractions` function, which performs pair-wise Fisher’s Exact test to detect such significant pair of genes.

```
#exclusive/co-occurance event analysis on top 10 mutated genes.
somaticInteractions(maf = laml, top = 25, pvalue = c(0.05, 0.1))
```

![](data:image/png;base64...)

```
##       gene1  gene2       pValue oddsRatio    00    01    11    10        pAdj
##      <char> <char>        <num>     <num> <int> <int> <int> <int>       <num>
##   1:  ASXL1  RUNX1 0.0001541586 55.215541   176    12     4     1 0.003568486
##   2:   IDH2  RUNX1 0.0002809928  9.590877   164     9     7    13 0.006055880
##   3:   IDH2  ASXL1 0.0004030636 41.077327   172     1     4    16 0.008126283
##   4:   FLT3   NPM1 0.0009929836  3.763161   125    16    17    35 0.018664260
##   5:   SMC3 DNMT3A 0.0010451985 20.177713   144    42     6     1 0.018664260
##  ---
## 296:  RAD21  FAM5C 1.0000000000  0.000000   183     5     0     5 1.000000000
## 297:  PLCE1  FAM5C 1.0000000000  0.000000   184     5     0     4 1.000000000
## 298:  PLCE1  RAD21 1.0000000000  0.000000   184     5     0     4 1.000000000
## 299:   EZH2  RAD21 1.0000000000  0.000000   185     5     0     3 1.000000000
## 300:   EZH2  PLCE1 1.0000000000  0.000000   186     4     0     3 1.000000000
##                   Event         pair event_ratio
##                  <char>       <char>      <char>
##   1:       Co_Occurence ASXL1, RUNX1        4/13
##   2:       Co_Occurence  IDH2, RUNX1        7/22
##   3:       Co_Occurence  ASXL1, IDH2        4/17
##   4:       Co_Occurence   FLT3, NPM1       17/51
##   5:       Co_Occurence DNMT3A, SMC3        6/43
##  ---
## 296: Mutually_Exclusive FAM5C, RAD21        0/10
## 297: Mutually_Exclusive FAM5C, PLCE1         0/9
## 298: Mutually_Exclusive PLCE1, RAD21         0/9
## 299: Mutually_Exclusive  EZH2, RAD21         0/8
## 300: Mutually_Exclusive  EZH2, PLCE1         0/7
```

## 9.2 Detecting cancer driver genes based on positional clustering

maftools has a function `oncodrive` which identifies cancer genes (driver) from a given MAF. `oncodrive` is a based on algorithm [oncodriveCLUST](http://bg.upf.edu/group/projects/oncodrive-clust.php) which was originally implemented in Python. Concept is based on the fact that most of the variants in cancer causing genes are enriched at few specific loci (aka hot-spots). This method takes advantage of such positions to identify cancer genes. If you use this function, please cite [OncodriveCLUST article](http://bioinformatics.oxfordjournals.org/content/early/2013/07/31/bioinformatics.btt395.full) [7](#references).

```
laml.sig = oncodrive(maf = laml, AACol = 'Protein_Change', minMut = 5, pvalMethod = 'zscore')
```

```
## Warning in oncodrive(maf = laml, AACol = "Protein_Change", minMut = 5,
## pvalMethod = "zscore"): Oncodrive has been superseeded by OncodriveCLUSTL. See
## http://bg.upf.edu/group/projects/oncodrive-clust.php
```

```
head(laml.sig)
```

```
##    Hugo_Symbol Frame_Shift_Del Frame_Shift_Ins In_Frame_Del In_Frame_Ins
##         <char>           <int>           <int>        <int>        <int>
## 1:        IDH1               0               0            0            0
## 2:        IDH2               0               0            0            0
## 3:        NPM1               0              33            0            0
## 4:        NRAS               0               0            0            0
## 5:       U2AF1               0               0            0            0
## 6:         KIT               1               1            0            1
##    Missense_Mutation Nonsense_Mutation Splice_Site total MutatedSamples
##                <int>             <int>       <int> <num>          <int>
## 1:                18                 0           0    18             18
## 2:                20                 0           0    20             20
## 3:                 1                 0           0    34             33
## 4:                15                 0           0    15             15
## 5:                 8                 0           0     8              8
## 6:                 7                 0           0    10              8
##    AlteredSamples clusters muts_in_clusters clusterScores protLen   zscore
##             <int>    <int>            <int>         <num>   <int>    <num>
## 1:             18        1               18     1.0000000     414 5.546154
## 2:             20        2               20     1.0000000     452 5.546154
## 3:             33        2               32     0.9411765     294 5.093665
## 4:             15        2               15     0.9218951     189 4.945347
## 5:              8        1                7     0.8750000     240 4.584615
## 6:              8        2                9     0.8500000     976 4.392308
##            pval          fdr fract_muts_in_clusters
##           <num>        <num>                  <num>
## 1: 1.460110e-08 1.022077e-07              1.0000000
## 2: 1.460110e-08 1.022077e-07              1.0000000
## 3: 1.756034e-07 8.194826e-07              0.9411765
## 4: 3.800413e-07 1.330144e-06              1.0000000
## 5: 2.274114e-06 6.367520e-06              0.8750000
## 6: 5.607691e-06 1.308461e-05              0.9000000
```

We can plot the results using `plotOncodrive`.

```
plotOncodrive(res = laml.sig, fdrCutOff = 0.1, useFraction = TRUE, labelSize = 0.5)
```

![](data:image/png;base64...)

`plotOncodrive` plots the results as scatter plot with size of the points proportional to the number of clusters found in the gene. X-axis shows number of mutations (or fraction of mutations) observed in these clusters. In the above example, IDH1 has a single cluster and all of the 18 mutations are accumulated within that cluster, giving it a cluster score of one. For details on oncodrive algorithm, please refer to [OncodriveCLUST article](http://bioinformatics.oxfordjournals.org/content/early/2013/07/31/bioinformatics.btt395.full) [7](#references).

## 9.3 Adding and summarizing pfam domains

maftools comes with the function `pfamDomains`, which adds pfam domain information to the amino acid changes. `pfamDomain` also summarizes amino acid changes according to the domains that are affected. This serves the purpose of knowing what domain in given cancer cohort, is most frequently affected. This function is inspired from Pfam annotation module from MuSic tool [8](#references).

```
laml.pfam = pfamDomains(maf = laml, AACol = 'Protein_Change', top = 10)
```

```
## Warning in pfamDomains(maf = laml, AACol = "Protein_Change", top = 10): Removed
## 50 mutations for which AA position was not available
```

![](data:image/png;base64...)

```
#Protein summary (Printing first 7 columns for display convenience)
laml.pfam$proteinSummary[,1:7, with = FALSE]
```

```
##         HGNC AAPos Variant_Classification     N total  fraction   DomainLabel
##       <char> <num>                 <fctr> <int> <num>     <num>        <char>
##    1: DNMT3A   882      Missense_Mutation    27    54 0.5000000 AdoMet_MTases
##    2:   IDH1   132      Missense_Mutation    18    18 1.0000000      PTZ00435
##    3:   IDH2   140      Missense_Mutation    17    20 0.8500000      PTZ00435
##    4:   FLT3   835      Missense_Mutation    14    52 0.2692308      PKc_like
##    5:   FLT3   599           In_Frame_Ins    10    52 0.1923077      PKc_like
##   ---
## 1512: ZNF646   875      Missense_Mutation     1     1 1.0000000          <NA>
## 1513: ZNF687   554      Missense_Mutation     1     2 0.5000000          <NA>
## 1514: ZNF687   363      Missense_Mutation     1     2 0.5000000          <NA>
## 1515: ZNF75D     5      Missense_Mutation     1     1 1.0000000          <NA>
## 1516: ZNF827   427        Frame_Shift_Del     1     1 1.0000000          <NA>
```

```
#Domain summary (Printing first 3 columns for display convenience)
laml.pfam$domainSummary[,1:3, with = FALSE]
```

```
##        DomainLabel nMuts nGenes
##             <char> <int>  <int>
##   1:      PKc_like    55      5
##   2:      PTZ00435    38      2
##   3: AdoMet_MTases    33      1
##   4:         7tm_1    24     24
##   5:       COG5048    17     17
##  ---
## 499:    ribokinase     1      1
## 500:   rim_protein     1      1
## 501: sigpep_I_bact     1      1
## 502:           trp     1      1
## 503:        zf-BED     1      1
```

## 9.4 Survival analysis

Survival analysis is an essential part of cohort based sequencing projects. Function `mafSurvive` performs survival analysis and draws kaplan meier curve by grouping samples based on mutation status of user defined gene(s) or manually provided samples those make up a group. This function requires input data to contain Tumor\_Sample\_Barcode (make sure they match to those in MAF file), binary event (1/0) and time to event.

Our annotation data already contains survival information and in case you have survival data stored in a separate table provide them via argument `clinicalData`

### 9.4.1 Mutation in any given genes

```
#Survival analysis based on grouping of DNMT3A mutation status
mafSurvival(maf = laml, genes = 'DNMT3A', time = 'days_to_last_followup', Status = 'Overall_Survival_Status', isTCGA = TRUE)
```

```
## Looking for clinical data in annoatation slot of MAF..
```

```
## Number of mutated samples for given genes:
```

```
## DNMT3A
##     48
```

```
## Removed 11 samples with NA's
```

```
## Median survival..
```

```
##     Group medianTime     N
##    <char>      <num> <int>
## 1: Mutant        245    45
## 2:     WT        396   137
```

![](data:image/png;base64...)

### 9.4.2 Predict genesets associated with survival

Identify set of genes which results in poor survival

```
#Using top 20 mutated genes to identify a set of genes (of size 2) to predict poor prognostic groups
prog_geneset = survGroup(maf = laml, top = 20, geneSetSize = 2, time = "days_to_last_followup", Status = "Overall_Survival_Status", verbose = FALSE)
```

```
## Removed 11 samples with NA's
```

```
print(prog_geneset)
```

```
##     Gene_combination P_value    hr    WT Mutant
##               <char>   <num> <num> <int>  <int>
##  1:      FLT3_DNMT3A 0.00104 2.510   164     18
##  2:      DNMT3A_SMC3 0.04880 2.220   176      6
##  3:      DNMT3A_NPM1 0.07190 1.720   166     16
##  4:      DNMT3A_TET2 0.19600 1.780   176      6
##  5:        FLT3_TET2 0.20700 1.860   177      5
##  6:        NPM1_IDH1 0.21900 0.495   176      6
##  7:      DNMT3A_IDH1 0.29300 1.500   173      9
##  8:       IDH2_RUNX1 0.31800 1.580   176      6
##  9:        FLT3_NPM1 0.53600 1.210   165     17
## 10:      DNMT3A_IDH2 0.68000 0.747   178      4
## 11:      DNMT3A_NRAS 0.99200 0.986   178      4
```

Above results show a combination (N = 2) of genes which are associated with poor survival (P < 0.05). We can draw KM curve for above results with the function `mafSurvGroup`

```
mafSurvGroup(maf = laml, geneSet = c("DNMT3A", "FLT3"), time = "days_to_last_followup", Status = "Overall_Survival_Status")
```

```
## Looking for clinical data in annoatation slot of MAF..
```

```
## Removed 11 samples with NA's
```

```
## Median survival..
```

```
##     Group medianTime     N
##    <char>      <num> <int>
## 1: Mutant      242.5    18
## 2:     WT      379.5   164
```

![](data:image/png;base64...)

## 9.5 Comparing two cohorts (MAFs)

Cancers differ from each other in terms of their mutation pattern. We can compare two different cohorts to detect such differentially mutated genes. For example, recent article by [Madan et. al](http://www.ncbi.nlm.nih.gov/pubmed/27063598) [9](references), have shown that patients with relapsed APL (Acute Promyelocytic Leukemia) tends to have mutations in PML and RARA genes, which were absent during primary stage of the disease. This difference between two cohorts (in this case primary and relapse APL) can be detected using function `mafComapre`, which performs fisher test on all genes between two cohorts to detect differentially mutated genes.

```
#Primary APL MAF
primary.apl = system.file("extdata", "APL_primary.maf.gz", package = "maftools")
primary.apl = read.maf(maf = primary.apl)
#Relapse APL MAF
relapse.apl = system.file("extdata", "APL_relapse.maf.gz", package = "maftools")
relapse.apl = read.maf(maf = relapse.apl)
```

```
#Considering only genes which are mutated in at-least in 5 samples in one of the cohort to avoid bias due to genes mutated in single sample.
pt.vs.rt <- mafCompare(m1 = primary.apl, m2 = relapse.apl, m1Name = 'Primary', m2Name = 'Relapse', minMut = 5)
print(pt.vs.rt)
```

```
## $results
##    Hugo_Symbol Primary Relapse         pval         or       ci.up      ci.low
##         <char>   <num>   <int>        <num>      <num>       <num>       <num>
## 1:         PML       1      11 1.529935e-05 0.03537381   0.2552937 0.000806034
## 2:        RARA       0       7 2.574810e-04 0.00000000   0.3006159 0.000000000
## 3:       RUNX1       1       5 1.310500e-02 0.08740567   0.8076265 0.001813280
## 4:        FLT3      26       4 1.812779e-02 3.56086275  14.7701728 1.149009169
## 5:      ARID1B       5       8 2.758396e-02 0.26480490   0.9698686 0.064804160
## 6:         WT1      20      14 2.229087e-01 0.60619329   1.4223101 0.263440988
## 7:        KRAS       6       1 4.334067e-01 2.88486293 135.5393108 0.337679367
## 8:        NRAS      15       4 4.353567e-01 1.85209500   8.0373994 0.553883512
## 9:      ARID1A       7       4 7.457274e-01 0.80869223   3.9297309 0.195710173
##         adjPval
##           <num>
## 1: 0.0001376942
## 2: 0.0011586643
## 3: 0.0393149868
## 4: 0.0407875250
## 5: 0.0496511201
## 6: 0.3343630535
## 7: 0.4897762916
## 8: 0.4897762916
## 9: 0.7457273717
##
## $SampleSummary
##     Cohort SampleSize
##     <char>      <num>
## 1: Primary        124
## 2: Relapse         58
```

### 9.5.1 Forest plots

Above results show two genes PML and RARA which are highly mutated in Relapse APL compared to Primary APL. We can visualize these results as a [forestplot](https://en.wikipedia.org/wiki/Forest_plot).

```
forestPlot(mafCompareRes = pt.vs.rt, pVal = 0.1)
```

![](data:image/png;base64...)

### 9.5.2 Co-onco plots

Another alternative way of displaying above results is by plotting two oncoplots side by side. `coOncoplot` function takes two maf objects and plots them side by side for better comparison.

```
genes = c("PML", "RARA", "RUNX1", "ARID1B", "FLT3")
coOncoplot(m1 = primary.apl, m2 = relapse.apl, m1Name = 'PrimaryAPL', m2Name = 'RelapseAPL', genes = genes, removeNonMutated = TRUE)
```

![](data:image/png;base64...)

### 9.5.3 Co-bar plots

```
coBarplot(m1 = primary.apl, m2 = relapse.apl, m1Name = "Primary", m2Name = "Relapse")
```

![](data:image/png;base64...)

### 9.5.4 Lollipop plot-2

Along with plots showing cohort wise differences, its also possible to show gene wise differences with `lollipopPlot2` function.

```
lollipopPlot2(m1 = primary.apl, m2 = relapse.apl, gene = "PML", AACol1 = "amino_acid_change", AACol2 = "amino_acid_change", m1_name = "Primary", m2_name = "Relapse")
```

![](data:image/png;base64...)

## 9.6 Clinical enrichment analysis

`clinicalEnrichment` is another function which takes any clinical feature associated with the samples and performs enrichment analysis. It performs various groupwise and pairwise comparisions to identify enriched mutations for every category within a clincila feature. Below is an example to identify mutations associated with FAB\_classification.

```
fab.ce = clinicalEnrichment(maf = laml, clinicalFeature = 'FAB_classification')
```

```
## Sample size per factor in FAB_classification:
```

```
##
## M0 M1 M2 M3 M4 M5 M6 M7
## 19 44 44 21 39 19  3  3
```

```
#Results are returned as a list. Significant associations p-value < 0.05
fab.ce$groupwise_comparision[p_value < 0.05]
```

```
##    Hugo_Symbol Group1 Group2 n_mutated_group1 n_mutated_group2      p_value
##         <char> <char> <char>           <char>           <char>        <num>
## 1:        IDH1     M1   Rest         11 of 44         7 of 149 0.0002597371
## 2:        TP53     M7   Rest           3 of 3        12 of 190 0.0003857187
## 3:      DNMT3A     M5   Rest         10 of 19        38 of 174 0.0089427384
## 4:       CEBPA     M2   Rest          7 of 44         6 of 149 0.0117352110
## 5:       RUNX1     M0   Rest          5 of 19        11 of 174 0.0117436825
## 6:        NPM1     M5   Rest          7 of 19        26 of 174 0.0248582372
## 7:        NPM1     M3   Rest          0 of 21        33 of 172 0.0278630823
## 8:      DNMT3A     M3   Rest          1 of 21        47 of 172 0.0294005111
##          OR      OR_low    OR_high       fdr
##       <num>       <num>      <num>     <num>
## 1: 6.670592 2.173829026 21.9607250 0.0308575
## 2:      Inf 5.355415451        Inf 0.0308575
## 3: 3.941207 1.333635173 11.8455979 0.3757978
## 4: 4.463237 1.204699322 17.1341278 0.3757978
## 5: 5.216902 1.243812880 19.4051505 0.3757978
## 6: 3.293201 1.001404899 10.1210509 0.5880102
## 7: 0.000000 0.000000000  0.8651972 0.5880102
## 8: 0.133827 0.003146708  0.8848897 0.5880102
```

Above results shows IDH1 mutations are enriched in M1 subtype of leukemia compared to rest of the cohort. Similarly DNMT3A is in M5, RUNX1 is in M0, and so on. These are well known results and this function effectively recaptures them. One can use any sort of clincial feature to perform such an analysis. There is also a small function - `plotEnrichmentResults` which can be used to plot these results.

```
plotEnrichmentResults(enrich_res = fab.ce, pVal = 0.05, geneFontSize = 0.5, annoFontSize = 0.6)
```

![](data:image/png;base64...)

## 9.7 Drug-Gene Interactions

`drugInteractions` function checks for drug–gene interactions and gene druggability information compiled from [Drug Gene Interaction database](http://www.dgidb.org).

```
dgi = drugInteractions(maf = laml, fontSize = 0.75)
```

![](data:image/png;base64...)

Above plot shows potential druggable gene categories along with upto top 5 genes involved in them. One can also extract information on drug-gene interactions. For example below is the results for known/reported drugs to interact with DNMT3A.

```
dnmt3a.dgi = drugInteractions(genes = "DNMT3A", drugs = TRUE)
```

```
## Number of claimed drugs for given genes:
##      Gene     N
##    <char> <int>
## 1: DNMT3A     7
```

```
#Printing selected columns.
dnmt3a.dgi[,.(Gene, interaction_types, drug_name, drug_claim_name)]
```

```
##      Gene interaction_types    drug_name drug_claim_name
##    <char>            <char>       <char>          <char>
## 1: DNMT3A                                            N/A
## 2: DNMT3A                   DAUNORUBICIN    Daunorubicin
## 3: DNMT3A                     DECITABINE      Decitabine
## 4: DNMT3A                     IDARUBICIN      IDARUBICIN
## 5: DNMT3A                     DECITABINE      DECITABINE
## 6: DNMT3A         inhibitor   DECITABINE   CHEMBL1201129
## 7: DNMT3A         inhibitor  AZACITIDINE      CHEMBL1489
```

Please cite [DGIdb article](https://www.ncbi.nlm.nih.gov/entrez/eutils/elink.fcgi?dbfrom=pubmed&retmode=ref&cmd=prlinks&id=24122041) if you find this function useful [10](#references).

*Disclaimer: Resources used in this function are intended for purely research purposes. It should not be used for emergencies or medical or professional advice.*

## 9.8 Oncogenic Signaling Pathways

`pathways` function checks for enrichment of known Oncogenic Signaling Pathways from TCGA cohorts [11](#references).

```
pws = pathways(maf = laml, plotType = 'treemap')
```

```
## Summarizing signalling pathways [Sanchez-Vega et al., https://doi.org/10.1016/j.cell.2018.03.035]
```

![](data:image/png;base64...)

Its also possible to visualize the results

```
plotPathways(maf = laml, pathlist = pws)
```

![](data:image/png;base64...)

## 9.9 Tumor heterogeneity and MATH scores

### 9.9.1 Heterogeneity in tumor samples

Tumors are generally heterogeneous i.e, consist of multiple clones. This heterogeneity can be inferred by clustering variant allele frequencies. `inferHeterogeneity` function uses vaf information to cluster variants (using `mclust`), to infer clonality. By default, `inferHeterogeneity` function looks for column *t\_vaf* containing vaf information. However, if the field name is different from *t\_vaf*, we can manually specify it using argument `vafCol`. For example, in this case study vaf is stored under the field name *i\_TumorVAF\_WU*.

```
#Heterogeneity in sample TCGA.AB.2972
library("mclust")
```

```
## Package 'mclust' version 6.1.1
## Type 'citation("mclust")' for citing this R package in publications.
```

```
tcga.ab.2972.het = inferHeterogeneity(maf = laml, tsb = 'TCGA-AB-2972', vafCol = 'i_TumorVAF_WU')
```

```
## Processing TCGA-AB-2972..
```

```
print(tcga.ab.2972.het$clusterMeans)
```

```
##    Tumor_Sample_Barcode cluster   meanVaf
##                  <fctr>  <char>     <num>
## 1:         TCGA-AB-2972       2 0.4496571
## 2:         TCGA-AB-2972       1 0.2454750
## 3:         TCGA-AB-2972 outlier 0.3695000
```

```
#Visualizing results
plotClusters(clusters = tcga.ab.2972.het)
```

![](data:image/png;base64...)

Above figure shows clear separation of two clones clustered at mean variant allele frequencies of ~45% (major clone) and another minor clone at variant allele frequency of ~25%.

Although clustering of variant allele frequencies gives us a fair idea on heterogeneity, it is also possible to measure the extent of heterogeneity in terms of a numerical value. MATH score (mentioned as a subtitle in above plot) is a simple quantitative measure of intra-tumor heterogeneity, which calculates the width of the vaf distribution. Higher MATH scores are found to be associated with poor outcome. MATH score can also be used a proxy variable for survival analysis [11](#references).

### 9.9.2 Ignoring variants in copy number altered regions

We can use copy number information to ignore variants located on copy-number altered regions. Copy number alterations results in abnormally high/low variant allele frequencies, which tends to affect clustering. Removing such variants improves clustering and density estimation while retaining biologically meaningful results. Copy number information can be provided as a segmented file generated from segmentation programmes, such as Circular Binary Segmentation from “DNACopy” Bioconductor package [6](#references).

```
seg = system.file('extdata', 'TCGA.AB.3009.hg19.seg.txt', package = 'maftools')
tcga.ab.3009.het = inferHeterogeneity(maf = laml, tsb = 'TCGA-AB-3009', segFile = seg, vafCol = 'i_TumorVAF_WU')
```

```
## Processing TCGA-AB-3009..
```

```
## Removed 1 variants with no copy number data.
```

```
##    Hugo_Symbol Chromosome Start_Position End_Position Tumor_Sample_Barcode
##         <char>     <char>          <num>        <num>               <fctr>
## 1:        PHF6         23      133551224    133551224         TCGA-AB-3009
##        t_vaf Segment_Start Segment_End Segment_Mean    CN
##        <num>         <int>       <int>        <num> <num>
## 1: 0.9349112            NA          NA           NA    NA
```

```
## Copy number altered variants:
```

```
##    Hugo_Symbol Chromosome Start_Position End_Position Tumor_Sample_Barcode
##         <char>     <char>          <num>        <num>               <fctr>
## 1:     NFKBIL2          8      145668658    145668658         TCGA-AB-3009
## 2:         NF1         17       29562981     29562981         TCGA-AB-3009
## 3:       SUZ12         17       30293198     30293198         TCGA-AB-3009
##        t_vaf Segment_Start Segment_End Segment_Mean       CN    cluster
##        <num>         <int>       <int>        <num>    <num>     <char>
## 1: 0.4415584     145232496   145760746       0.3976 2.634629 CN_altered
## 2: 0.8419000      29054355    30363868      -0.9157 1.060173 CN_altered
## 3: 0.8958333      29054355    30363868      -0.9157 1.060173 CN_altered
```

```
#Visualizing results. Highlighting those variants on copynumber altered variants.
plotClusters(clusters = tcga.ab.3009.het, genes = 'CN_altered', showCNvars = TRUE)
```

![](data:image/png;base64...)

Above figure shows two genes NF1 and SUZ12 with high VAF’s, which is due to copy number alterations (deletion). Those two genes are ignored from analysis.

## 9.10 Mutational Signatures

Every cancer, as it progresses leaves a signature characterized by specific pattern of nucleotide substitutions. [Alexandrov et.al](http://www.nature.com/nature/journal/v500/n7463/full/nature12477.html) have shown such mutational signatures, derived from over 7000 cancer samples [5](#references). Such signatures can be extracted by decomposing matrix of nucleotide substitutions, classified into 96 substitution classes based on immediate bases surrounding the mutated base. Extracted signatures can also be compared to those [validated signatures](http://cancer.sanger.ac.uk/cosmic/signatures).

First step in signature analysis is to obtain the adjacent bases surrounding the mutated base and form a mutation matrix. NOTE: Earlier versions of maftools required a fasta file as an input. But starting from 1.8.0, BSgenome objects are used for faster sequence extraction.

```
#Requires BSgenome object
library("BSgenome.Hsapiens.UCSC.hg19", quietly = TRUE)
```

```
##
## Attaching package: 'generics'
```

```
## The following objects are masked from 'package:base':
##
##     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
##     setequal, union
```

```
##
## Attaching package: 'BiocGenerics'
```

```
## The following objects are masked from 'package:stats':
##
##     IQR, mad, sd, var, xtabs
```

```
## The following objects are masked from 'package:base':
##
##     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
##     as.data.frame, basename, cbind, colnames, dirname, do.call,
##     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
##     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
##     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
##     unsplit, which.max, which.min
```

```
##
## Attaching package: 'S4Vectors'
```

```
## The following object is masked from 'package:utils':
##
##     findMatches
```

```
## The following objects are masked from 'package:base':
##
##     I, expand.grid, unname
```

```
##
## Attaching package: 'Biostrings'
```

```
## The following object is masked from 'package:base':
##
##     strsplit
```

```
laml.tnm = trinucleotideMatrix(maf = laml, prefix = 'chr', add = TRUE, ref_genome = "BSgenome.Hsapiens.UCSC.hg19")
```

```
## Warning in trinucleotideMatrix(maf = laml, prefix = "chr", add = TRUE, ref_genome = "BSgenome.Hsapiens.UCSC.hg19"): Chromosome names in MAF must match chromosome names in reference genome.
## Ignorinig 101 single nucleotide variants from missing chromosomes chr23
```

```
## -Extracting 5' and 3' adjacent bases
## -Extracting +/- 20bp around mutated bases for background C>T estimation
## -Estimating APOBEC enrichment scores
## --Performing one-way Fisher's test for APOBEC enrichment
## ---APOBEC related mutations are enriched in  3.315 % of samples (APOBEC enrichment score > 2 ;  6  of  181  samples)
## -Creating mutation matrix
## --matrix of dimension 188x96
```

Above function performs two steps:

* Estimates APOBEC enrichment scores
* Prepares a mutational matrix for signature analysis.

### 9.10.1 APOBEC Enrichment estimation.

APOBEC induced mutations are more frequent in solid tumors and are mainly associated with C>T transition events occurring in TCW motif. APOBEC enrichment scores in the above command are estimated using the method described by Roberts et al [13](#references). Briefly, enrichment of C>T mutations occurring within TCW motif over all of the C>T mutations in a given sample is compared to background Cytosines and TCWs occurring within 20bp of mutated bases.

\[\frac{n\_{tCw} \* background\_C}{n\_C \* background\_{TCW}}\]

One-sided fishers exact test is also performed to statistically evaluate the enrichment score, as described in original study by Roberts et al.

### 9.10.2 Differences between APOBEC enriched and non-enriched samples

We can also analyze the differences in mutational patterns between APOBEC enriched and non-APOBEC enriched samples. `plotApobecDiff` is a function which takes APOBEC enrichment scores estimated by `trinucleotideMatrix` and classifies samples into APOBEC enriched and non-APOBEC enriched. Once stratified, it compares these two groups to identify differentially altered genes.

Note that, LAML with no APOBEC enrichments, is not an ideal cohort for this sort of analysis and hence below plot is only for demonstration purpose.

```
plotApobecDiff(tnm = laml.tnm, maf = laml, pVal = 0.2)
```

```
## -Processing clinical data
## -Processing clinical data
```

![](data:image/png;base64...)

```
## $results
## Index: <Hugo_Symbol>
##      Hugo_Symbol Enriched nonEnriched       pval       or     ci.up     ci.low
##           <char>    <num>       <int>      <num>    <num>     <num>      <num>
##   1:        TP53        2          13 0.08175632 5.997646  46.60886 0.49875432
##   2:        TET2        1          16 0.45739351 1.940700  18.98398 0.03882963
##   3:        FLT3        2          45 0.65523131 1.408185  10.21162 0.12341748
##   4:      ADAM11        0           2 1.00000000 0.000000 164.19147 0.00000000
##   5:        APOB        0           2 1.00000000 0.000000 164.19147 0.00000000
##  ---
## 132:         WAC        0           2 1.00000000 0.000000 164.19147 0.00000000
## 133:         WT1        0          12 1.00000000 0.000000  12.69086 0.00000000
## 134:      ZBTB33        0           2 1.00000000 0.000000 164.19147 0.00000000
## 135:      ZC3H18        0           2 1.00000000 0.000000 164.19147 0.00000000
## 136:      ZNF687        0           2 1.00000000 0.000000 164.19147 0.00000000
##      adjPval
##        <num>
##   1:       1
##   2:       1
##   3:       1
##   4:       1
##   5:       1
##  ---
## 132:       1
## 133:       1
## 134:       1
## 135:       1
## 136:       1
##
## $SampleSummary
## Key: <Cohort>
##         Cohort SampleSize  Mean Median
##         <char>      <num> <num>  <num>
## 1:    Enriched          6 7.167    6.5
## 2: nonEnriched        172 9.715    9.0
```

### 9.10.3 Signature analysis

Signature analysis includes following steps.

1. `estimateSignatures` - which runs NMF on a range of values and measures the goodness of fit - in terms of [Cophenetic correlation](https://en.wikipedia.org/wiki/Cophenetic_correlation).
2. `plotCophenetic` - which draws an elblow plot and helps you to decide optimal number of signatures. Best possible signature is the value at which Cophenetic correlation drops significantly.
3. `extractSignatures` - uses non-negative matrix factorization to decompose the matrix into `n` signatures. `n` is chosen based on the above two steps. In case if you already have a good estimate of `n`, you can skip above two steps.
4. `compareSignatures` - extracted signatures from above step can be compared to known signatures[11](#references) from [COSMIC](https://cancer.sanger.ac.uk/cosmic/signatures/SBS/) database, and cosine similarity is calculated to identify best match.
5. `plotSignatures` - plots signatures

![](data:image/png;base64...)

***Note:*** In previous versions, `extractSignatures` used to take care of above steps automatically. After versions 2.2.0, main function is split inot above 5 stpes for user flexibility.

```
library('NMF')
laml.sign = estimateSignatures(mat = laml.tnm, nTry = 6)
```

Draw elbow plot to visualize and decide optimal number of signatures from above results.

```
plotCophenetic(res = laml.sign)
```

![](data:image/png;base64...)

Best possible value is the one at which the correlation value on the y-axis drops significantly. In this case it appears to be at `n = 3`. LAML is not an ideal example for signature analysis with its low mutation rate, but for solid tumors with higher mutation burden one could expect more signatures, provided sufficient number of samples.

Once `n` is estimated, we can run the main function.

```
laml.sig = extractSignatures(mat = laml.tnm, n = 3)
```

```
## -Running NMF for factorization rank: 3
```

```
## -Finished in3.891s elapsed (3.035s cpu)
```

Compare detected signatures to COSMIC [Legacy](https://cancer.sanger.ac.uk/cosmic/signatures_v2) or [SBS](https://cancer.sanger.ac.uk/cosmic/signatures_v2) signature database.

```
#Compate against original 30 signatures
laml.og30.cosm = compareSignatures(nmfRes = laml.sig, sig_db = "legacy")
```

```
## -Comparing against COSMIC signatures
```

```
## ------------------------------------
```

```
## --Found Signature_1 most similar to COSMIC_1
```

```
##    Aetiology: spontaneous deamination of 5-methylcytosine [cosine-similarity: 0.84]
```

```
## --Found Signature_2 most similar to COSMIC_1
```

```
##    Aetiology: spontaneous deamination of 5-methylcytosine [cosine-similarity: 0.577]
```

```
## --Found Signature_3 most similar to COSMIC_5
```

```
##    Aetiology: Unknown [cosine-similarity: 0.851]
```

```
## ------------------------------------
```

```
#Compate against updated version3 60 signatures
laml.v3.cosm = compareSignatures(nmfRes = laml.sig, sig_db = "SBS")
```

```
## -Comparing against COSMIC signatures
## ------------------------------------
```

```
## --Found Signature_1 most similar to SBS1
```

```
##    Aetiology: spontaneous or enzymatic deamination of 5-methylcytosine [cosine-similarity: 0.858]
```

```
## --Found Signature_2 most similar to SBS6
```

```
##    Aetiology: defective DNA mismatch repair [cosine-similarity: 0.538]
```

```
## --Found Signature_3 most similar to SBS3
```

```
##    Aetiology: Defects in DNA-DSB repair by HR [cosine-similarity: 0.836]
```

```
## ------------------------------------
```

`compareSignatures` returns full table of cosine similarities against COSMIC signatures, which can be further analysed. Below plot shows comparison of similarities of detected signatures against validated signatures.

```
library('pheatmap')
pheatmap::pheatmap(mat = laml.og30.cosm$cosine_similarities, cluster_rows = FALSE, main = "cosine similarity against validated signatures")
```

![](data:image/png;base64...)

Finally plot signatures

```
maftools::plotSignatures(nmfRes = laml.sig, title_size = 1.2, sig_db = "SBS")
```

![](data:image/png;base64...)

If you fancy 3D barpots, you can install `barplot3d` package and visualize the results with `legoplot3d` function.

```
library("barplot3d")
#Visualize first signature
sig1 = laml.sig$signatures[,1]
barplot3d::legoplot3d(contextdata = sig1, labels = FALSE, scalexy = 0.01, sixcolors = "sanger", alpha = 0.5)
```

***NOTE:***

1. Should you receive an error while running `extractSignatures` complaining `none of the packages are loaded`, please manually load the `NMF` library and re-run.
2. If either `extractSignatures` or `estimateSignatures` stops in between, its possibly due to low mutation counts in the matrix. In that case rerun the functions with `pConstant` argument set to small positive value (e.g, 0.1).

# 10 Variant Annotations

## 10.1 Converting annovar output to MAF

Annovar is one of the most widely used Variant Annotation tool in Genomics [17](#references). Annovar output is generally in a tabular format with various annotation columns. This function converts such annovar output files into MAF. This function requires that annovar was run with gene based annotation as a first operation, before including any filter or region based annotations.

e.g,

```
table_annovar.pl example/ex1.avinput humandb/ -buildver hg19 -out myanno -remove -protocol (refGene),cytoBand,dbnsfp30a -operation (g),r,f -nastring NA
```

`annovarToMaf` mainly uses gene based annotations for processing, rest of the annotation columns from input file will be attached to the end of the resulting MAF.

As an example we will annotate the same file which was used above to run `oncotate` function. We will annotate it using annovar with the following command. For simplicity, here we are including only gene based annotations but one can include as many annotations as they wish. But make sure the fist operation is always gene based annotation.

```
$perl table_annovar.pl variants.tsv ~/path/to/humandb/ -buildver hg19
-out variants --otherinfo -remove -protocol ensGene -operation g -nastring NA
```

Output generated is stored as a part of this package. We can convert this annovar output into MAF using `annovarToMaf`.

```
var.annovar = system.file("extdata", "variants.hg19_multianno.txt", package = "maftools")
var.annovar.maf = annovarToMaf(annovar = var.annovar, Center = 'CSI-NUS', refBuild = 'hg19',
                               tsbCol = 'Tumor_Sample_Barcode', table = 'ensGene')
```

```
## -Reading annovar files
## --Extracting tx, exon, txchange and aa-change
## -Adding Variant_Type
## -Converting Ensemble Gene IDs into HGNC gene symbols
## --Done. Original ensemble gene IDs are preserved under field name ens_id
## Finished in 0.172s elapsed (0.191s cpu)
```

Annovar, when used with Ensemble as a gene annotation source, uses ensemble gene IDs as Gene names. In that case, use `annovarToMaf` with argument `table` set to `ensGene` which converts ensemble gene IDs into HGNC symbols.

If you prefer to do the conversion outside R, there is also a python script which is much faster and doesn’t load the whole file into memory. See [annovar2maf](https://github.com/PoisonAlien/annovar2maf) for details.

## 10.2 Converting ICGC Simple Somatic Mutation Format to MAF

Just like TCGA, International Cancer Genome Consortium [ICGC](http://icgc.org) also makes its data publicly available. But the data are stored in [Simpale Somatic Mutation Format](http://docs.icgc.org/submission/guide/icgc-simple-somatic-mutation-format/), which is similar to MAF format in its structure. However field names and classification of variants is different from that of MAF. `icgcSimpleMutationToMAF` is a function which reads ICGC data and converts them to MAF.

```
#Read sample ICGC data for ESCA
esca.icgc <- system.file("extdata", "simple_somatic_mutation.open.ESCA-CN.sample.tsv.gz", package = "maftools")
esca.maf <- icgcSimpleMutationToMAF(icgc = esca.icgc, addHugoSymbol = TRUE)
```

```
## Converting Ensemble Gene IDs into HGNC gene symbols.
```

```
## Done! Original ensemble gene IDs are preserved under field name ens_id
```

```
## --Removed 427 duplicated variants
```

```
#Printing first 16 columns for display convenience.
print(esca.maf[1:5,1:16, with = FALSE])
```

```
##    Hugo_Symbol Entrez_Gene_Id Center NCBI_Build Chromosome Start_Position
##         <char>          <int> <lgcl>     <char>     <char>          <num>
## 1:  AC005237.4             NA     NA     GRCh37          2      241987787
## 2:  AC061992.1            786     NA     GRCh37         17       76425382
## 3:  AC097467.2             NA     NA     GRCh37          4      156294567
## 4:    ADAMTS12             NA     NA     GRCh37          5       33684019
## 5:  AL589642.1          54801     NA     GRCh37          9       32630154
##    End_Position Strand Variant_Classification Variant_Type Reference_Allele
##           <num> <char>                 <char>       <char>           <char>
## 1:    241987787      +                 Intron          SNP                C
## 2:     76425382      +                3'Flank          SNP                C
## 3:    156294567      +                 Intron          SNP                A
## 4:     33684019      +      Missense_Mutation          SNP                A
## 5:     32630154      +                    RNA          SNP                T
##    Tumor_Seq_Allele1 Tumor_Seq_Allele2 dbSNP_RS dbSNP_Val_Status
##               <char>            <char>   <lgcl>           <lgcl>
## 1:                 C                 T       NA               NA
## 2:                 C                 T       NA               NA
## 3:                 A                 G       NA               NA
## 4:                 A                 C       NA               NA
## 5:                 T                 C       NA               NA
##    Tumor_Sample_Barcode
##                  <fctr>
## 1:             SA514619
## 2:             SA514619
## 3:             SA514619
## 4:             SA514619
## 5:             SA514619
```

Note that by default Simple Somatic Mutation format contains all affected transcripts of a variant resulting in multiple entries of the same variant in same sample. It is hard to choose a single affected transcript based on annotations alone and by default this program removes repeated variants as duplicated entries. If you wish to keep all of them, set `removeDuplicatedVariants` to FALSE. Another option is to convert input file to MAF by removing duplicates and then use scripts like [vcf2maf](https://github.com/mskcc/vcf2maf) to re-annotate and prioritize affected transcripts.

## 10.3 Prepare MAF file for MutSigCV analysis

MutSig/MutSigCV is most widely used program for detecting driver genes [18](#references). However, we have observed that covariates files (gene.covariates.txt and exome\_full192.coverage.txt) which are bundled with MutSig have non-standard gene names (non Hugo\_Symbols). This discrepancy between Hugo\_Symbols in MAF and non-Hugo\_symbols in covariates file causes MutSig program to ignore such genes. For example, KMT2D - a well known driver gene in Esophageal Carcinoma is represented as MLL2 in MutSig covariates. This causes KMT2D to be ignored from analysis and is represented as an insignificant gene in MutSig results. This function attempts to correct such gene symbols with a manually curated list of gene names compatible with MutSig covariates list.

```
laml.mutsig.corrected = prepareMutSig(maf = laml)
# Converting gene names for 1 variants from 1 genes
#    Hugo_Symbol MutSig_Synonym N
# 1:    ARHGAP35          GRLF1 1
# Original symbols are preserved under column OG_Hugo_Symbol.
```

# 11 Set operations

## 11.1 Subsetting MAF

We can also subset MAF using function `subsetMaf`

```
#Extract data for samples 'TCGA.AB.3009' and 'TCGA.AB.2933'  (Printing just 5 rows for display convenience)
subsetMaf(maf = laml, tsb = c('TCGA-AB-3009', 'TCGA-AB-2933'), mafObj = FALSE)[1:5]
```

```
##    Hugo_Symbol Entrez_Gene_Id           Center NCBI_Build Chromosome
##         <char>          <int>           <char>      <int>     <char>
## 1:      ABCB11           8647 genome.wustl.edu         37          2
## 2:       ACSS3          79611 genome.wustl.edu         37         12
## 3:        ANK3            288 genome.wustl.edu         37         10
## 4:       AP1G2           8906 genome.wustl.edu         37         14
## 5:         ARC          23237 genome.wustl.edu         37          8
##    Start_Position End_Position Strand Variant_Classification Variant_Type
##             <num>        <num> <char>                 <fctr>       <fctr>
## 1:      169780250    169780250      +      Missense_Mutation          SNP
## 2:       81536902     81536902      +      Missense_Mutation          SNP
## 3:       61926581     61926581      +            Splice_Site          SNP
## 4:       24033309     24033309      +      Missense_Mutation          SNP
## 5:      143694874    143694874      +      Missense_Mutation          SNP
##    Reference_Allele Tumor_Seq_Allele1 Tumor_Seq_Allele2 Tumor_Sample_Barcode
##              <char>            <char>            <char>               <fctr>
## 1:                G                 G                 A         TCGA-AB-3009
## 2:                C                 C                 T         TCGA-AB-3009
## 3:                C                 C                 A         TCGA-AB-3009
## 4:                C                 C                 T         TCGA-AB-3009
## 5:                C                 C                 G         TCGA-AB-3009
##    Protein_Change i_TumorVAF_WU i_transcript_name
##            <char>         <num>            <char>
## 1:       p.A1283V      46.97218       NM_003742.2
## 2:        p.A266V      47.32510       NM_024560.2
## 3:                     43.99478       NM_020987.2
## 4:        p.R346Q      47.08000       NM_003917.2
## 5:        p.W253C      42.96435       NM_015193.3
```

```
##Same as above but return output as an MAF object (Default behaviour)
subsetMaf(maf = laml, tsb = c('TCGA-AB-3009', 'TCGA-AB-2933'))
```

```
## -Processing clinical data
```

```
## An object of class  MAF
##                    ID          summary  Mean Median
##                <char>           <char> <num>  <num>
##  1:        NCBI_Build               37    NA     NA
##  2:            Center genome.wustl.edu    NA     NA
##  3:           Samples                2    NA     NA
##  4:            nGenes               34    NA     NA
##  5:   Frame_Shift_Ins                5   2.5    2.5
##  6:      In_Frame_Ins                1   0.5    0.5
##  7: Missense_Mutation               26  13.0   13.0
##  8: Nonsense_Mutation                2   1.0    1.0
##  9:       Splice_Site                1   0.5    0.5
## 10:             total               35  17.5   17.5
```

### 11.1.1 Specifying queries and controlling output fields.

```
#Select all Splice_Site mutations from DNMT3A and NPM1
subsetMaf(maf = laml, genes = c('DNMT3A', 'NPM1'), mafObj = FALSE,query = "Variant_Classification == 'Splice_Site'")
```

```
##    Hugo_Symbol Entrez_Gene_Id           Center NCBI_Build Chromosome
##         <char>          <int>           <char>      <int>     <char>
## 1:      DNMT3A           1788 genome.wustl.edu         37          2
## 2:      DNMT3A           1788 genome.wustl.edu         37          2
## 3:      DNMT3A           1788 genome.wustl.edu         37          2
## 4:      DNMT3A           1788 genome.wustl.edu         37          2
## 5:      DNMT3A           1788 genome.wustl.edu         37          2
## 6:      DNMT3A           1788 genome.wustl.edu         37          2
##    Start_Position End_Position Strand Variant_Classification Variant_Type
##             <num>        <num> <char>                 <fctr>       <fctr>
## 1:       25459874     25459874      +            Splice_Site          SNP
## 2:       25467208     25467208      +            Splice_Site          SNP
## 3:       25467022     25467022      +            Splice_Site          SNP
## 4:       25459803     25459803      +            Splice_Site          SNP
## 5:       25464576     25464576      +            Splice_Site          SNP
## 6:       25469029     25469029      +            Splice_Site          SNP
##    Reference_Allele Tumor_Seq_Allele1 Tumor_Seq_Allele2 Tumor_Sample_Barcode
##              <char>            <char>            <char>               <fctr>
## 1:                C                 C                 G         TCGA-AB-2818
## 2:                C                 C                 T         TCGA-AB-2822
## 3:                A                 A                 G         TCGA-AB-2891
## 4:                A                 A                 C         TCGA-AB-2898
## 5:                C                 C                 A         TCGA-AB-2934
## 6:                C                 C                 A         TCGA-AB-2968
##    Protein_Change i_TumorVAF_WU i_transcript_name
##            <char>         <num>            <char>
## 1:        p.R803S         36.84       NM_022552.3
## 2:                        62.96       NM_022552.3
## 3:                        34.78       NM_022552.3
## 4:                        46.43       NM_022552.3
## 5:        p.G646V         37.50       NM_022552.3
## 6:        p.E477*         40.00       NM_022552.3
```

```
#Same as above but include only 'i_transcript_name' column in the output
subsetMaf(maf = laml, genes = c('DNMT3A', 'NPM1'), mafObj = FALSE, query = "Variant_Classification == 'Splice_Site'", fields = 'i_transcript_name')
```

```
##    Hugo_Symbol Chromosome Start_Position End_Position Reference_Allele
##         <char>     <char>          <num>        <num>           <char>
## 1:      DNMT3A          2       25459874     25459874                C
## 2:      DNMT3A          2       25467208     25467208                C
## 3:      DNMT3A          2       25467022     25467022                A
## 4:      DNMT3A          2       25459803     25459803                A
## 5:      DNMT3A          2       25464576     25464576                C
## 6:      DNMT3A          2       25469029     25469029                C
##    Tumor_Seq_Allele2 Variant_Classification Variant_Type Tumor_Sample_Barcode
##               <char>                 <fctr>       <fctr>               <fctr>
## 1:                 G            Splice_Site          SNP         TCGA-AB-2818
## 2:                 T            Splice_Site          SNP         TCGA-AB-2822
## 3:                 G            Splice_Site          SNP         TCGA-AB-2891
## 4:                 C            Splice_Site          SNP         TCGA-AB-2898
## 5:                 A            Splice_Site          SNP         TCGA-AB-2934
## 6:                 A            Splice_Site          SNP         TCGA-AB-2968
##    i_transcript_name
##               <char>
## 1:       NM_022552.3
## 2:       NM_022552.3
## 3:       NM_022552.3
## 4:       NM_022552.3
## 5:       NM_022552.3
## 6:       NM_022552.3
```

### 11.1.2 Subsetting by clinical data

Use `clinQuery` argument in `subsetMaf` to select samples of interest based on their clinical features.

```
#Select all samples with FAB clasification M4 in clinical data
laml_m4 = subsetMaf(maf = laml, clinQuery = "FAB_classification %in% 'M4'")
```

```
## -subsetting by clinical data..
```

```
## --39 samples meet the clinical query
```

```
## -Processing clinical data
```

# 12 Sample swap identification

Human errors such as sample mislabeling are common among large cancer studies. This leads to sample pair mismatches which further causes erroneous results. `sampleSwaps()` function tries to identify such sample mismatches and relatedness by genotyping single nucleotide polymorphisms (SNPs) and measuring concordance among samples.

Below demonstration uses the dataset from [Hao et. al.](https://www.nature.com/articles/ng.3683) who performed multi-region whole exome sequencing from several individuals including a matched normal.

```
#Path to BAM files
bams = c(
  "DBW-40-N.bam",
  "DBW-40-1T.bam",
  "DBW-40-2T.bam",
  "DBW-40-3T.bam",
  "DBW-43-N.bam",
  "DBW-43-1T.bam"
)

res = maftools::sampleSwaps(bams = bams, build = "hg19")
# Fetching readcounts from BAM files..
# Summarizing allele frequncy table..
# Performing pairwise comparison..
# Done!
```

The returned results is a list containing:

* a `matrix` of allele frequency table for every genotyped SNP
* a `data.frame` of readcounts for ref and alt allele for every genotyped SNP
* a table with pair-wise concordance among samples
* a list with potentially matched samples

```
 res$pairwise_comparison
```

```
# X_bam     Y_bam concordant_snps discordant_snps fract_concordant_snps  cor_coef XY_possibly_paired
#  1: DBW-40-1T DBW-40-2T            5488             571             0.9057600 0.9656484                Yes
#  2: DBW-40-1T DBW-40-3T            5793             266             0.9560984 0.9758083                Yes
#  3: DBW-40-1T  DBW-43-N            5534             525             0.9133520 0.9667620                Yes
#  4: DBW-40-2T DBW-40-3T            5853             206             0.9660010 0.9817475                Yes
#  5: DBW-40-2T  DBW-43-N            5131             928             0.8468394 0.9297096                Yes
#  6: DBW-40-3T  DBW-43-N            5334             725             0.8803433 0.9550670                Yes
#  7:  DBW-40-N DBW-43-1T            5709             350             0.9422347 0.9725684                Yes
#  8: DBW-40-1T  DBW-40-N            2829            3230             0.4669087 0.3808831                 No
#  9: DBW-40-1T DBW-43-1T            2796            3263             0.4614623 0.3755364                 No
# 10: DBW-40-2T  DBW-40-N            2760            3299             0.4555207 0.3641647                 No
# 11: DBW-40-2T DBW-43-1T            2736            3323             0.4515597 0.3579747                 No
# 12: DBW-40-3T  DBW-40-N            2775            3284             0.4579964 0.3770581                 No
# 13: DBW-40-3T DBW-43-1T            2753            3306             0.4543654 0.3721022                 No
# 14:  DBW-40-N  DBW-43-N            2965            3094             0.4893547 0.3839140                 No
# 15: DBW-43-1T  DBW-43-N            2876            3183             0.4746658 0.3797829                 No
```

```
res$BAM_matches
```

```
# [[1]]
# [1] "DBW-40-1T" "DBW-40-2T" "DBW-40-3T" "DBW-43-N"
#
# [[2]]
# [1] "DBW-40-2T" "DBW-40-3T" "DBW-43-N"
#
# [[3]]
# [1] "DBW-40-3T" "DBW-43-N"
#
# [[4]]
# [1] "DBW-40-N"  "DBW-43-1T"
```

Results can be visualized with the correlation plot.

```
cor_table = cor(res$AF_table)
```

```
pheatmap::pheatmap(cor_table, breaks = seq(0, 1, 0.01))
```

![](data:image/png;base64...)

Above results indicate that sample `DBW-43-N` possibly matches with `DBW-40-1T`, `DBW-40-2T`, `DBW-40-3T` whereas, `DBW-40-N` is in-fact a normal for the sample `DBW-43-1T` suggesting a sample mislabeling.

The list of 6059 SNPs used for genotyping are carefully compiled by [Westphal et. al.](https://bmcgenomics.biomedcentral.com/articles/10.1186/s12864-019-6332-7) and are located in the exonic regions and hence can be used for WGS, as well as WXS BAM files. Please cite [Westphal et. al.](https://bmcgenomics.biomedcentral.com/articles/10.1186/s12864-019-6332-7) if you find this function useful.

# 13 TCGA cohorts

Analysis of TCGA cohorts with `maftools` is as easy as it can get. This is made possible by processing TCGA MAF files from [Broad firehose](https://gdac.broadinstitute.org/) and TCGA [MC3](https://gdc.cancer.gov/about-data/publications/mc3-2017) project. Every cohort is stored as an MAF object containing somatic mutations (no CNVs) along with the relevant clinical information. There are two functions

* `tcgaAvailable()` will display available cohorts
* `tcgaLoad()` will load the desired cohort

## 13.1 Available cohorts

```
tcga_avail = tcgaAvailable()
head(tcga_avail, 3)
```

```
##    Study_Abbreviation                   Study_Name   MC3
##                <char>                       <char> <int>
## 1:                ACC     Adrenocortical_carcinoma    92
## 2:               BLCA Bladder_Urothelial_Carcinoma   411
## 3:               BRCA    Breast_invasive_carcinoma  1026
##                             Firehose   CCLE
##                               <char> <char>
## 1:  62 [dx.doi.org/10.7908/C1610ZNC]
## 2: 395 [dx.doi.org/10.7908/C1MW2GGF]
## 3: 978 [dx.doi.org/10.7908/C1TB167Z]
```

## 13.2 Loading a TCGA cohort

```
# By default MAF from MC3 project will be loaded
laml_mc3 = tcgaLoad(study = "LAML")
```

```
## Loading LAML. Please cite: https://doi.org/10.1016/j.cels.2018.03.002 for reference
```

```
laml_mc3
```

```
## An object of class  MAF
##                         ID  summary   Mean Median
##                     <char>   <char>  <num>  <num>
##  1:             NCBI_Build   GRCh37     NA     NA
##  2:                 Center MC3_LAML     NA     NA
##  3:                Samples      140     NA     NA
##  4:                 nGenes     4142     NA     NA
##  5:        Frame_Shift_Del      131  0.936    0.0
##  6:        Frame_Shift_Ins      377  2.693    0.0
##  7:           In_Frame_Del        9  0.064    0.0
##  8:           In_Frame_Ins        3  0.021    0.0
##  9:      Missense_Mutation     4137 29.550    7.5
## 10:      Nonsense_Mutation      264  1.886    0.0
## 11:       Nonstop_Mutation       18  0.129    0.0
## 12:            Splice_Site      780  5.571    1.0
## 13: Translation_Start_Site        4  0.029    0.0
## 14:                  total     5723 40.879   13.0
```

```
# Change the source to Firehose
laml_fh = tcgaLoad(study = "LAML", source = "Firehose")
```

```
## Loading LAML. Please cite: dx.doi.org/10.7908/C1D21X2X for reference
```

```
laml_fh
```

```
## An object of class  MAF
##                    ID          summary  Mean Median
##                <char>           <char> <num>  <num>
##  1:        NCBI_Build               37    NA     NA
##  2:            Center genome.wustl.edu    NA     NA
##  3:           Samples              192    NA     NA
##  4:            nGenes             1241    NA     NA
##  5:   Frame_Shift_Del               52 0.271      0
##  6:   Frame_Shift_Ins               91 0.474      0
##  7:      In_Frame_Del               10 0.052      0
##  8:      In_Frame_Ins               42 0.219      0
##  9: Missense_Mutation             1342 6.990      7
## 10: Nonsense_Mutation              103 0.536      0
## 11:       Splice_Site               92 0.479      0
## 12:             total             1732 9.021      9
```

There is also an R data package containing the same pre-compiled TCGA MAF objects. Due to Bioconductor package size limits and other difficulties, this was not submitted to Bioconductor. However, you can still download [TCGAmutations](https://github.com/PoisonAlien/TCGAmutations) package from GitHub.

```
BiocManager::install(pkgs = "PoisonAlien/TCGAmutations")
```

# 14 MultiAssayExperiment

MAF can be converted to an object of class [MultiAssayExperiment](https://www.bioconductor.org/packages/release/bioc/html/MultiAssayExperiment.html) which facilitates integration of MAF with distinct data types. More information on `MultiAssayExperiment` can be found on the corresponding Bioconductor [landing page](https://www.bioconductor.org/packages/release/bioc/html/MultiAssayExperiment.html).

Note: Converting MAF to MAE object requires installation of [MultiAssayExperiment](https://www.bioconductor.org/packages/release/bioc/html/MultiAssayExperiment.html) and [RaggedExperiment](https://www.bioconductor.org/packages/release/bioc/html/RaggedExperiment.html) packages.

```
laml_mae = maf2mae(m = laml)
```

```
## Loading required namespace: RaggedExperiment
```

```
## Loading required namespace: MultiAssayExperiment
```

```
laml_mae
```

```
## A MultiAssayExperiment object of 2 listed
##  experiments with user-defined names and respective classes.
##  Containing an ExperimentList class object of length 2:
##  [1] maf_nonSyn: RaggedExperiment with 1732 rows and 193 columns
##  [2] maf_syn: RaggedExperiment with 475 rows and 193 columns
## Functionality:
##  experiments() - obtain the ExperimentList instance
##  colData() - the primary/phenotype DataFrame
##  sampleMap() - the sample coordination DataFrame
##  `$`, `[`, `[[` - extract colData columns, subset, or experiment
##  *Format() - convert into a long or wide DataFrame
##  assays() - convert ExperimentList to a SimpleList of matrices
##  exportClass() - save data to flat files
```

# 15 Useful links and tools

| File Fomats | Data portals | Annotation tools |
| --- | --- | --- |
| [Mutation Annotation Format](https://docs.gdc.cancer.gov/Data/File_Formats/MAF_Format/) | [TCGA](http://cancergenome.nih.gov) | [vcf2maf](https://github.com/mskcc/vcf2maf) - for converting your VCF files to MAF |
| [Variant Call Format](https://en.wikipedia.org/wiki/Variant_Call_Format) | [ICGC](https://docs.icgc.org/) | [annovar2maf](https://github.com/PoisonAlien/annovar2maf) - for converting annovar output files to MAF |
| ICGC [Simple Somatic Mutation Format](https://docs.icgc.org/submission/guide/icgc-simple-somatic-mutation-format/) | [Broad Firehose](https://gdac.broadinstitute.org/) | [bcftools csq](https://samtools.github.io/bcftools/howtos/csq-calling.html) - Rapid annotations of VCF files with variant consequences |
|  | [cBioPortal](https://www.cbioportal.org/) | [Annovar](https://annovar.openbioinformatics.org/en/latest/) |
|  | [PeCan](https://pecan.stjude.cloud/) | [Funcotator](https://gatk.broadinstitute.org/hc/en-us/articles/360037224432-Funcotator) |
|  | [CIViC](https://civicdb.org/home) - Clinical interpretation of variants in cancer |  |
|  | [DGIdb](http://www.dgidb.org/) - Information on drug-gene interactions and the druggable genome |  |

Below are some more useful software packages for somatic variant analysis.

* [TRONCO](https://github.com/BIMIB-DISCo/TRONCO) - Repository of the TRanslational ONCOlogy library (R)
* [dndscv](https://github.com/im3sanger/dndscv) - dN/dS methods to quantify selection in cancer and somatic evolution (R)
* [cloneevol](https://github.com/hdng/clonevol) - Inferring and visualizing clonal evolution in multi-sample cancer sequencing (R)
* [sigminer](https://github.com/ShixiangWang/sigminer) - Primarily for signature analysis and visualization in R. Supports `maftools` output (R)
* [GenVisR](https://github.com/griffithlab/GenVisR) - Primarily for visualization (R)
* [comut](https://github.com/vanallenlab/comut) - Primarily for visualization (Python)
* [TCGAmutations](https://github.com/PoisonAlien/TCGAmutations) - pre-compiled curated somatic mutations from TCGA cohorts (from Broad Firehose and TCGA MC3 Project) that can be loaded into `maftools` (R)
* [somaticfreq](https://github.com/PoisonAlien/somaticfreq) - rapid genotyping of known somatic hotspot variants from the tumor BAM files. Generates a browsable/sharable HTML report. (C)

# 16 References

1. Cancer Genome Atlas Research, N. Genomic and epigenomic landscapes of adult de novo acute myeloid leukemia. N Engl J Med 368, 2059-74 (2013).
2. Mermel, C.H. et al. GISTIC2.0 facilitates sensitive and confident localization of the targets of focal somatic copy-number alteration in human cancers. Genome Biol 12, R41 (2011).
3. Olshen, A.B., Venkatraman, E.S., Lucito, R. & Wigler, M. Circular binary segmentation for the analysis of array-based DNA copy number data. Biostatistics 5, 557-72 (2004).
4. Alexandrov, L.B. et al. Signatures of mutational processes in human cancer. Nature 500, 415-21 (2013).
5. Tamborero, D., Gonzalez-Perez, A. & Lopez-Bigas, N. OncodriveCLUST: exploiting the positional clustering of somatic mutations to identify cancer genes. Bioinformatics 29, 2238-44 (2013).
6. Dees, N.D. et al. MuSiC: identifying mutational significance in cancer genomes. Genome Res 22, 1589-98 (2012).
7. Lawrence MS, Stojanov P, Mermel CH, Robinson JT, Garraway LA, Golub TR, Meyerson M, Gabriel SB, Lander ES, Getz G: Discovery and saturation analysis of cancer genes across 21 tumour types. Nature 2014, 505:495-501.
8. Griffith, M., Griffith, O. L., Coffman, A. C., Weible, J. V., McMichael, J. F., Spies, N. C., … Wilson, R. K. (2013). DGIdb - Mining the druggable genome. Nature Methods, 10(12), 1209–1210. <http://doi.org/10.1038/nmeth.2689>
9. Sanchez-Vega F, Mina M, Armenia J, Chatila WK, Luna A, La KC, Dimitriadoy S, Liu DL, Kantheti HS, Saghafinia S et al. 2018. Oncogenic Signaling Pathways in The Cancer Genome Atlas. Cell 173: 321-337 e310
10. Madan, V. et al. Comprehensive mutational analysis of primary and relapse acute promyelocytic leukemia. Leukemia 30, 1672-81 (2016).
11. Mroz, E.A. & Rocco, J.W. MATH, a novel measure of intratumor genetic heterogeneity, is high in poor-outcome classes of head and neck squamous cell carcinoma. Oral Oncol 49, 211-5 (2013).
12. Roberts SA, Lawrence MS, Klimczak LJ, et al. An APOBEC Cytidine Deaminase Mutagenesis Pattern is Widespread in Human Cancers. Nature genetics. 2013;45(9):970-976.
13. Gaujoux, R. & Seoighe, C. A flexible R package for nonnegative matrix factorization. BMC Bioinformatics 11, 367 (2010).
14. Welch, J.S. et al. The origin and evolution of mutations in acute myeloid leukemia. Cell 150, 264-78 (2012).
15. Ramos, A.H. et al. Oncotator: cancer variant annotation tool. Hum Mutat 36, E2423-9 (2015).
16. Wang, K., Li, M. & Hakonarson, H. ANNOVAR: functional annotation of genetic variants from high-throughput sequencing data. Nucleic Acids Res 38, e164 (2010).
17. Lawrence MS, Stojanov P, Polak P, Kryukov GV, Cibulskis K, Sivachenko A, Carter SL, Stewart C, Mermel CH, Roberts SA, et al: Mutational heterogeneity in cancer and the search for new cancer-associated genes. Nature 2013, 499:214-218.
18. Westphal, M., Frankhouser, D., Sonzone, C. et al. SMaSH: Sample matching using SNPs in humans. BMC Genomics 20, 1001 (2019)

# 17 Session Info

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
## [1] parallel  stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] pheatmap_1.0.13                   doParallel_1.0.17
##  [3] iterators_1.0.14                  foreach_1.5.2
##  [5] NMF_0.28                          bigmemory_4.6.4
##  [7] Biobase_2.70.0                    cluster_2.1.8.1
##  [9] rngtools_1.5.2                    registry_0.5-1
## [11] BSgenome.Hsapiens.UCSC.hg19_1.4.3 BSgenome_1.78.0
## [13] rtracklayer_1.70.0                BiocIO_1.20.0
## [15] Biostrings_2.78.0                 XVector_0.50.0
## [17] GenomicRanges_1.62.0              Seqinfo_1.0.0
## [19] IRanges_2.44.0                    S4Vectors_0.48.0
## [21] BiocGenerics_0.56.0               generics_0.1.4
## [23] mclust_6.1.1                      maftools_2.26.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1            gridBase_0.4-7
##  [3] dplyr_1.1.4                 farver_2.1.2
##  [5] R.utils_2.13.0              S7_0.2.0
##  [7] bitops_1.0-9                RaggedExperiment_1.34.0
##  [9] fastmap_1.2.0               RCurl_1.98-1.17
## [11] GenomicAlignments_1.46.0    XML_3.99-0.19
## [13] digest_0.6.37               lifecycle_1.0.4
## [15] survival_3.8-3              magrittr_2.0.4
## [17] compiler_4.5.1              rlang_1.1.6
## [19] sass_0.4.10                 tools_4.5.1
## [21] yaml_2.3.10                 data.table_1.17.8
## [23] knitr_1.50                  S4Arrays_1.10.0
## [25] curl_7.0.0                  DelayedArray_0.36.0
## [27] plyr_1.8.9                  RColorBrewer_1.1-3
## [29] abind_1.4-8                 BiocParallel_1.44.0
## [31] R.oo_1.27.1                 grid_4.5.1
## [33] colorspace_2.1-2            ggplot2_4.0.0
## [35] scales_1.4.0                MultiAssayExperiment_1.36.0
## [37] dichromat_2.0-0.1           SummarizedExperiment_1.40.0
## [39] cli_3.6.5                   rmarkdown_2.30
## [41] crayon_1.5.3                bigmemory.sri_0.1.8
## [43] httr_1.4.7                  reshape2_1.4.4
## [45] rjson_0.2.23                BiocBaseUtils_1.12.0
## [47] DNAcopy_1.84.0              cachem_1.1.0
## [49] stringr_1.5.2               splines_4.5.1
## [51] BiocManager_1.30.26         restfulr_0.0.16
## [53] matrixStats_1.5.0           vctrs_0.6.5
## [55] Matrix_1.7-4                jsonlite_2.0.0
## [57] berryFunctions_1.22.13      jquerylib_0.1.4
## [59] glue_1.8.0                  codetools_0.2-20
## [61] stringi_1.8.7               gtable_0.3.6
## [63] tibble_3.3.0                pillar_1.11.1
## [65] htmltools_0.5.8.1           R6_2.6.1
## [67] evaluate_1.0.5              lattice_0.22-7
## [69] R.methodsS3_1.8.2           Rsamtools_2.26.0
## [71] cigarillo_1.0.0             bslib_0.9.0
## [73] uuid_1.2-1                  Rcpp_1.1.0
## [75] SparseArray_1.10.0          xfun_0.53
## [77] MatrixGenerics_1.22.0       pkgconfig_2.0.3
```

# 18 Support and acknowledgments

## 18.1 Github

If you have any issues, bug reports or feature requests please feel free to raise an [issue](https://github.com/PoisonAlien/maftools/issues) on [GitHub](https://github.com/PoisonAlien/maftools) page.

## 18.2 Acknowledgements

* Thanks to [Shixiang Wang](https://github.com/ShixiangWang) for many bug fixes, improvements, feature requests, and contribution to overall package maintenance
* Thanks to [@biosunsci](<https://github.com/biosunsci>) `coGisticChromPlot`
* Thanks to [Ryan Morin](https://github.com/rdmorin) for crucial bug fixes
* Thanks to [Peter Ellis](https://twitter.com/ellis2013nz) for beautiful [markdown template](http://ellisp.github.io/blog/2017/09/09/rmarkdown)
* `somaticInteractions` plot is inspired from the article [Combining gene mutation with gene expression data improves outcome prediction in myelodysplastic syndromes](https://www.nature.com/articles/ncomms6901). Thanks to authors for making source code available.