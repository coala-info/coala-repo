# User guide: `immunotation` package

Katharina Imkeller1\*

1European Molecular Biology Laboratory, Heidelberg

\*imkeller@embl.de

#### 2025-10-30

#### Package

immunotation 1.18.0

```
library(immunotation)
```

# 1 Abstract

MHC (major histocompatibility complex) molecules are cell surface complexes that
present antigens to T cells. In humans they are encoded by the highly variable
HLA (human leukocyte antigen) genes of the hyperpolymorphic HLA locus.
More than 28,000 different HLA alleles have
been reported, with significant differences in allele frequencies between human
populations worldwide.

The package immunotation provides:

* **Conversion and nomenclature functions** for consistent annotation of HLA
  genes in typical immunoinformatics workflows such as for example the prediction
  of MHC-presented peptides in different human donors. Supported naming schemes
  include HLA alleles, serotypes, G and P groups, MACs, …
* **Automated access to the Allele Frequency Net Database** (AFND) and
  visualization of HLA allele frequencies in human populations worldwide.

# 2 Introduction

## 2.1 MHC molecules

MHC (major histocompatibility complex) molecules are a family of diverse cell
surface complexes that present antigens to T cells. MHC molecules are divided
into three classes (MHC class I, MHC class II, and non-classical MHC),
which differ in their protein subunit composition and the types of receptors
they can interact with. MHC class I molecules for example consist of one
polymorphic \(\alpha\)-chain and one invariant \(\beta\)-chain and present peptide
antigens to T cells that express the MHC-I specific co-receptor CD8.
MHC class II molecules are typically composed of one \(\alpha\)- and one
\(\beta\)-chain, which are both polymorphic. MHC class II molecules present
peptide antigens to T cells that express the MHC-II specific co-receptor CD4.

The repertoire of peptide antigens presented on MHC molecules depends on the
sequence of the genes encoded in the MHC locus of an individual. Since the
adaptive immune response to an invading pathogen relies on MHC-dependent
antigen presentation, a high diversity of MHC genes on a population level is
beneficial from an evolutionary point of view. Indeed, MHC molecules are
polygenic, which means that the MHC locus contains several different genes
encoding MHC class I and MHC class II molecules. Moreover, MHC genes are
polymorphic, which means that on a population level, multiple
variants (alleles) of each gene exist.

Several experimental techniques exist to identify the different MHC genes,
alleles and protein complexes. Protein complexes for example can be classified
into serotypes by binding of subtype-specific anti-MHC antibodies. The resulting
information on the protein complex is called the MHC serotype. Moreover, MHC
genes and alleles can
be identified by hybridization with sequence-specific probes or by sequencing
and mapping to reference databases. However, these techniques often cover only
specific regions of the MHC genes and thus do not allow a complete and
unambiguous allele identification.

