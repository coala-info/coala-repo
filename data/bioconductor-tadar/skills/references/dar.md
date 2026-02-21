# Differential Allelic Representation (DAR) analysis

Lachlan Baer1\* and Stevie Pederson2,3,4\*\*

1Alzheimer's Disease Genetics Laboratory, The University of Adelaide, Adelaide, Australia
2Black Ochre Data Laboratories, Telethon Kids Institute, Adelaide, Australia
3Dame Roma Mitchell Cancer Researc Laboratories, University of Adelaide
4John Curtin School of Medical Research, Australian National University

\*baerlachlan@gmail.com
\*\*stephen.pederson.au@gmail.com

#### 30 October 2025

#### Package

tadar 1.8.0

# 1 Introduction

## 1.1 Background

Differential Allelic Representation (DAR) describes a situation commonly encountered in RNA-seq experiments involving organisms that are not isogenic, and where modern techniques such as CRISPR have been used for generation of individual organisms.
DAR compromises the integrity of Differential Expression analysis results as it can bias expression, influencing the classification of genes (or transcripts) as being differentially expressed (DE).
The concern does not lie within the statistical measures for detecting differential expression, because the underlying biology does indeed result in differential expression.
However, without DAR analysis, the impacts of DAR are confounded with the experimental condition of interest and features can be incorrectly inferred as DE in response to the experimental condition, when they are actually an artefact of DAR.
DAR analysis is therefore recommended as a complementary technique alongside Differential Expression analysis where non-isogenic conditions are present.

DAR occurs when the construction of experimental sample groups unexpectedly results in an unequal distribution of polymorphic alleles between the groups.
This is often due to random chance when selecting group composition, however, may also be compounded by a study’s experimental design (described further below).
When unequally-represented polymorphic alleles are also expression quantitative trait loci (eQTLs), expression differences between experimental groups are observed similarly to that of a functional response to an experimental condition (Figure [1](#fig:ase-example)).
Analysis of gene expression in absence of the consideration of DAR is problematic as the source of differential expression will be unclear.

![Two confounding scenarios that result in differential gene expression between experimental groups when samples are not isogenic. *Experimental grouping is illustrated as mutant vs wild-type control, but is also applicable for other experimental designs (e.g. treatment vs control). The key aspect here is that polymorphic regions of the homologous chromosomes differ between the experimental groups. **A)** Functional differential expression. The experimental factor (genotype of the gene-of-interest, GOI) has a functional interaction with a bystander gene (linked gene, LG), resulting in expression differences between the experimental groups. This is the assumed mechanism when inferring differential expression outcomes. However, a lack of between-group isogenicity complicates this assumption. **B)** eQTL-driven differential expression. A polymorphism in the promoter region of mutant samples, for example, causes expression differences between mutant and wild-type groups in the absence of a functional interaction between GOI and LG. This may incorrectly be inferred as differential expression due to the experimental condition.*](data:image/png;base64...)

Figure 1: Two confounding scenarios that result in differential gene expression between experimental groups when samples are not isogenic
*Experimental grouping is illustrated as mutant vs wild-type control, but is also applicable for other experimental designs (e.g. treatment vs control). The key aspect here is that polymorphic regions of the homologous chromosomes differ between the experimental groups. **A)** Functional differential expression. The experimental factor (genotype of the gene-of-interest, GOI) has a functional interaction with a bystander gene (linked gene, LG), resulting in expression differences between the experimental groups. This is the assumed mechanism when inferring differential expression outcomes. However, a lack of between-group isogenicity complicates this assumption. **B)** eQTL-driven differential expression. A polymorphism in the promoter region of mutant samples, for example, causes expression differences between mutant and wild-type groups in the absence of a functional interaction between GOI and LG. This may incorrectly be inferred as differential expression due to the experimental condition.*

The presence of DAR is influenced by the nature of an experiment’s design.
In studies that select experimental groups from a common sample pool, for example “treatment vs control” designs, DAR is predominantly driven by the isogenicity within the initial pool and the stochastic selection of samples.
However, in studies involving the selection of groups based on a genetic feature, for example “mutant vs wild-type”, the presence of DAR is often intensified on the chromosome(s) containing the determining feature.
This is because the selection criteria also drives selection for alleles linked to the determining feature (Figure [2](#fig:selection-driven-dar)).

![DAR is frequently encountered in studies that involve experimental group selection based on the presence of a genetic feature, and is intensified on the chromosome containing the feature. *This figure illustrates the scenario where experimental sample groups are selected based on the presence of a mutant locus. Zebrafish are used as an example to signify that the model organism is not isogenic. **A)** A common breeding scheme for an intrafamily homozygous mutant vs wild-type transcriptome comparison. As a result of selection across multiple generations for the mutant chromosome (indicated in red), which originates from a single F~0~ fish (not pictured), homozygous mutant F~y~ fish posess two exact copies of the chromosome harbouring the mutation, disregarding recombination. However, wild-type F~y~ fish likely posses two different wild-type chromosomes (shaded using different stripe pattterns to indicate they are not isogenic). **B)** Experimental selection of progeny homozygous for a mutant allele involves increased homozygosity for alleles of genes linked to that mutation (i.e. on the same chromosome). High DAR is observed at the eQTL location, resulting in expression differences between the groups that are unrelated to the impact of the mutation. Moderate DAR is observed at the polymorphic locus, due to one of the wild-type chromosomes posessing the same polymorphism. If this polymorphism was also an eQTL, expression differences would be observed to a lesser extent.*](data:image/png;base64...)

