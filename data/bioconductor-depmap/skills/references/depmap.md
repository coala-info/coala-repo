# The depmap data

Theo Killian and Laurent Gatto1

1Computational Biology, UCLouvain

#### 2025-11-18

# 1 Introduction

The `depmap` package aims to provide a reproducible research framework
to cancer dependency data described by [Tsherniak, Aviad, et
al. “Defining a cancer dependency map.” Cell 170.3 (2017):
564-576.](https://www.ncbi.nlm.nih.gov/pubmed/28753430). The data
found in the
[depmap](https://bioconductor.org/packages/devel/data/experiment/html/depmap.html)
package has been formatted to facilitate the use of common R packages
such as `dplyr` and `ggplot2`. We hope that this package will allow
researchers to more easily mine, explore and visually illustrate
dependency data taken from the Depmap cancer genomic dependency study.

# 2 Installation instructions

To install
[depmap](https://bioconductor.org/packages/devel/data/experiment/html/depmap.html),
the
[BiocManager](https://cran.r-project.org/web/packages/BiocManager/index.html)
Bioconductor Project Package Manager is required. If
[BiocManager](https://cran.r-project.org/web/packages/BiocManager/index.html)
is not already installed, it will need to be done so beforehand. Type
(within R) install.packages(“BiocManager”) (This needs to be done just
once.)

```
install.packages("BiocManager")
BiocManager::install("depmap")
```

The `depmap` package fully depends on the `ExperimentHub` Bioconductor
package, which allows the data accessed in this package to be stored
and retrieved from the cloud.

```
library("depmap")
library("ExperimentHub")
```

# 3 Tidy depmap data

The
[depmap](https://bioconductor.org/packages/devel/data/experiment/html/depmap.html)
package currently contains eight datasets available through
`ExperimentHub`.

The data found in this R package has been converted from a “wide”
format `.csv` file to “long” format .rda file. None of the values
taken from the original datasets have been changed, although the
columns have been re-arranged. Descriptions of the changes made are
described under the `Details` section after querying the relevant
dataset.

```
## create ExperimentHub query object
eh <- ExperimentHub()
query(eh, "depmap")
```

```
## ExperimentHub with 82 records
## # snapshotDate(): 2025-10-07
## # $dataprovider: Broad Institute
## # $species: Homo sapiens
## # $rdataclass: tibble
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH2260"]]'
##
##            title
##   EH2260 | rnai_19Q1
##   EH2261 | crispr_19Q1
##   EH2262 | copyNumber_19Q1
##   EH2263 | RPPA_19Q1
##   EH2264 | TPM_19Q1
##   ...      ...
##   EH7555 | copyNumber_22Q2
##   EH7556 | TPM_22Q2
##   EH7557 | mutationCalls_22Q2
##   EH7558 | metadata_22Q2
##   EH7559 | achilles_22Q2
```

Each dataset has a `ExperimentHub` accession number, (e.g. *EH2260*
refers to the `rnai` dataset from the 19Q1 release).

## 3.1 RNA inference knockout data

The `rnai` dataset contains the combined genetic dependency data for
RNAi - induced gene knockdown for select genes and cancer cell
lines. This data corresponds to the
`D2_combined_genetic_dependency_scores.csv` file.

Specific `rnai` datasets can be accessed, such as `rnai_19Q1` by EH number.

```
eh[["EH2260"]]
```

The most recent `rnai` dataset can be automatically loaded into R by
using the `depmap_rnai` function.

```
depmap::depmap_rnai()
```

```
## see ?depmap and browseVignettes('depmap') for documentation
```

```
## downloading 1 resources
```

```
## retrieving 1 resource
```

```
## loading from cache
```

```
## # A tibble: 12,324,008 × 6
##    gene                cell_line        dependency entrez_id gene_name depmap_id
##    <chr>               <chr>                 <dbl>     <int> <chr>     <chr>
##  1 A1BG (1)            127399_SOFT_TIS…     NA             1 A1BG      ACH-0012…
##  2 NAT2 (10)           127399_SOFT_TIS…     NA            10 NAT2      ACH-0012…
##  3 ADA (100)           127399_SOFT_TIS…     NA           100 ADA       ACH-0012…
##  4 CDH2 (1000)         127399_SOFT_TIS…     -0.195      1000 CDH2      ACH-0012…
##  5 AKT3 (10000)        127399_SOFT_TIS…     -0.256     10000 AKT3      ACH-0012…
##  6 MED6 (10001)        127399_SOFT_TIS…     -0.174     10001 MED6      ACH-0012…
##  7 NR2E3 (10002)       127399_SOFT_TIS…     -0.140     10002 NR2E3     ACH-0012…
##  8 NAALAD2 (10003)     127399_SOFT_TIS…     NA         10003 NAALAD2   ACH-0012…
##  9 DUXB (100033411)    127399_SOFT_TIS…     NA     100033411 DUXB      ACH-0012…
## 10 PDZK1P1 (100034743) 127399_SOFT_TIS…     NA     100034743 PDZK1P1   ACH-0012…
## # ℹ 12,323,998 more rows
```

## 3.2 CRISPR-Cas9 knockout data

The `crispr` dataset contains the (batch corrected CERES inferred gene
effect) CRISPR-Cas9 knockout data of select genes and cancer cell
lines. This data corresponds to the `gene_effect_corrected.csv` file.

Specific `crispr` datasets can be accessed, such as `crispr_19Q1` by
EH number.

```
eh[["EH2261"]]
```

The most recent `crispr` dataset can be automatically loaded into R by
using the `depmap_crispr` function.

```
depmap::depmap_crispr()
```

```
## see ?depmap and browseVignettes('depmap') for documentation
```

```
## loading from cache
```

```
## # A tibble: 18,881,196 × 6
##    depmap_id  gene     dependency entrez_id gene_name cell_line
##    <chr>      <chr>         <dbl>     <int> <chr>     <chr>
##  1 ACH-000001 A1BG (1)    -0.135          1 A1BG      NIHOVCAR3_OVARY
##  2 ACH-000004 A1BG (1)     0.0819         1 A1BG      HEL_HAEMATOPOIETIC_AND_LY…
##  3 ACH-000005 A1BG (1)    -0.0942         1 A1BG      HEL9217_HAEMATOPOIETIC_AN…
##  4 ACH-000007 A1BG (1)    -0.0115         1 A1BG      LS513_LARGE_INTESTINE
##  5 ACH-000009 A1BG (1)    -0.0508         1 A1BG      C2BBE1_LARGE_INTESTINE
##  6 ACH-000011 A1BG (1)     0.0918         1 A1BG      253J_URINARY_TRACT
##  7 ACH-000012 A1BG (1)    -0.147          1 A1BG      HCC827_LUNG
##  8 ACH-000013 A1BG (1)    -0.0592         1 A1BG      ONCODG1_OVARY
##  9 ACH-000014 A1BG (1)    -0.0348         1 A1BG      HS294T_SKIN
## 10 ACH-000015 A1BG (1)    -0.204          1 A1BG      NCIH1581_LUNG
## # ℹ 18,881,186 more rows
```

## 3.3 WES copy number data

The `copyNumber` dataset contains the WES copy number data, relating
to the numerical log-fold copy number change measured against the
baseline copy number of select genes and cell lines. This dataset
corresponds to the `public_19Q1_gene_cn.csv`

Specific `copyNumber` datasets can be accessed, such as
`copyNumber_19Q1` by EH number.

```
eh[["EH2262"]]
```

The most recent `copyNumber` dataset can be automatically loaded into
R by using the `depmap_copyNumber` function.

```
depmap::depmap_copyNumber()
```

```
## see ?depmap and browseVignettes('depmap') for documentation
```

```
## downloading 1 resources
```

```
## retrieving 1 resource
```

```
## loading from cache
```

```
## # A tibble: 44,799,888 × 6
##    depmap_id  gene            log_copy_number entrez_id gene_name cell_line
##    <chr>      <chr>                     <dbl>     <int> <chr>     <chr>
##  1 ACH-000267 DDX11L1 (84771)           1.15      84771 DDX11L1   HDLM2_HAEMATO…
##  2 ACH-001408 DDX11L1 (84771)           1.04      84771 DDX11L1   UMUC14_URINAR…
##  3 ACH-000617 DDX11L1 (84771)           0.762     84771 DDX11L1   OVCAR4_OVARY
##  4 ACH-002123 DDX11L1 (84771)           1.14      84771 DDX11L1   H2369_PLEURA
##  5 ACH-000519 DDX11L1 (84771)           1.01      84771 DDX11L1   PEER_HAEMATOP…
##  6 ACH-000750 DDX11L1 (84771)           0.711     84771 DDX11L1   LOXIMVI_SKIN
##  7 ACH-000544 DDX11L1 (84771)           0.981     84771 DDX11L1   OE21_OESOPHAG…
##  8 ACH-001214 DDX11L1 (84771)           1.05      84771 DDX11L1   U138MG_CENTRA…
##  9 ACH-002223 DDX11L1 (84771)           0.630     84771 DDX11L1   D245MG_CENTRA…
## 10 ACH-000713 DDX11L1 (84771)           0.823     84771 DDX11L1   CAOV3_OVARY
## # ℹ 44,799,878 more rows
```

## 3.4 CCLE Reverse Phase Protein Array data

The `RPPA` dataset contains the CCLE Reverse Phase Protein Array
(RPPA) data which corresponds to the `CCLE_RPPA_20180123.csv` file.

Specific `RPPA` datasets can be accessed, such as `RPPA_19Q1` by EH
number.

```
eh[["EH2263"]]
```

The most recent `RPPA` dataset can be automatically loaded into R by
using the `depmap_RPPA` function.

```
depmap::depmap_RPPA()
```

```
## see ?depmap and browseVignettes('depmap') for documentation
```

```
## downloading 1 resources
```

```
## retrieving 1 resource
```

```
## loading from cache
```

```
## # A tibble: 192,386 × 4
##    cell_line                                 antibody    expression depmap_id
##    <chr>                                     <chr>            <dbl> <chr>
##  1 DMS53_LUNG                                14-3-3_beta    -0.105  ACH-000698
##  2 SW1116_LARGE_INTESTINE                    14-3-3_beta     0.359  ACH-000489
##  3 NCIH1694_LUNG                             14-3-3_beta     0.0287 ACH-000431
##  4 P3HR1_HAEMATOPOIETIC_AND_LYMPHOID_TISSUE  14-3-3_beta     0.120  ACH-000707
##  5 HUT78_HAEMATOPOIETIC_AND_LYMPHOID_TISSUE  14-3-3_beta    -0.269  ACH-000509
##  6 UMUC3_URINARY_TRACT                       14-3-3_beta    -0.171  ACH-000522
##  7 HOS_BONE                                  14-3-3_beta    -0.0253 ACH-000613
##  8 HUNS1_HAEMATOPOIETIC_AND_LYMPHOID_TISSUE  14-3-3_beta    -0.170  ACH-000829
##  9 AML193_HAEMATOPOIETIC_AND_LYMPHOID_TISSUE 14-3-3_beta     0.0819 ACH-000557
## 10 RVH421_SKIN                               14-3-3_beta     0.222  ACH-000614
## # ℹ 192,376 more rows
```

## 3.5 CCLE RNAseq gene expression data

The `TPM` dataset contains the CCLE RNAseq gene expression data. This
shows expression data only for protein coding genes (using scale
log2(TPM+1)). This data corresponds to the `CCLE_depMap_19Q1_TPM.csv`
file.

Specific `TPM` datasets can be accessed, such as `TPM_19Q1` by EH number.

```
eh[["EH2264"]]
```

The `TPM` dataset can also be accessed by using the `depmap_TPM` function.

```
depmap::depmap_TPM()
```

```
## see ?depmap and browseVignettes('depmap') for documentation
```

```
## loading from cache
```

```
## # A tibble: 27,024,726 × 6
##    depmap_id  gene          rna_expression entrez_id gene_name cell_line
##    <chr>      <chr>                  <dbl>     <int> <chr>     <chr>
##  1 ACH-001113 TSPAN6 (7105)         4.33        7105 TSPAN6    LC1SQSF_LUNG
##  2 ACH-001289 TSPAN6 (7105)         4.57        7105 TSPAN6    COGAR359_SOFT_TI…
##  3 ACH-001339 TSPAN6 (7105)         3.15        7105 TSPAN6    COLO794_SKIN
##  4 ACH-001538 TSPAN6 (7105)         5.09        7105 TSPAN6    KKU213_BILIARY_T…
##  5 ACH-000242 TSPAN6 (7105)         6.73        7105 TSPAN6    RT4_URINARY_TRACT
##  6 ACH-000708 TSPAN6 (7105)         4.27        7105 TSPAN6    SNU283_LARGE_INT…
##  7 ACH-000327 TSPAN6 (7105)         3.34        7105 TSPAN6    NCIH1395_LUNG
##  8 ACH-000233 TSPAN6 (7105)         0.0566      7105 TSPAN6    DEL_HAEMATOPOIET…
##  9 ACH-000461 TSPAN6 (7105)         4.02        7105 TSPAN6    SNU1196_BILIARY_…
## 10 ACH-000705 TSPAN6 (7105)         4.41        7105 TSPAN6    LC1F_LUNG
## # ℹ 27,024,716 more rows
```

## 3.6 Cancer cell lines

The `metadata` dataset contains the metadata about all of the cancer
cell lines. It corresponds to the `depmap_19Q1_cell_lines.csv` file.

Specific `metadata` datasets can be accessed, such as `metadata_19Q1`
by EH number.

```
eh[["EH2266"]]
```

The most recent `metadata` dataset can be automatically loaded into R by using
the `depmap_metadata` function.

```
depmap::depmap_metadata()
```

```
## see ?depmap and browseVignettes('depmap') for documentation
```

```
## loading from cache
```

```
## # A tibble: 1,840 × 29
##    depmap_id  cell_line_name stripped_cell_line_name cell_line aliases cosmic_id
##    <chr>      <chr>          <chr>                   <chr>     <chr>       <dbl>
##  1 ACH-000016 SLR 21         SLR21                   SLR21_KI… <NA>           NA
##  2 ACH-000032 MHH-CALL-3     MHHCALL3                MHHCALL3… <NA>           NA
##  3 ACH-000033 NCI-H1819      NCIH1819                NCIH1819… <NA>           NA
##  4 ACH-000043 Hs 895.T       HS895T                  HS895T_F… <NA>           NA
##  5 ACH-000049 HEK TE         HEKTE                   HEKTE_KI… <NA>           NA
##  6 ACH-000051 TE 617.T       TE617T                  TE617T_S… <NA>           NA
##  7 ACH-000064 SALE           SALE                    SALE_LUNG <NA>           NA
##  8 ACH-000068 REC-1          REC1                    REC1_HAE… <NA>           NA
##  9 ACH-000071 <NA>           HS706T                  HS706T_B… <NA>           NA
## 10 ACH-000076 NCO2           NCO2                    NCO2_HAE… <NA>           NA
## # ℹ 1,830 more rows
## # ℹ 23 more variables: sex <chr>, source <chr>, RRID <chr>,
## #   WTSI_master_cell_ID <dbl>, sample_collection_site <chr>,
## #   primary_or_metastasis <chr>, primary_disease <chr>, subtype_disease <chr>,
## #   age <chr>, sanger_id <chr>, additional_info <chr>, lineage <chr>,
## #   lineage_subtype <chr>, lineage_sub_subtype <chr>,
## #   lineage_molecular_subtype <chr>, default_growth_pattern <chr>, …
```

## 3.7 Mutation calls

The `mutationCalls` dataset contains all merged mutation calls (coding
region, germline filtered) found in the depmap dependency study. This
dataset corresponds with the `depmap_19Q1_mutation_calls.csv` file.

Specific `mutationCalls` datasets can be accessed, such as
`mutationCalls_19Q1` by EH number.

```
eh[["EH2265"]]
```

The most recent `mutationCalls` dataset can be automatically loaded into R by
using the `depmap_mutationCalls` function.

```
depmap::depmap_mutationCalls()
```

```
## see ?depmap and browseVignettes('depmap') for documentation
```

```
## downloading 1 resources
```

```
## retrieving 1 resource
```

```
## loading from cache
```

```
## # A tibble: 1,235,466 × 32
##    depmap_id  gene_name entrez_id ncbi_build chromosome start_pos end_pos strand
##    <chr>      <chr>         <dbl>      <dbl> <chr>          <dbl>   <dbl> <chr>
##  1 ACH-000001 VPS13D        55187         37 1           12359347  1.24e7 +
##  2 ACH-000001 AADACL4      343066         37 1           12726308  1.27e7 +
##  3 ACH-000001 IFNLR1       163702         37 1           24484172  2.45e7 +
##  4 ACH-000001 TMEM57        55219         37 1           25785018  2.58e7 +
##  5 ACH-000001 ZSCAN20        7579         37 1           33954141  3.40e7 +
##  6 ACH-000001 POU3F1         5453         37 1           38512139  3.85e7 +
##  7 ACH-000001 MAST2         23139         37 1           46498028  4.65e7 +
##  8 ACH-000001 GBP4         115361         37 1           89657103  8.97e7 +
##  9 ACH-000001 VAV3          10451         37 1          108247170  1.08e8 +
## 10 ACH-000001 NBPF20    100288142         37 1          148346689  1.48e8 +
## # ℹ 1,235,456 more rows
## # ℹ 24 more variables: var_class <chr>, var_type <chr>, ref_allele <chr>,
## #   alt_allele <chr>, dbSNP_RS <chr>, dbSNP_val_status <chr>,
## #   genome_change <chr>, annotation_trans <chr>, cDNA_change <chr>,
## #   codon_change <chr>, protein_change <chr>, is_deleterious <lgl>,
## #   is_tcga_hotspot <lgl>, tcga_hsCnt <dbl>, is_cosmic_hotspot <lgl>,
## #   cosmic_hsCnt <dbl>, ExAC_AF <dbl>, var_annotation <chr>, …
```

## 3.8 Drug Sensitivity

The `drug_sensitivity` dataset contains dependency data for cancer
cell lines treated with various compounds. This dataset corresponds
with the `primary_replicate_collapsed_logfold_change.csv` file.

Specific `drug_sensitivity` datasets can be accessed, such as
`drug_sensitivity_19Q3` by EH number.

```
 eh[["EH3087"]]
```

The most recent `drug_sensitivity` dataset can be automatically loaded
into R by using the `depmap_drug_sensitivity` function.

```
depmap::depmap_drug_sensitivity()
```

```
## see ?depmap and browseVignettes('depmap') for documentation
```

```
## downloading 1 resources
```

```
## retrieving 1 resource
```

```
## loading from cache
```

```
## # A tibble: 2,708,508 × 14
##    depmap_id  cell_line compound dependency broad_id name   dose screen_id moa
##    <chr>      <chr>     <chr>         <dbl> <chr>    <chr> <dbl> <chr>     <chr>
##  1 ACH-000001 NIHOVCAR… BRD-A00…    -0.0156 BRD-A00… 8-br…   2.5 HTS       PKA …
##  2 ACH-000007 LS513_LA… BRD-A00…    -0.0957 BRD-A00… 8-br…   2.5 HTS       PKA …
##  3 ACH-000008 A101D_SK… BRD-A00…     0.379  BRD-A00… 8-br…   2.5 HTS       PKA …
##  4 ACH-000010 NCIH2077… BRD-A00…     0.119  BRD-A00… 8-br…   2.5 HTS       PKA …
##  5 ACH-000011 253J_URI… BRD-A00…     0.145  BRD-A00… 8-br…   2.5 HTS       PKA …
##  6 ACH-000012 HCC827_L… BRD-A00…     0.103  BRD-A00… 8-br…   2.5 HTS       PKA …
##  7 ACH-000013 ONCODG1_… BRD-A00…     0.353  BRD-A00… 8-br…   2.5 HTS       PKA …
##  8 ACH-000014 HS294T_S… BRD-A00…     0.128  BRD-A00… 8-br…   2.5 HTS       PKA …
##  9 ACH-000015 NCIH1581… BRD-A00…     0.167  BRD-A00… 8-br…   2.5 HTS       PKA …
## 10 ACH-000018 T24_URIN… BRD-A00…     0.832  BRD-A00… 8-br…   2.5 HTS       PKA …
## # ℹ 2,708,498 more rows
## # ℹ 5 more variables: target <chr>, disease_area <chr>, indication <chr>,
## #   smiles <chr>, phase <chr>
```

## 3.9 Proteomic

The `proteomic` dataset contains normalized quantitative profiling of
proteins of cancer cell lines by mass spectrometry. This dataset
corresponds with the
`https://gygi.med.harvard.edu/sites/gygi.med.harvard.edu/files/documents/protein_quant_current_normalized.csv.gz`
file.

Specific `proteomic` datasets can be accessed, such as
`proteomic_20Q2` by EH number.

```
eh[["EH3459"]]
```

The most recent `proteomic` dataset can be automatically loaded into R by
using the `depmap_proteomic` function.

```
depmap::depmap_proteomic()
```

```
## see ?depmap and browseVignettes('depmap') for documentation
```

```
## loading from cache
```

```
## # A tibble: 4,821,390 × 12
##    depmap_id  gene_name entrez_id protein    protein_expression protein_id desc
##    <chr>      <chr>         <dbl> <chr>                   <dbl> <chr>      <chr>
##  1 ACH-000849 SLC12A2        6558 MDAMB468_…            2.11    sp|P55011… S12A…
##  2 ACH-000441 SLC12A2        6558 SH4_SKIN_…            0.0705  sp|P55011… S12A…
##  3 ACH-000248 SLC12A2        6558 AU565_BRE…           -0.464   sp|P55011… S12A…
##  4 ACH-000684 SLC12A2        6558 KMRC1_KID…           -0.884   sp|P55011… S12A…
##  5 ACH-000856 SLC12A2        6558 CAL51_BRE…            0.789   sp|P55011… S12A…
##  6 ACH-000348 SLC12A2        6558 RPMI7951_…           -0.912   sp|P55011… S12A…
##  7 ACH-000062 SLC12A2        6558 RERFLCMS_…            0.729   sp|P55011… S12A…
##  8 ACH-000650 SLC12A2        6558 IGR37_SKI…           -0.658   sp|P55011… S12A…
##  9 ACH-000484 SLC12A2        6558 VMRCRCW_K…           -1.15    sp|P55011… S12A…
## 10 ACH-000625 SLC12A2        6558 HEP3B217_…            0.00882 sp|P55011… S12A…
## # ℹ 4,821,380 more rows
## # ℹ 5 more variables: group_id <dbl>, uniprot <chr>, uniprot_acc <chr>,
## #   TenPx <chr>, cell_line <chr>
```

## 3.10 Repackaged data source

If desired, the original data from which the
[depmap](https://bioconductor.org/packages/depmap) package were
derived from can be downloaded from the [Broad
Institute](https://depmap.org/portal/download/) website. The
instructions on how to download these files and how the data was
transformed and loaded into the
[depmap](https://bioconductor.org/packages/depmap) package can be
found in the `make_data.R` file found in `./inst/scripts`. (It should
be noted that the original uncompressed *.csv* files are > 1.5GB in
total and take a moderate amount of time to download remotely.)

# 4 Original depmap data

In addition to the re-packaged files, the package also allows to
download any of the original files provided by the [DepMap project on
Figshare](https://figshare.com/authors/Broad_DepMap/5514062).

A list of all the datasets is available with the `dmsets()` function:

```
dmsets()
```

```
## # A tibble: 27 × 5
##    title              dataset_id n_files url                          data
##    <chr>                   <int>   <int> <chr>                        <list>
##  1 DepMap 24Q2 Public   25880521      66 https://figshare.com/articl… <DpMpDtst>
##  2 DepMap 23Q4 Public   24667905      56 https://figshare.com/articl… <DpMpDtst>
##  3 DepMap 23Q2 Public   22765112      52 https://figshare.com/articl… <DpMpDtst>
##  4 DepMap 22Q4 Public   21637199      47 https://figshare.com/articl… <DpMpDtst>
##  5 DepMap 22Q2 Public   19700056      42 https://figshare.com/articl… <DpMpDtst>
##  6 DepMap 22Q1 Public   19139906      42 https://figshare.com/articl… <DpMpDtst>
##  7 DepMap 21Q4 Public   16924132      40 https://figshare.com/articl… <DpMpDtst>
##  8 DepMap 21Q2 Public   14541774      44 https://figshare.com/articl… <DpMpDtst>
##  9 DepMap 21Q3 Public   15160110      46 https://figshare.com/articl… <DpMpDtst>
## 10 DepMap 21Q1 Public   13681534      37 https://figshare.com/articl… <DpMpDtst>
## # ℹ 17 more rows
```

We could check what datasets from any quarter of 2020 are available by
searching for `"20Q"` in the datasets titles:

```
library(tidyverse)
dmsets() |>
    filter(grepl("20Q", title))
```

```
## # A tibble: 4 × 5
##   title                          dataset_id n_files url               data
##   <chr>                               <int>   <int> <chr>             <list>
## 1 DepMap 20Q4 Public               13237076      31 https://figshare… <DpMpDtst>
## 2 DepMap 20Q2 Public               12280541      24 https://figshare… <DpMpDtst>
## 3 DepMap 20Q1 Public               11791698      24 https://figshare… <DpMpDtst>
## 4 PRISM Repurposing 20Q2 Dataset   20564034      16 https://figshare… <DpMpDtst>
```

Let’s focus on the *PRISM Repurposing 20Q2 Dataset* dataset, with
identifier `20564034`.

A list of all the files is available with the `dmfiles()` function:

```
dmfiles()
```

```
## # A tibble: 772 × 7
##    dataset_id       id name                     size download_url md5   mimetype
##         <int>    <int> <chr>                   <dbl> <chr>        <chr> <chr>
##  1   25880521 46486180 AchillesCommonEssenti… 1.70e4 https://ndo… 1cbf… text/pl…
##  2   25880521 46486192 AchillesHighVarianceG… 7.07e3 https://ndo… 3ac0… text/pl…
##  3   25880521 46486201 AchillesNonessentialC… 1.15e4 https://ndo… 9b21… text/pl…
##  4   25880521 46486213 AchillesScreenQCRepor… 3.19e5 https://ndo… 678c… text/pl…
##  5   25880521 46486222 AchillesSequenceQCRep… 4.50e5 https://ndo… 13a8… text/pl…
##  6   25880521 46486231 AvanaGuideMap.csv      1.60e7 https://ndo… b694… text/pl…
##  7   25880521 46486252 AvanaLogfoldChange.csv 3.34e9 https://ndo… ab2f… text/pl…
##  8   25880521 46488025 AvanaRawReadcounts.csv 1.02e9 https://ndo… c902… text/pl…
##  9   25880521 46489021 CRISPRGeneDependency.… 4.12e8 https://ndo… 6aaa… applica…
## 10   25880521 46489063 CRISPRGeneEffect.csv   4.19e8 https://ndo… d10d… applica…
## # ℹ 762 more rows
```

If we want to find all files from the *PRISM Repurposing 20Q2 Dataset*
identified above, we could filter all files with its `dataset_id`:

```
dmfiles() |>
    filter(dataset_id == 20564034)
```

```
## # A tibble: 16 × 7
##    dataset_id       id name                     size download_url md5   mimetype
##         <int>    <int> <chr>                   <dbl> <chr>        <chr> <chr>
##  1   20564034 36794562 prism-repurposing-20q… 1.92e8 https://ndo… d5c2… text/pl…
##  2   20564034 36794565 prism-repurposing-20q… 4.68e4 https://ndo… 580b… text/pl…
##  3   20564034 36794571 prism-repurposing-20q… 1.27e8 https://ndo… 854c… text/pl…
##  4   20564034 36794574 prism-repurposing-20q… 7.73e7 https://ndo… 793d… text/pl…
##  5   20564034 36794577 prism-repurposing-20q… 6.20e3 https://ndo… 88f8… text/pl…
##  6   20564034 36794580 prism-repurposing-20q… 4.67e7 https://ndo… 8f3e… text/pl…
##  7   20564034 36794583 prism-repurposing-20q… 1.31e6 https://ndo… 1e69… text/pl…
##  8   20564034 36794586 prism-repurposing-20q… 5.72e6 https://ndo… f1a2… text/pl…
##  9   20564034 36794589 prism-repurposing-20q… 8.47e4 https://ndo… 4c3a… text/pl…
## 10   20564034 36794595 prism-repurposing-20q… 2.90e8 https://ndo… eb0c… text/pl…
## 11   20564034 36794607 prism-repurposing-20q… 3.08e8 https://ndo… 5140… text/pl…
## 12   20564034 36794610 prism-repurposing-20q… 3.32e5 https://ndo… 8a48… text/pl…
## 13   20564034 36794613 prism-repurposing-20q… 8.05e3 https://ndo… 4741… text/pl…
## 14   20564034 36794616 prism-repurposing-20q… 1.15e8 https://ndo… d89c… text/pl…
## 15   20564034 36794619 prism-repurposing-20q… 4.28e6 https://ndo… 162d… text/pl…
## 16   20564034 36794622 prism-repurposing-20q… 1.61e7 https://ndo… 610f… text/pl…
```

Let’s now focus on the
`prism-repurposing-20q2-primary-screen-cell-line-info.csv` file. We
can filter it by its name and downloaded it with `dmget()`:

```
dmfiles() |>
    filter(name == "prism-repurposing-20q2-primary-screen-cell-line-info.csv") |>
    dmget()
```

```
## File: prism-repurposing-20q2-primary-screen-cell-line-info.csv (36794565)
```

```
## Downloading 36794565 file.
```

```
## Error while performing HEAD request.
##    Proceeding without cache information.
```

```
##                                                     BFC2
## "/home/biocbuild/.cache/R/depmap/3d0452cbd0ee2_36794565"
```

The `dmget()` function will first check if it hasn’t already been
downloaded and cached in the depmap cache directory (see
`?dmCache()`). If so, it will retrieve if from there. Otherwise, it
will download the file and store it in the package cache directory. It
will return the location of the cached file.

Given that the file is in csv format, we can directly open it with
`read_csv()`:

```
dmfiles() |>
    filter(name == "prism-repurposing-20q2-primary-screen-cell-line-info.csv") |>
    dmget() |>
    read_csv()
```

```
## File: prism-repurposing-20q2-primary-screen-cell-line-info.csv (36794565)
```

```
## Loading 36794565 from cache.
```

```
## Rows: 588 Columns: 10
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (9): row_name, depmap_id, ccle_name, primary_tissue, secondary_tissue, t...
## lgl (1): passed_str_profiling
##
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```
## # A tibble: 588 × 10
##    row_name  depmap_id ccle_name primary_tissue secondary_tissue tertiary_tissue
##    <chr>     <chr>     <chr>     <chr>          <chr>            <chr>
##  1 ACH-0008… ACH-0008… KYSE510_… esophagus      esophagus_squam… <NA>
##  2 ACH-0009… ACH-0009… HEC1A_EN… uterus         uterus_endometr… <NA>
##  3 ACH-0006… ACH-0006… MIAPACA2… pancreas       <NA>             <NA>
##  4 ACH-0006… ACH-0006… SW620_LA… colorectal     <NA>             <NA>
##  5 ACH-0003… ACH-0003… SKHEP1_L… liver          <NA>             <NA>
##  6 ACH-0008… ACH-0008… SW480_LA… colorectal     <NA>             <NA>
##  7 ACH-0005… ACH-0005… YKG1_CEN… central_nervo… glioma           glioblastoma
##  8 ACH-0003… ACH-0003… J82_URIN… urinary_tract  <NA>             <NA>
##  9 ACH-0007… ACH-0007… KYSE30_O… esophagus      esophagus_squam… <NA>
## 10 ACH-0009… ACH-0009… NCIH2172… lung           lung_NSC         <NA>
## # ℹ 578 more rows
## # ℹ 4 more variables: passed_str_profiling <lgl>, str_profiling_notes <chr>,
## #   originally_assigned_depmap_id <chr>, originally_assigned_ccle_name <chr>
```

It is also possible to pass multiple rows of the `dmfiles()` table to
`dmget()` to retrieve multiple file paths. Below, let’s get all the
README.txt files from 2020:

```
ids_2020 <- filter(dmsets(), grepl("20Q", title)) |>
    pull(dataset_id)

dmfiles() |>
    filter(dataset_id %in% ids_2020) |>
    filter(grepl("README", name)) |>
    dmget()
```

```
## File: README (25797005)
```

```
## Downloading 25797005 file.
```

```
## Error while performing HEAD request.
##    Proceeding without cache information.
```

```
## File: README (25817903)
```

```
## Downloading 25817903 file.
```

```
## Error while performing HEAD request.
##    Proceeding without cache information.
```

```
## File: README (22897970)
```

```
## Downloading 22897970 file.
```

```
## Error while performing HEAD request.
##    Proceeding without cache information.
```

```
## File: README (22543694)
```

```
## Downloading 22543694 file.
```

```
## Error while performing HEAD request.
##    Proceeding without cache information.
```

```
##                                                      BFC3
##  "/home/biocbuild/.cache/R/depmap/3d0452db12907_25797005"
##                                                      BFC4
## "/home/biocbuild/.cache/R/depmap/3d045238ad156d_25817903"
##                                                      BFC5
## "/home/biocbuild/.cache/R/depmap/3d045254e9ce71_22897970"
##                                                      BFC6
## "/home/biocbuild/.cache/R/depmap/3d045223830329_22543694"
```

# 5 Session information

```
## R version 4.5.2 (2025-10-31)
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
##  [1] ExperimentHub_3.0.0 AnnotationHub_4.0.0 BiocFileCache_3.0.0
##  [4] dbplyr_2.5.1        BiocGenerics_0.56.0 generics_0.1.4
##  [7] depmap_1.24.0       lubridate_1.9.4     forcats_1.0.1
## [10] stringr_1.6.0       dplyr_1.1.4         purrr_1.2.0
## [13] readr_2.1.6         tidyr_1.3.1         tibble_3.3.0
## [16] ggplot2_4.0.1       tidyverse_2.0.0     BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0      gtable_0.3.6         xfun_0.54
##  [4] bslib_0.9.0          httr2_1.2.1          Biobase_2.70.0
##  [7] tzdb_0.5.0           vctrs_0.6.5          tools_4.5.2
## [10] parallel_4.5.2       stats4_4.5.2         curl_7.0.0
## [13] AnnotationDbi_1.72.0 RSQLite_2.4.4        blob_1.2.4
## [16] pkgconfig_2.0.3      RColorBrewer_1.1-3   S7_0.2.1
## [19] S4Vectors_0.48.0     lifecycle_1.0.4      compiler_4.5.2
## [22] farver_2.1.2         Biostrings_2.78.0    Seqinfo_1.0.0
## [25] htmltools_0.5.8.1    sass_0.4.10          yaml_2.3.10
## [28] crayon_1.5.3         pillar_1.11.1        jquerylib_0.1.4
## [31] cachem_1.1.0         tidyselect_1.2.1     digest_0.6.38
## [34] stringi_1.8.7        bookdown_0.45        BiocVersion_3.22.0
## [37] fastmap_1.2.0        grid_4.5.2           archive_1.1.12
## [40] cli_3.6.5            magrittr_2.0.4       utf8_1.2.6
## [43] dichromat_2.0-0.1    withr_3.0.2          filelock_1.0.3
## [46] scales_1.4.0         rappdirs_0.3.3       bit64_4.6.0-1
## [49] timechange_0.3.0     XVector_0.50.0       httr_1.4.7
## [52] rmarkdown_2.30       bit_4.6.0            png_0.1-8
## [55] hms_1.1.4            memoise_2.0.1        evaluate_1.0.5
## [58] knitr_1.50           IRanges_2.44.0       rlang_1.1.6
## [61] glue_1.8.0           DBI_1.2.3            BiocManager_1.30.27
## [64] vroom_1.6.6          jsonlite_2.0.0       R6_2.6.1
```