The [IPD-IMGT/HLA](https://www.ebi.ac.uk/ipd/imgt/hla/) [1] and
[IPD-MHC](https://www.ebi.ac.uk/ipd/mhc/) [2] databases provide a reference of
all known MHC genes and alleles in different species. A systematic
classification of MHC genes and proteins is provided in the
[MHC restriction ontology (MRO)](https://github.com/IEDB/MRO) [3].
The annotation functions in the `immunotation` package use the classification
scheme provided by the MRO.

## 2.2 Hyperpolymorphic HLA genes in human populations

In humans, MHC molecules are encoded by highly variable HLA
(human leukocyte antigen) genes of the hyperpolymorphic HLA locus on
chromosome 6. To date, more than 28.000 different alleles have been
registered in the [IPD-IMGT/HLA](http://hla.alleles.org/nomenclature/index.html)
database [1].

### 2.2.1 Nomenclature of HLA genes

HLA genes and alleles are named according to rules defined by the
[WHO Nomenclature Committee for Factors of the HLA System](http://hla.alleles.org/nomenclature/naming.html).
The following scheme depicts the components of a complete HLA allele name.
The different components of the name are separated by “:”.

**HLA-(gene)\*(group):(protein):(coding region):(non-coding region)(suffix)**

| Term | Description | Example |
| --- | --- | --- |
| gene | HLA gene | A, B, C, DPA1, DPB1, … |
| group | group of HLA alleles with similar protein sequence (protein sequence homology) | 01 |
| protein | all HLA alleles with the same protein sequence | 01 |
| coding region | all HLA alleles with the same DNA sequence in the coding region | 01 |
| non-coding region | all HLA alleles with the same DNA sequence in the non-coding region | 01 |
| suffix | indicates changes in expression level (e.g. N - not expressed, L - low surface expression) | N |

For example:

* *HLA-A\*01:01* and *HLA-A\*01:02* - have a similar but not identical protein
  sequence. Note in this example, that not all components listed above need to be
  indicated in a given HLA name. *HLA-A\*01:01* includes all HLA alleles with
  same protein sequence, but potentially different DNA sequence.
* *HLA-A\*01:01:01* and *HLA-A\*01:01:02* - have the same protein sequence but
  slightly different DNA sequences in the coding region

Note: In a deprecated naming scheme used before 2010, the components of the
naming scheme were not separated by “:”.

### 2.2.2 Protein and gene groups

G and P groups is another naming concept, that is frequently used to groups
of HLA alleles encoding functionally similar proteins. The concept of *gene*
and *protein* int the G and P groups is independent from the naming
components concerning gene and protein which were mentioned in section
1.2.1.

[**G groups**](http://hla.alleles.org/alleles/g_groups.html) are groups of
HLA alleles that have identical **nucleotide** sequences across the exons
encoding the peptide-binding domains.

[**P groups**](http://hla.alleles.org/alleles/p_groups.html) are groups of
HLA alleles that have identical **protein** sequences in the peptide-binding
domains.

### 2.2.3 MAC (Multiple allele codes)

The National Marrow Donor Program (NMDP) uses,
[multiple allele codes (MAC)](https://bioinformatics.bethematchclinical.org/hla-resources/allele-codes/allele-code-lists/)
to facilitate the reporting and comparison of HLA alleles [4]. MACs
consist of the *gene*:*group* component of the
classical HLA naming scheme in section 1.2.1 and a
letter code (e.g. **A\*01:ATJNV**).
MACs represent groups of HLA alleles. They are useful when the HLA typing is
ambiguous and does not allow to narrow down one single allele from a list of
alleles. The `immunotation` packages provides automated access to the
[MAC conversion tools](https://hml.nmdp.org/MacUI/) provided by NMDP.

## 2.3 Variation of HLA alleles across human populations

The frequencies of individual HLA alleles varies substantially between worldwide
human populations.
The [Allele Frequency Net Database (AFND)](http://www.allelefrequencies.net/)
is a repository for immune gene frequencies in different populations
worldwide [5]. In addition to a large collection of HLA allele frequency
datasets, the database also contains datasets for allele frequencies of KIR
(Killer Cell Immunoglobulin-like Receptor) genes, MIC (Major histocompatibility
complex class I chain related) and cytokine genes. The current version of the
`immunotation` package allows automated R access to the HLA related datasets
in AFND.

The HLA frequency datasets in AFND are classified according to the following
standards:

| Criteria | Gold standard | Silver standard | Bronze standard |
| --- | --- | --- | --- |
| Allele frequency | sum to 1 ± 0.015 | sum to 1 ± 0.015 | do not sum to 1 |
| Sample size | >= 50 individuals | any | any |
| Resolution of allele frequency | four or more digits | two or more digits | other |

# 3 Scope of the package

The `immunotation` package provides tools for consistent annotation of HLA
alleles and protein complexes. The package currently has two main
functional modules:

*1. Conversion and nomenclature functions:*

* access to annotations of MHC loci, genes, protein complexes and serotypes in
  different species
* conversion between different levels of HLA annotation
* conversion between input and output of different immunoinformatics tools
* mapping between allele notation and G- or P-groups
* mapping between HLA allele groups and MAC notation

*2. Access to HLA allele frequencies:*

* automated access to datasets stored in the Allele Frequency Net Database
  ([AFND](http://www.allelefrequencies.net/))
* querying and visualization of HLA allele frequencies in human populations
  worldwide

## 3.1 Installation

Install the `immunotation` package by using BiocManager.

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("immunotation")
```

# 4 HLA genes, alleles, protein complexes and serotypes

## 4.1 Accessing information from MRO

The MRO provides consistent annotation of MHC genes and molecules in the
following species. Please note that the information for grass carp, clawed frog,
cotton-top tamarin, giant panda, sheep and marmoset is limited and might lead to
unexpected function behavior (such as return empty table).

```
get_valid_organisms()
```

```
##       NCBITaxon:10090       NCBITaxon:10116        NCBITaxon:7959
##               "mouse"                 "rat"          "grass carp"
##        NCBITaxon:8355        NCBITaxon:8839        NCBITaxon:9031
##         "clawed frog"                "duck"             "chicken"
##        NCBITaxon:9402        NCBITaxon:9483        NCBITaxon:9490
##    "black flying fox"            "marmoset"  "cotton-top tamarin"
##        NCBITaxon:9541        NCBITaxon:9544        NCBITaxon:9593
## "crab-eating macaque"      "rhesus macaque"             "gorilla"
##        NCBITaxon:9597        NCBITaxon:9598        NCBITaxon:9606
##              "bonobo"          "chimpanzee"               "human"
##        NCBITaxon:9615        NCBITaxon:9646        NCBITaxon:9685
##                 "dog"         "giant panda"                 "cat"
##        NCBITaxon:9796        NCBITaxon:9823        NCBITaxon:9913
##               "horse"                 "pig"              "cattle"
##        NCBITaxon:9940        NCBITaxon:9986
##               "sheep"              "rabbit"
```

The `retrieve_lookup_table` function allows to build a lookup table of all
annotated chains in a given species. The table specifies the locus, the gene and
the chain name.

```
df <- retrieve_chain_lookup_table(organism = "human")

DT::datatable(head(df, n=30))
```

The list of annotated human protein complexes is:

```
DT::datatable(head(human_protein_complex_table, n=30))
```

The `get_serotype` function can be used to query the serotype of encoded protein
complexes for a given HLA genotype. The allele lists represent the MHC class I
and MHC class II genotype of an exemplary donor.

```
allele_list1 <- c("A*01:01:01", "A*02:01:01",
                  "B*39:01:01", "B*07:02:01",
                  "C*08:01:01", "C*01:02:01")
allele_list2 <- c("DPA1*01:03:01", "DPA1*01:04:01",
                  "DPB1*14:01:01", "DPB1*02:01:02",
                  "DQA1*02:01:01", "DQA1*05:03",
                  "DQB1*02:02:01", "DQB1*06:09:01",
                  "DRA*01:01", "DRB1*10:01:01", "DRB1*14:02:01")
```

Retrieve the serotype of MHC class I molecules:

```
get_serotypes(allele_list1, mhc_type = "MHC-I")
```

```
## HLA-A*01:01 protein complex HLA-A*02:01 protein complex
##           "HLA-A1 serotype"           "HLA-A2 serotype"
## HLA-B*07:02 protein complex HLA-B*39:01 protein complex
##           "HLA-B7 serotype"        "HLA-B3901 serotype"
## HLA-C*01:02 protein complex HLA-C*08:01 protein complex
##          "HLA-Cw1 serotype"          "HLA-Cw8 serotype"
```

Retrieve the serotype of MHC class II molecules:
(In the current version of `immunotation` serotypes are only returned when the
complete molecule (\(\alpha\)- and \(\beta\)- chain) is annotated in MRO.)

```
get_serotypes(allele_list2, mhc_type = "MHC-II")
```

```
##  HLA-DRA*01:02/DRB1*03:01 protein complex
##                       "HLA-DR10 serotype"
## HLA-DPA1*01:03/DPB1*02:01 protein complex
##                                        NA
## HLA-DPA1*02:01/DPB1*05:01 protein complex
##                                        NA
## HLA-DQA1*03:03/DQB1*03:01 protein complex
##                        "HLA-DQ2 serotype"
```

## 4.2 Functions for mapping between different naming schemes

You can directly obtain a protein complex format that is suitable for input to
NetMHCpan and NetMHCIIpan using the `get_mhc_pan` function.

```
get_mhcpan_input(allele_list1, mhc_class = "MHC-I")
```

```
## [1] "HLA-A01:01" "HLA-A02:01" "HLA-B39:01" "HLA-B07:02" "HLA-C08:01"
## [6] "HLA-C01:02"
```

```
get_mhcpan_input(allele_list2, mhc_class = "MHC-II")
```

```
##  [1] "DRB1_1001"             "DRB1_1402"             "HLA-DQA10201-DQB10202"
##  [4] "HLA-DQA10503-DQB10202" "HLA-DQA10201-DQB10609" "HLA-DQA10503-DQB10609"
##  [7] "HLA-DPA10103-DPB11401" "HLA-DPA10104-DPB11401" "HLA-DPA10103-DPB10201"
## [10] "HLA-DPA10104-DPB10201"
```

## 4.3 Retrieving G and P groups

For every allele in the list return the corresponding G group. If the allele is
not part of a G group, the original allele name is returned.

```
get_G_group(allele_list2)
```

```
##    DPA1*01:03:01    DPA1*01:04:01    DPB1*14:01:01    DPB1*02:01:02
## "DPA1*01:03:01G"  "DPA1*01:04:01" "DPB1*14:01:01G" "DPB1*02:01:02G"
##    DQA1*02:01:01       DQA1*05:03    DQB1*02:02:01    DQB1*06:09:01
## "DQA1*02:01:01G"     "DQA1*05:03"  "DQB1*02:02:01" "DQB1*06:09:01G"
##        DRA*01:01    DRB1*10:01:01    DRB1*14:02:01
##      "DRA*01:01" "DRB1*10:01:01G" "DRB1*14:02:01G"
```

For every allele in the list return the corresponding P group. If the allele is
not part of a P group, the original allele name is returned.

```
get_P_group(allele_list1)
```

```
## A*01:01:01 A*02:01:01 B*39:01:01 B*07:02:01 C*08:01:01 C*01:02:01
## "A*01:01P" "A*02:01P" "B*39:01P" "B*07:02P" "C*08:01P" "C*01:02P"
```

## 4.4 Encoding and decoding MAC

Encode a list of alleles into MAC using the `encode_MAC` function.

```
allele_list3 <- c("A*01:01:01", "A*02:01:01", "A*03:01")
encode_MAC(allele_list3)
```

```
## [1] "A*01:ATJNV"
```

Decode a MAC into a list of alleles using the `decode_MAC` function.

```
MAC1 <- "A*01:AYMG"
decode_MAC(MAC1)
```

```
## [1] "A*01:11N/A*01:32"
```

# 5 Functions related to worldwide population frequencies

## 5.1 allele frequencies (given allele in several populations)

**Example 1:** Querying the frequency of allele A\*02:01 in all populations with
more than 10,000 individuals and fulfilling the gold standard.

```
sel1 <- query_allele_frequencies(hla_selection = "A*02:01",
                                hla_sample_size_pattern = "bigger_than",
                                hla_sample_size = 10000,
                                standard="g")

DT::datatable(sel1)
```

```
sel1b <- query_allele_frequencies(hla_selection = "A*01:01",
                                hla_ethnic = "Asian")

DT::datatable(sel1b)
```

```
hla_selection <- build_allele_group("A*01:02")

sel1 <- query_allele_frequencies(hla_selection = hla_selection,
                                hla_sample_size_pattern = "bigger_than",
                                hla_sample_size = 200,
                                standard="g")
```

**Example 2:** Querying haplotype frequency

```
haplotype_alleles <- c("A*02:01", "B*", "C*")
df <- query_haplotype_frequencies(hla_selection = haplotype_alleles,
                            hla_region = "Europe")

DT::datatable(df)
```

**Example 3:** Querying the frequencies of alleles within the HLA-B locus for
population “Peru Lamas City Lama” with population\_id 1986. If you are not sure
which population\_id you should use, we recommend to search your population of
interest in the *Population* section of the Allele Frequency Net Database and
extract the population id from the url (last 4 digits).

```
sel2 <- query_allele_frequencies(hla_locus = "B", hla_population = 1986)

DT::datatable(sel2)
```

```
sel2a <- query_allele_frequencies(hla_locus = "B", hla_population = 3089)

DT::datatable(sel2a)
```

Use the `plot_allele_frequency` function to visualize the frequencies of a given
allele on a world map. The input of `plot_allele_frequency` is a data table that
can be produced using the `query_allele_frequencies` function.

```
plot_allele_frequency(sel1)
```

```
## Warning in assemble_frequency_lat_long_df(allele_frequency): NAs introduced by
## coercion
```

![](data:image/png;base64...)

# 6 Querying population metainformation

**Example 3:** Query the metainformation concerning population “Peru Lamas City
Lama” (population\_id 1986). The webpage concerning the queried information for
population Peru Lamas City Lama (1986) can be found here:
<http://www.allelefrequencies.net/pop6001c.asp?pop_id=1986>

```
sel3 <- query_population_detail(1986)

DT::datatable(sel3, options = list(scrollX = TRUE))
```

**Example 4:** Query the metainformation concerning the populations that were
listed in the table returned by Example 1

```
sel4 <- query_population_detail(as.numeric(sel1$population_id))

# only select the first 5 columns to display in table
DT::datatable(sel4[1:5], options = list(scrollX = TRUE))
```

# 7 References

# Appendix

[1] Robinson J, Barker DJ, Georgiou X et al. IPD-IMGT/HLA Database. Nucleic
Acids Research (2020)

[2] Maccari G, Robinson J, Ballingall K et al. IPD-MHC 2.0: an improved
inter-species database for the study of the major histocompatibility complex.
Nucleic Acids Research (2017)

[3] Vita R, Overton JA, Seymour E et al. An ontology for major
histocompatibility restriction. J Biomed Semant (2016).

[4] Milius RP, Mack SJ, Hollenbach JA et al. Genotype List String: a grammar for
describing HLA and KIR genotyping results in a text string.
Tissue Antigens (2013).

[5] Gonzalez-Galarza FF, McCabe A, Santos EJ at al. Allele frequency net
database (AFND) 2020 update: gold-standard data classification, open access
genotype data and new query tools. Nucleic Acid Research (2020).

# A Session Information

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
## [1] immunotation_1.18.0 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.10         generics_0.1.4      tidyr_1.3.1
##  [4] xml2_1.4.1          stringi_1.8.7       digest_0.6.37
##  [7] magrittr_2.0.4      RColorBrewer_1.1-3  evaluate_1.0.5
## [10] grid_4.5.1          bookdown_0.45       fastmap_1.2.0
## [13] maps_3.4.3          jsonlite_2.0.0      processx_3.8.6
## [16] ontologyIndex_2.12  chromote_0.5.1      tinytex_0.57
## [19] ps_1.9.1            promises_1.4.0      BiocManager_1.30.26
## [22] httr_1.4.7          rvest_1.0.5         purrr_1.1.0
## [25] selectr_0.4-2       scales_1.4.0        crosstalk_1.2.2
## [28] jquerylib_0.1.4     cli_3.6.5           rlang_1.1.6
## [31] withr_3.0.2         cachem_1.1.0        yaml_2.3.10
## [34] otel_0.2.0          tools_4.5.1         dplyr_1.1.4
## [37] ggplot2_4.0.0       DT_0.34.0           curl_7.0.0
## [40] vctrs_0.6.5         R6_2.6.1            magick_2.9.0
## [43] lifecycle_1.0.4     stringr_1.5.2       htmlwidgets_1.6.4
## [46] pkgconfig_2.0.3     gtable_0.3.6        bslib_0.9.0
## [49] pillar_1.11.1       later_1.4.4         glue_1.8.0
## [52] Rcpp_1.1.0          xfun_0.53           tibble_3.3.0
## [55] tidyselect_1.2.1    dichromat_2.0-0.1   knitr_1.50
## [58] farver_2.1.2        htmltools_0.5.8.1   websocket_1.4.4
## [61] labeling_0.4.3      rmarkdown_2.30      compiler_4.5.1
## [64] S7_0.2.0
```