Figure 2: DAR is frequently encountered in studies that involve experimental group selection based on the presence of a genetic feature, and is intensified on the chromosome containing the feature
*This figure illustrates the scenario where experimental sample groups are selected based on the presence of a mutant locus. Zebrafish are used as an example to signify that the model organism is not isogenic. **A)** A common breeding scheme for an intrafamily homozygous mutant vs wild-type transcriptome comparison. As a result of selection across multiple generations for the mutant chromosome (indicated in red), which originates from a single F0 fish (not pictured), homozygous mutant Fy fish posess two exact copies of the chromosome harbouring the mutation, disregarding recombination. However, wild-type Fy fish likely posses two different wild-type chromosomes (shaded using different stripe pattterns to indicate they are not isogenic). **B)** Experimental selection of progeny homozygous for a mutant allele involves increased homozygosity for alleles of genes linked to that mutation (i.e. on the same chromosome). High DAR is observed at the eQTL location, resulting in expression differences between the groups that are unrelated to the impact of the mutation. Moderate DAR is observed at the polymorphic locus, due to one of the wild-type chromosomes posessing the same polymorphism. If this polymorphism was also an eQTL, expression differences would be observed to a lesser extent.*

DAR analysis results in an easy-to-interpret value between 0 and 1 for each genetic feature of interest, where 0 represents identical allelic representation and 1 represents complete diversity.
This metric can be used to identify features prone to false-positive calls in Differential Expression analysis, and can be leveraged with statistical methods to alleviate the impact of such artefacts on RNA-seq data.

## 1.2 Further reading

* The methodologies of this package were developed and described in Baer et al. ([2023](#ref-baer2023)).
* This phenomenon was flagged as problematic in White et al. ([2022](#ref-white2022)).

# 2 Setup

## 2.1 Installation

`BiocManager` is recommended for the installation of packages required in this vignette.
`BiocManager` handles the installation of packages from both the CRAN and Bioconductor repositories.

```
if (!"BiocManager" %in% rownames(installed.packages()))
    install.packages("BiocManager")
pkgs <- c("tidyverse", "limma", "tadar")
BiocManager::install(pkgs, update = FALSE)
```

Now we can load the required packages.

```
library(tidyverse)
library(limma)
library(tadar)
```

## 2.2 Data

The example data used in this vignette is provided within the `tadar` package.

The `VCF` file `chr1.vcf.bgz` contains multi-sample genotype calls produced from raw RNA-seq `FASTQ` data.
The data originates from zebrafish (*Danio rerio*) brain transcriptomes, and further information can be found in the associated manuscript by Gerken et al. ([2023](#ref-gerken2023)).
The `VCF` has been modified to remove headers and other data that are not essential for example purposes, and has been subset to a single chromosome (Chromosome 1).

The `GRanges` object `chr1_genes` contains gene feature information from the Ensembl database (release version 101) for *Danio rerio* Chromosome 1 (Cunningham et al. ([2022](#ref-cunningham2022))).

```
vcf <- system.file("extdata", "chr1.vcf.bgz", package = "tadar")
data("chr1_genes")
data("chr1_tt")
```

# 3 Quick start

DAR analysis requires only several lines of code.
This section provides an overview of DAR analysis with `tadar`, and exists as a reference for those familiar with the process.
See the next section if you seek a detailed walkthrough.

First load the required packages.

```
library(tidyverse)
library(limma)
library(tadar)
```

Then define the input objects.

```
vcf <- system.file("extdata", "chr1.vcf.bgz", package="tadar")
data("chr1_genes")
data("chr1_tt")
groups <- list(
    group1 = paste0("sample", 1:6),
    group2 = paste0("sample", 7:13)
)
contrasts <- makeContrasts(
    group1v2 = group1 - group2,
    levels = names(groups)
)
region_loci <- 5
```

Now use the `base` pipe to assign DAR values to genes based on their surrounding region.

```
gene_dar <- readGenotypes(vcf) |>
    countAlleles(groups = groups) |>
    filterLoci() |>
    countsToProps() |>
    dar(contrasts = contrasts, region_loci = region_loci) |>
    flipRanges(extend_edges = TRUE) |>
    assignFeatureDar(features = chr1_genes, dar_val = "region")
```

Lastly, use the gene-level DAR values to moderate the corresponding *p*-values from differential gene expression analysis.

```
chr1_tt <- merge(chr1_tt, mcols(gene_dar$group1v2), sort = FALSE)
chr1_tt$darP <- modP(chr1_tt$PValue, chr1_tt$dar)
```

# 4 DAR analysis

DAR analysis is performed by incorporating single nucleotide-level genotype calls from variant calling software.
We recommend the GATK best practices workflow for [RNAseq short variant discovery (SNPs + Indels)](https://gatk.broadinstitute.org/hc/en-us/articles/360035531192-RNAseq-short-variant-discovery-SNPs-Indels-) as a reference for the generation of data required to begin DAR analysis.
However, should individual genomes be also available for the experimental samples, these can add significant important information.
Ultimately, we require a multi-sample `VCF` file with each entry representing the genomic location of a single nucleotide polymorphism (SNP) that differs from the reference genome in at least one sample.

The functions contained in this package are intended to be implemented as a sequential workflow, with each function addressing a discrete step in the data processing/analysis procedure.
Please follow the steps in order as outlined below.

## 4.1 Loading genotype data

Genotype data from a `VCF` file is parsed into a `GRanges` object using the `readGenotypes()` function.
This function is essentially a wrapper to `VariantAnnotation::readVcf()`, but only loads the data required for DAR analysis.
By default, phasing information is removed as it is not required for DAR analysis and complicates downstream processing.
This simply converts genotype calls represented as, for example `0|1` to `0/1`, and is required if proceeding with the DAR analysis workflow.
This can optionally be turned off with the `unphase` argument if this function is intended to be used for alternative purposes.
The `genome` option is also available to override the genome automatically detected from the `VCF`.
We intend to work with multiple `GRanges` objects and keeping the genome consistent avoids downstream errors.
Additional arguments will be passed directly to `VariantAnnotation::readVcf()`.

```
genotypes <- readGenotypes(file = vcf)
```

```
#> GRanges object with 6 ranges and 13 metadata columns:
#>       seqnames    ranges strand |     sample1     sample2     sample3     sample4     sample5     sample6     sample7     sample8     sample9    sample10    sample11    sample12    sample13
#>          <Rle> <IRanges>  <Rle> | <character> <character> <character> <character> <character> <character> <character> <character> <character> <character> <character> <character> <character>
#>   [1]        1      6698      * |         0/1         0/1         0/1         0/1         0/1         0/1         1/1         0/1         0/1         0/1         1/1         0/1         0/1
#>   [2]        1      7214      * |         ./.         ./.         ./.         ./.         ./.         ./.         ./.         ./.         ./.         ./.         ./.         ./.         1/1
#>   [3]        1      7218      * |         ./.         ./.         ./.         ./.         ./.         ./.         ./.         ./.         ./.         ./.         ./.         ./.         1/1
#>   [4]        1      7274      * |         ./.         0/0         ./.         ./.         ./.         ./.         ./.         ./.         ./.         ./.         ./.         0/0         0/1
#>   [5]        1      9815      * |         ./.         ./.         ./.         ./.         ./.         0/0         ./.         ./.         ./.         ./.         1/1         ./.         ./.
#>   [6]        1      9842      * |         ./.         ./.         ./.         ./.         ./.         0/0         ./.         ./.         ./.         ./.         1/1         ./.         ./.
#>   -------
#>   seqinfo: 1 sequence from GRCz11 genome
```

Genotypes are reported as numeric indices.
`0` indicates the reference allele, `1` is the first alternate allele, `2` is the second alternate allele, and `3` is the third alternate allele.
Even though we are working with a diploid organism, four alleles are theoretically possible as the VCF consists of multiple samples.
Genotypes that could not be determined by the variant calling software are reported as `./.`.
We work directly with the indices as they are consistent across all samples for a single variant position.

## 4.2 Counting alleles

We aim to calculate a DAR value at each suitable variant locus.
This requires us to firstly summarise the genotype data into counts of the alleles reported at each variant locus.
First we define our sample grouping structure as a `list`, where each element contains a character vector of samples within a single group.

```
groups <- list(
    group1 = paste0("sample", 1:6),
    group2 = paste0("sample", 7:13)
)
```

Now at each locus we can count the number of alleles that exist within each group with `countAlleles()`.
This returns a `GRangesList` with each element corresponding to a different sample group.
Columns indicate how many samples had called alleles, how many were missing and the counts of reference allele, followed by alternate alleles `n_1`, `n_2` and `n_3` ensuring multi-allelic sites are retained.

```
counts <- countAlleles(genotypes = genotypes, groups = groups)
```

```
#> GRangesList object of length 2:
#> $group1
#> GRanges object with 16994 ranges and 6 metadata columns:
#>           seqnames    ranges strand |  n_called n_missing       n_0       n_1       n_2       n_3
#>              <Rle> <IRanges>  <Rle> | <integer> <integer> <integer> <integer> <integer> <integer>
#>       [1]        1      6698      * |        12         0         6         6         0         0
#>       [2]        1      7214      * |         0        12         0         0         0         0
#>       [3]        1      7218      * |         0        12         0         0         0         0
#>       [4]        1      7274      * |         2        10         2         0         0         0
#>       [5]        1      9815      * |         2        10         2         0         0         0
#>       ...      ...       ...    ... .       ...       ...       ...       ...       ...       ...
#>   [16990]        1  59566458      * |         4         8         4         0         0         0
#>   [16991]        1  59567075      * |         6         6         5         1         0         0
#>   [16992]        1  59567620      * |         2        10         2         0         0         0
#>   [16993]        1  59570107      * |         0        12         0         0         0         0
#>   [16994]        1  59570454      * |         2        10         2         0         0         0
#>   -------
#>   seqinfo: 1 sequence from GRCz11 genome
#>
#> $group2
#> GRanges object with 16994 ranges and 6 metadata columns:
#>           seqnames    ranges strand |  n_called n_missing       n_0       n_1       n_2       n_3
#>              <Rle> <IRanges>  <Rle> | <integer> <integer> <integer> <integer> <integer> <integer>
#>       [1]        1      6698      * |        14         0         5         9         0         0
#>       [2]        1      7214      * |         2        12         0         2         0         0
#>       [3]        1      7218      * |         2        12         0         2         0         0
#>       [4]        1      7274      * |         4        10         3         1         0         0
#>       [5]        1      9815      * |         2        12         0         2         0         0
#>       ...      ...       ...    ... .       ...       ...       ...       ...       ...       ...
#>   [16990]        1  59566458      * |         4        10         3         1         0         0
#>   [16991]        1  59567075      * |         4        10         4         0         0         0
#>   [16992]        1  59567620      * |         6         8         6         0         0         0
#>   [16993]        1  59570107      * |         0        14         0         0         0         0
#>   [16994]        1  59570454      * |         2        12         0         2         0         0
#>   -------
#>   seqinfo: 1 sequence from GRCz11 genome
```

## 4.3 Removing undesired loci

Not all samples were assigned genotypes during the variant calling procedure.
Loci with a large number of assigned genotypes across all samples possess information that can be used to more accurately determine differences in allelic representation between experimental groups.
We can remove the less informative data by filtering variant loci independently within each sample group with the `filterLoci()` function.
The `filter` argument controls the criterion for selection of loci that we want to keep, by providing a logical expression using the metadata column names of our `counts` object (i.e. `n_called`, `n_missing`, `n_0`, `n_1`, `n_2` and `n_3`).
By default, `filterLoci()` keeps loci that satisfy the criterion: number of samples with called genotypes > number of samples with missing genotypes.

```
counts_filt <- filterLoci(counts = counts)
```

```
#> GRangesList object of length 2:
#> $group1
#> GRanges object with 10701 ranges and 6 metadata columns:
#>           seqnames    ranges strand |  n_called n_missing       n_0       n_1       n_2       n_3
#>              <Rle> <IRanges>  <Rle> | <integer> <integer> <integer> <integer> <integer> <integer>
#>       [1]        1      6698      * |        12         0         6         6         0         0
#>       [2]        1     10093      * |        12         0         6         6         0         0
#>       [3]        1     13098      * |        12         0        12         0         0         0
#>       [4]        1     13300      * |        12         0        12         0         0         0
#>       [5]        1     13558      * |        12         0        12         0         0         0
#>       ...      ...       ...    ... .       ...       ...       ...       ...       ...       ...
#>   [10697]        1  59563688      * |         8         4         6         2         0         0
#>   [10698]        1  59563996      * |        10         2        10         0         0         0
#>   [10699]        1  59564693      * |        10         2         8         2         0         0
#>   [10700]        1  59565427      * |         8         4         8         0         0         0
#>   [10701]        1  59565445      * |         8         4         8         0         0         0
#>   -------
#>   seqinfo: 1 sequence from GRCz11 genome
#>
#> $group2
#> GRanges object with 12199 ranges and 6 metadata columns:
#>           seqnames    ranges strand |  n_called n_missing       n_0       n_1       n_2       n_3
#>              <Rle> <IRanges>  <Rle> | <integer> <integer> <integer> <integer> <integer> <integer>
#>       [1]        1      6698      * |        14         0         5         9         0         0
#>       [2]        1     10093      * |        14         0         9         5         0         0
#>       [3]        1     13098      * |        14         0        13         1         0         0
#>       [4]        1     13300      * |        14         0        14         0         0         0
#>       [5]        1     13558      * |        14         0        14         0         0         0
#>       ...      ...       ...    ... .       ...       ...       ...       ...       ...       ...
#>   [12195]        1  59564693      * |        12         2        11         1         0         0
#>   [12196]        1  59565850      * |        10         4         8         2         0         0
#>   [12197]        1  59565874      * |        12         2        10         2         0         0
#>   [12198]        1  59566219      * |        10         4        10         0         0         0
#>   [12199]        1  59566270      * |         8         6         4         4         0         0
#>   -------
#>   seqinfo: 1 sequence from GRCz11 genome
```

Specifying a filter with high stringency will result in greater removal of loci, but more accurate downstream results.
For example, we can remove all loci where at least one sample does not possess a genotype call, resulting in complete information of allelic representation in each sample group.

```
counts_filt_2 <- filterLoci(counts = counts, filter = n_missing == 0)
```

```
#> GRangesList object of length 2:
#> $group1
#> GRanges object with 7551 ranges and 6 metadata columns:
#>          seqnames    ranges strand |  n_called n_missing       n_0       n_1       n_2       n_3
#>             <Rle> <IRanges>  <Rle> | <integer> <integer> <integer> <integer> <integer> <integer>
#>      [1]        1      6698      * |        12         0         6         6         0         0
#>      [2]        1     10093      * |        12         0         6         6         0         0
#>      [3]        1     13098      * |        12         0        12         0         0         0
#>      [4]        1     13300      * |        12         0        12         0         0         0
#>      [5]        1     13558      * |        12         0        12         0         0         0
#>      ...      ...       ...    ... .       ...       ...       ...       ...       ...       ...
#>   [7547]        1  59332656      * |        12         0        11         1         0         0
#>   [7548]        1  59335556      * |        12         0         6         6         0         0
#>   [7549]        1  59335583      * |        12         0         7         5         0         0
#>   [7550]        1  59335775      * |        12         0        12         0         0         0
#>   [7551]        1  59335805      * |        12         0         9         3         0         0
#>   -------
#>   seqinfo: 1 sequence from GRCz11 genome
#>
#> $group2
#> GRanges object with 8425 ranges and 6 metadata columns:
#>          seqnames    ranges strand |  n_called n_missing       n_0       n_1       n_2       n_3
#>             <Rle> <IRanges>  <Rle> | <integer> <integer> <integer> <integer> <integer> <integer>
#>      [1]        1      6698      * |        14         0         5         9         0         0
#>      [2]        1     10093      * |        14         0         9         5         0         0
#>      [3]        1     13098      * |        14         0        13         1         0         0
#>      [4]        1     13300      * |        14         0        14         0         0         0
#>      [5]        1     13558      * |        14         0        14         0         0         0
#>      ...      ...       ...    ... .       ...       ...       ...       ...       ...       ...
#>   [8421]        1  59335556      * |        14         0         9         5         0         0
#>   [8422]        1  59335583      * |        14         0         9         5         0         0
#>   [8423]        1  59335775      * |        14         0        13         1         0         0
#>   [8424]        1  59406400      * |        14         0        12         2         0         0
#>   [8425]        1  59559081      * |        14         0        10         4         0         0
#>   -------
#>   seqinfo: 1 sequence from GRCz11 genome
```

Note that because the filter is applied within each experimental sample group, we now have loci that are present in one group but not the other.
This allows greater flexibility for more complex experimental designs that involve multiple comparisons between a greater number of sample groups than provided in this example.
Ultimately, comparisons of allelic representation will be performed only on the intersection of loci present in each sample group.

## 4.4 Normalisation of allele counts

Depending on the stringency of the previously applied filter, it’s still possible that not every sample will have a genotype call.
One experimental group may also contain more samples than another, which is the case in this example, where group1 contains 6 samples and group2 contains 7 samples.
We account for this by normalising the allele counts as a proportion of total counts at each locus.

```
props <- countsToProps(counts = counts_filt)
```

```
#> GRangesList object of length 2:
#> $group1
#> GRanges object with 10701 ranges and 4 metadata columns:
#>           seqnames    ranges strand |    prop_0    prop_1    prop_2    prop_3
#>              <Rle> <IRanges>  <Rle> | <numeric> <numeric> <numeric> <numeric>
#>       [1]        1      6698      * |       0.5       0.5         0         0
#>       [2]        1     10093      * |       0.5       0.5         0         0
#>       [3]        1     13098      * |       1.0       0.0         0         0
#>       [4]        1     13300      * |       1.0       0.0         0         0
#>       [5]        1     13558      * |       1.0       0.0         0         0
#>       ...      ...       ...    ... .       ...       ...       ...       ...
#>   [10697]        1  59563688      * |      0.75      0.25         0         0
#>   [10698]        1  59563996      * |      1.00      0.00         0         0
#>   [10699]        1  59564693      * |      0.80      0.20         0         0
#>   [10700]        1  59565427      * |      1.00      0.00         0         0
#>   [10701]        1  59565445      * |      1.00      0.00         0         0
#>   -------
#>   seqinfo: 1 sequence from GRCz11 genome
#>
#> $group2
#> GRanges object with 12199 ranges and 4 metadata columns:
#>           seqnames    ranges strand |    prop_0    prop_1    prop_2    prop_3
#>              <Rle> <IRanges>  <Rle> | <numeric> <numeric> <numeric> <numeric>
#>       [1]        1      6698      * |  0.357143 0.6428571         0         0
#>       [2]        1     10093      * |  0.642857 0.3571429         0         0
#>       [3]        1     13098      * |  0.928571 0.0714286         0         0
#>       [4]        1     13300      * |  1.000000 0.0000000         0         0
#>       [5]        1     13558      * |  1.000000 0.0000000         0         0
#>       ...      ...       ...    ... .       ...       ...       ...       ...
#>   [12195]        1  59564693      * |  0.916667 0.0833333         0         0
#>   [12196]        1  59565850      * |  0.800000 0.2000000         0         0
#>   [12197]        1  59565874      * |  0.833333 0.1666667         0         0
#>   [12198]        1  59566219      * |  1.000000 0.0000000         0         0
#>   [12199]        1  59566270      * |  0.500000 0.5000000         0         0
#>   -------
#>   seqinfo: 1 sequence from GRCz11 genome
```

## 4.5 Calculating DAR

Now that we have normalised values of allelic representation at each variant locus within our sample groups, we can calculate the DAR metric between our experimental groups.
We require at least two sample groups to proceed with DAR analysis, however we can set up more comparisons depending on how many groups are present.
We define these comparisons as a contrast `matrix`.

```
contrasts <- matrix(
    data = c(1, -1),
    dimnames = list(
        Levels = c("group1", "group2"),
        Contrasts = c("group1v2")
    )
)
```

Alternatively, this can be simplified with the `makeContrasts()` function from the `limma` package (Ritchie et al. ([2015](#ref-ritchie2015))).

```
contrasts <- makeContrasts(
    group1v2 = group1 - group2,
    levels = names(groups)
)
```

DAR is calculated by firstly determining the Euclidean distance between allelic proportions of the contrasted sample groups.
The Euclidean distance is then converted to the DAR metric by dividing by the maximum possible distance, \(\sqrt{2}\), resulting in an easy-to-interpret value between 0 and 1, where 0 represents identical allelic representation and 1 represents complete diversity.
This is handled within the `dar()` function by passing our allelic proportions and intended contrasts as arguments.

Two types of DAR values are reported by the `dar()` function as metadata columns of the resulting `GRanges` objects:

* `dar_origin`: The raw DAR values calculated at single nucleotide positions (the origin) between sample groups.
  These values represent DAR estimates at a precise locus.
* `dar_region`: The mean of raw DAR values in a specified region surrounding the origin.
  This is optionally returned using either of the `region_fixed` or `region_loci` arguments, which control the strategy and size for establishing regions (more information below).
  This option exists because eQTLs don’t necessarily confer their effects on genes in close proximity.
  Therefore, DAR estimates that are representative of regions may be more suitable for downstream assignment DAR values to genomic features.

`region_fixed` and `region_loci` are optional arguments that offer users `dar_region` values in conjunction with `dar_origin` values.
While only one of these two arguments is required, if both are provided, `region_fixed` takes precedence.
Understanding the distinctions in how each option defines regions around an origin is important, as their selection carries subjective implications downstream.

* `region_fixed`: Establishes a region with a fixed size around the origin.
  The total region size is defined in base pairs, meaning that the region will extend `region_fixed / 2` base pairs either side of the origin.
  For example if `region_fixed = 101` is specified, an origin at position 500 will have an associated region spanning positions 450-550.
* `region_loci`: Establishes an elastic region to average the specified number of loci with `dar_origin` values, such that this number of values are included.
  Note that whilst the number of points around the central value may be equal, the genomic distances may not be.
  In contrast to `region_fixed`, `region_loci` results in DAR estimates that cover a substantial proportion of each chromosome (i.e from the first locus to the last), which is useful for downstream assignment of DAR values to a greater number of genomic features.

The remainder of this vignette uses examples produced from specifying the `region_loci` argument.

```
region_loci <- 5
```

With a chosen elastic region size of 5 loci, this will smooth the DAR metric at each origin locus with the DAR values of the 2 loci either side.

```
dar <- dar(props = props, contrasts = contrasts, region_loci = region_loci)
```

```
#> GRangesList object of length 1:
#> $group1v2
#> GRanges object with 10369 ranges and 2 metadata columns:
#>           seqnames    ranges strand | dar_origin dar_region
#>              <Rle> <IRanges>  <Rle> |  <numeric>  <numeric>
#>       [1]        1      6698      * |  0.1428571         NA
#>       [2]        1     10093      * |  0.1428571         NA
#>       [3]        1     13098      * |  0.0714286  0.0714286
#>       [4]        1     13300      * |  0.0000000  0.0547619
#>       [5]        1     13558      * |  0.0000000  0.1061905
#>       ...      ...       ...    ... .        ...        ...
#>   [10365]        1  59562848      * |   0.000000  0.1300000
#>   [10366]        1  59563684      * |   0.150000  0.0800000
#>   [10367]        1  59563688      * |   0.150000  0.0833333
#>   [10368]        1  59563996      * |   0.000000         NA
#>   [10369]        1  59564693      * |   0.116667         NA
#>   -------
#>   seqinfo: 1 sequence from GRCz11 genome
```

We now have DAR values for loci shared between the two sample groups of the defined contrasts.
Each element of the resulting `GRangesList` object represents a single contrast and are named as defined in our `contrasts` object.

## 4.6 Assigning DAR values to features

The final step of DAR analysis involves assigning DAR values to features of interest.
It makes sense to select features that were tested for differential expression, because this step provides an estimate of the potential for eQTL impacts on a feature’s expression.
This is performed with the `assignFeatureDar()` function, passing the features of interest as a `GRanges` object.
In this example we use the genes contained in `chr1_genes`, which was loaded earlier.

The `fill_missing` argument controls what value is assigned to features with no overlaps.
This defaults to `NA` for easy filtering of features with unassigned DAR values.
An alternative choice may be to set this to 0, as there is no evidence for DAR in that region.

For each feature, `assignFeatureDar()` takes the mean of DAR values for any associated ranges that overlap the feature range.
With the following configuration, it means the resulting assigned DAR values represent the average DAR that exists solely within the feature.

```
gene_dar <- assignFeatureDar(
    dar = dar,
    features = chr1_genes,
    fill_missing = NA
)
```

```
#> GRangesList object of length 1:
#> $group1v2
#> GRanges object with 1456 ranges and 3 metadata columns:
#>          seqnames            ranges strand |            gene_id      gene_name       dar
#>             <Rle>         <IRanges>  <Rle> |        <character>    <character> <numeric>
#>      [1]        1        6408-12027      - | ENSDARG00000099104          rpl24 0.1428571
#>      [2]        1       11822-16373      + | ENSDARG00000102407          cep97 0.1352381
#>      [3]        1       18716-23389      + | ENSDARG00000102097         nfkbiz 0.1622024
#>      [4]        1       25585-27255      + | ENSDARG00000099319     CU651657.1        NA
#>      [5]        1       27690-34330      + | ENSDARG00000099640            eed 0.0794872
#>      ...      ...               ...    ... .                ...            ...       ...
#>   [1452]        1 59525648-59528626      - | ENSDARG00000105092     FP236157.3        NA
#>   [1453]        1 59533317-59539898      + | ENSDARG00000099880            sp6        NA
#>   [1454]        1 59542001-59542908      - | ENSDARG00000102872     FP236157.2        NA
#>   [1455]        1 59555936-59567685      - | ENSDARG00000098899 zmp:0000001082 0.0810516
#>   [1456]        1 59569516-59571785      - | ENSDARG00000101364        wfikkn1        NA
#>   -------
#>   seqinfo: 1 sequence from GRCz11 genome
```

Whilst eQTLs don’t necessarily exist within a feature itself, smoothed values within a feature may still be representative of the surrounding region as inheritied haplotypes.
The size of this region is controlled with the `region_loci` argument in the `dar()` function, which we previously set as 5.

To assign DAR values based on regions, we must firstly utilise the `flipRanges()` function.
We can also specify the `extend_edges` option to extend the outermost ranges of each chromosome to encompass the entire chromosome.
This is useful for ensuring the assignment of DAR values to all features.
However, caution should be taken with features that exist toward the edges of a chromosome as any assigned DAR values may be less accurate.

```
dar_regions <- flipRanges(dar = dar, extend_edges = TRUE)
```

```
#> GRangesList object of length 1:
#> $group1v2
#> GRanges object with 10365 ranges and 3 metadata columns:
#>     seqnames            ranges strand | dar_origin dar_region origin_ranges
#>        <Rle>         <IRanges>  <Rle> |  <numeric>  <numeric>     <IRanges>
#>   1        1           1-13558      * |  0.0714286  0.0714286         13098
#>   1        1       10093-14083      * |  0.0000000  0.0547619         13300
#>   1        1       13098-14740      * |  0.0000000  0.1061905         13558
#>   1        1       13300-15050      * |  0.0595238  0.1204762         14083
#>   1        1       13558-15772      * |  0.4000000  0.1490476         14740
#>   .      ...               ...    ... .        ...        ...           ...
#>   1        1 59559120-59562848      * |       0.25  0.1000000      59559963
#>   1        1 59559331-59563684      * |       0.10  0.1200000      59559970
#>   1        1 59559963-59563688      * |       0.00  0.1300000      59562848
#>   1        1 59559970-59563996      * |       0.15  0.0800000      59563684
#>   1        1 59562848-59578282      * |       0.15  0.0833333      59563688
#>   -------
#>   seqinfo: 1 sequence from GRCz11 genome
```

`flipRanges()` can also be used to revert back to ranges that represent the origins.

```
identical(dar, flipRanges(dar_regions))
#> [1] TRUE
```

Now we can assign DAR values to features based on their surrounding region.

```
gene_dar_regions <- assignFeatureDar(dar = dar_regions, features = chr1_genes)
```

```
#> GRangesList object of length 1:
#> $group1v2
#> GRanges object with 1456 ranges and 3 metadata columns:
#>          seqnames            ranges strand |            gene_id      gene_name       dar
#>             <Rle>         <IRanges>  <Rle> |        <character>    <character> <numeric>
#>      [1]        1        6408-12027      - | ENSDARG00000099104          rpl24 0.0357143
#>      [2]        1       11822-16373      + | ENSDARG00000102407          cep97 0.1508929
#>      [3]        1       18716-23389      + | ENSDARG00000102097         nfkbiz 0.1864583
#>      [4]        1       25585-27255      + | ENSDARG00000099319     CU651657.1 0.1601190
#>      [5]        1       27690-34330      + | ENSDARG00000099640            eed 0.0803922
#>      ...      ...               ...    ... .                ...            ...       ...
#>   [1452]        1 59525648-59528626      - | ENSDARG00000105092     FP236157.3 0.0961310
#>   [1453]        1 59533317-59539898      + | ENSDARG00000099880            sp6 0.0961310
#>   [1454]        1 59542001-59542908      - | ENSDARG00000102872     FP236157.2 0.0961310
#>   [1455]        1 59555936-59567685      - | ENSDARG00000098899 zmp:0000001082 0.0999008
#>   [1456]        1 59569516-59571785      - | ENSDARG00000101364        wfikkn1 0.1500000
#>   -------
#>   seqinfo: 1 sequence from GRCz11 genome
```

Note that because elastic regions were defined, and `extend_edges` was set to `TRUE`, all genes in `chr1_genes` now have an assigned DAR value.

## 4.7 Moderating DGE *p*-values

Having assigned DAR values at the gene-level, these can be utilised to moderate *p*-values from differential gene expression (DGE) analysis.

Typically, under the null hypothesis, *p*-values are drawn from a uniform distribution.
However, in the context of DAR, the *p*-value distribution is observed as right-skewed.
This can be modelled using a beta distribution, where the \(\alpha\) is set to a value < 1.

This is handled with the `modP()` function, where the \(\alpha\) parameter for the beta distribution is modelled as a linear relationship with DAR.
With this technique we can directly moderate the *p*-values obtained from differential expression testing in the presence of DAR.
By default we implement a conservative approach, resulting in a reduction of false positives, without the introduction of any further false positives (i.e. significance is reduced, never increased).
For more information please refer to the `tadar` paper.

```
chr1_tt <- merge(chr1_tt, mcols(gene_dar$group1v2), sort = FALSE)
chr1_tt$darP <- modP(chr1_tt$PValue, chr1_tt$dar)
```

```
#> DataFrame with 6 rows and 7 columns
#>              gene_id   gene_name     logFC    logCPM      PValue       dar        darP
#>          <character> <character> <numeric> <numeric>   <numeric> <numeric>   <numeric>
#> 1 ENSDARG00000009026       ank2a -1.611099   7.31684 1.09498e-11 0.0762946 3.50452e-10
#> 2 ENSDARG00000005739      gpm6ba  0.699597   7.90207 3.86672e-09 0.4584656 3.38679e-02
#> 3 ENSDARG00000058287     gpalpp1 -1.037994   4.29701 9.32906e-08 0.6765873 1.98145e-01
#> 4 ENSDARG00000056381      cfap97 -0.773803   4.24842 4.20056e-07 0.7285714 2.30320e-01
#> 5 ENSDARG00000074989     sparcl1  0.766643   3.41472 6.33950e-07 0.2845938 9.48570e-04
#> 6 ENSDARG00000078733      cnnm2b  0.705368   4.06124 7.44741e-06 0.4857843 2.26978e-01
```

# 5 Visualisation

## 5.1 The trend in DAR along a chromosome

The `plotChrDar()` function produces a localised visualisation of the trend in DAR along a chromosomal axis with the option to overlay the positions of features of interest.
This allows us to compare DAR between regions and/or chromosomes, and visually assess if features may be prone eQTL artefacts.
`plotChrDar()` is a convenience function that returns a `GViz` plot consisting of an optional number of tracks.
To produce a minimal plot, this function requires the `dar` argument, expecting a `GRanges` object with DAR values in the metadata columns, and the `dar_val` argument as a character string to select the appropriate DAR values from either the `dar_origin` or `dar_region` metadata columns.
These arguments form the `DataTrack` displaying the trend in DAR.
Features of interest (e.g. a mutation locus) can be passed to the `foi` argument as a `GRanges` object and will be plotted along the `GenomeAxisTrack`.
Additional features (e.g. DE genes) can similarly be passed to the `features` argument to be plotted as a separate `AnnotationTrack`.
The `*_anno` and `*_highlight` arguments are used to select the metadata column containing feature labels, and to choose if their positions should be highlighted over the `DataTrack` displaying the trend in DAR respectively.
We can also add a title with the `title` argument.
`GViz` requires that any `GRanges` objects consist of ranges on a single chromosome, however these can be internally subset using the `chr` argument (which will also control the title of the `GenomeAxisTrack`).

```
set.seed(230822)
foi <- sample(chr1_genes, 1)
features <- sample(chr1_genes, 20)
plotChrDar(
    dar = dar$group1v2, dar_val = "region", chr = "1",
    foi = foi, foi_anno = "gene_name", foi_highlight = TRUE,
    features = features, features_anno = "gene_name", features_highlight = TRUE,
    title = "Example plot of DAR along Chromosome 1"
)
```

![](data:image/png;base64...)

## 5.2 Comparing DAR between chromosomes

It may be of use to quickly assess whether a particular chromosome is affected by high DAR more so than other chromosomes.
This is particularly relevant when a study’s experimental design causes increased DAR on a particular chromosome.
The `plotDarECDF()` function facilitates this purpose by plotting the Empirical Cumulative Distribution Function (ECDF) of DAR for each chromosome.
This function returns a `ggplot2` object, allowing us to add our own styling.
For this example we use simulated data that results in a visualisation commonly observed when experimental sample groups have been constructed based on the presence/absence of a genetic feature of interest (e.g. a mutant locus).

```
set.seed(230704)
simulate_dar <- function(n, mean) {
    vapply(
        rnorm(n = n, mean = mean),
        function(x) exp(x) / (1 + exp(x)),
        numeric(1)
    )
}
gr <- GRanges(
    paste0(rep(seq(1,25), each = 100), ":", seq(1,100)),
    dar_origin = c(simulate_dar(2400, -2), simulate_dar(100, 0.5))
)
plotDarECDF(dar = gr, dar_val = "origin") +
    theme_bw()
```

![](data:image/png;base64...)

We can also choose to highlight the chromosome of interest with the `highlight` argument.

```
plotDarECDF(dar = gr, dar_val = "origin", highlight = "25") +
    scale_colour_manual(values = c("TRUE" = "red", "FALSE" = "grey")) +
    theme_bw()
```

![](data:image/png;base64...)

# 6 Bibliography

Baer, Lachlan, Karissa Barthelson, John Postlethwait, David Adelson, Stephen Pederson, and Michael Lardelli. 2023. “Differential Allelic Representation (DAR) Identifies Candidate eQTLs and Improves Transcriptome Analysis.” Preprint. Genetics. <https://doi.org/10.1101/2023.03.02.530865>.

Cunningham, Fiona, James E Allen, Jamie Allen, Jorge Alvarez-Jarreta, M Ridwan Amode, Irina M Armean, Olanrewaju Austine-Orimoloye, et al. 2022. “Ensembl 2022.” *Nucleic Acids Research* 50 (D1): D988–D995. <https://doi.org/10.1093/nar/gkab1049>.

Gerken, Ewan, Syahida Ahmad, Karissa Barthelson, and Michael Lardelli. 2023. “Zebrafish Models of Mucopolysaccharidosis Types IIIA, B, & C Show Hyperactivity and Changes in Oligodendrocyte State.” Preprint. Genetics. <https://doi.org/10.1101/2023.08.02.550904>.

Ritchie, Matthew E., Belinda Phipson, Di Wu, Yifang Hu, Charity W. Law, Wei Shi, and Gordon K. Smyth. 2015. “Limma Powers Differential Expression Analyses for RNA-sequencing and Microarray Studies.” *Nucleic Acids Research* 43 (7): e47–e47. <https://doi.org/10.1093/nar/gkv007>.

White, Richard J, Eirinn Mackay, Stephen W Wilson, and Elisabeth M Busch-Nentwich. 2022. “Allele-Specific Gene Expression Can Underlie Altered Transcript Abundance in Zebrafish Mutants.” *eLife* 11 (February): e72825. <https://doi.org/10.7554/eLife.72825>.

# 7 Session information

```
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] tadar_1.8.0          GenomicRanges_1.62.0 Seqinfo_1.0.0
#>  [4] IRanges_2.44.0       S4Vectors_0.48.0     BiocGenerics_0.56.0
#>  [7] generics_0.1.4       limma_3.66.0         lubridate_1.9.4
#> [10] forcats_1.0.1        stringr_1.5.2        dplyr_1.1.4
#> [13] purrr_1.1.0          readr_2.1.5          tidyr_1.3.1
#> [16] tibble_3.3.0         ggplot2_4.0.0        tidyverse_2.0.0
#> [19] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] RColorBrewer_1.1-3          rstudioapi_0.17.1
#>   [3] jsonlite_2.0.0              magrittr_2.0.4
#>   [5] GenomicFeatures_1.62.0      farver_2.1.2
#>   [7] rmarkdown_2.30              BiocIO_1.20.0
#>   [9] vctrs_0.6.5                 memoise_2.0.1
#>  [11] Rsamtools_2.26.0            RCurl_1.98-1.17
#>  [13] base64enc_0.1-3             htmltools_0.5.8.1
#>  [15] S4Arrays_1.10.0             progress_1.2.3
#>  [17] curl_7.0.0                  SparseArray_1.10.0
#>  [19] Formula_1.2-5               sass_0.4.10
#>  [21] bslib_0.9.0                 htmlwidgets_1.6.4
#>  [23] Gviz_1.54.0                 httr2_1.2.1
#>  [25] cachem_1.1.0                GenomicAlignments_1.46.0
#>  [27] lifecycle_1.0.4             pkgconfig_2.0.3
#>  [29] Matrix_1.7-4                R6_2.6.1
#>  [31] fastmap_1.2.0               MatrixGenerics_1.22.0
#>  [33] digest_0.6.37               colorspace_2.1-2
#>  [35] AnnotationDbi_1.72.0        Hmisc_5.2-4
#>  [37] RSQLite_2.4.3               labeling_0.4.3
#>  [39] filelock_1.0.3              timechange_0.3.0
#>  [41] httr_1.4.7                  abind_1.4-8
#>  [43] compiler_4.5.1              bit64_4.6.0-1
#>  [45] withr_3.0.2                 htmlTable_2.4.3
#>  [47] S7_0.2.0                    backports_1.5.0
#>  [49] BiocParallel_1.44.0         DBI_1.2.3
#>  [51] biomaRt_2.66.0              rappdirs_0.3.3
#>  [53] DelayedArray_0.36.0         rjson_0.2.23
#>  [55] tools_4.5.1                 foreign_0.8-90
#>  [57] nnet_7.3-20                 glue_1.8.0
#>  [59] restfulr_0.0.16             grid_4.5.1
#>  [61] checkmate_2.3.3             cluster_2.1.8.1
#>  [63] gtable_0.3.6                BSgenome_1.78.0
#>  [65] tzdb_0.5.0                  ensembldb_2.34.0
#>  [67] data.table_1.17.8           hms_1.1.4
#>  [69] XVector_0.50.0              pillar_1.11.1
#>  [71] BiocFileCache_3.0.0         lattice_0.22-7
#>  [73] deldir_2.0-4                rtracklayer_1.70.0
#>  [75] bit_4.6.0                   biovizBase_1.58.0
#>  [77] tidyselect_1.2.1            Biostrings_2.78.0
#>  [79] knitr_1.50                  gridExtra_2.3
#>  [81] bookdown_0.45               ProtGenerics_1.42.0
#>  [83] SummarizedExperiment_1.40.0 xfun_0.53
#>  [85] Biobase_2.70.0              statmod_1.5.1
#>  [87] matrixStats_1.5.0           stringi_1.8.7
#>  [89] UCSC.utils_1.6.0            lazyeval_0.2.2
#>  [91] yaml_2.3.10                 evaluate_1.0.5
#>  [93] codetools_0.2-20            cigarillo_1.0.0
#>  [95] interp_1.1-6                BiocManager_1.30.26
#>  [97] cli_3.6.5                   rpart_4.1.24
#>  [99] jquerylib_0.1.4             Rcpp_1.1.0
#> [101] dichromat_2.0-0.1           GenomeInfoDb_1.46.0
#> [103] dbplyr_2.5.1                png_0.1-8
#> [105] XML_3.99-0.19               parallel_4.5.1
#> [107] blob_1.2.4                  prettyunits_1.2.0
#> [109] jpeg_0.1-11                 latticeExtra_0.6-31
#> [111] AnnotationFilter_1.34.0     bitops_1.0-9
#> [113] VariantAnnotation_1.56.0    scales_1.4.0
#> [115] crayon_1.5.3                rlang_1.1.6
#> [117] KEGGREST_1.50.0
```