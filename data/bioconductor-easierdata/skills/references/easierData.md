Code

* Show All Code
* Hide All Code

# easier Data

#### Oscar Lapuente-Santana

Computational Biology group, Department of Biomedical Engineering, Eindhoven University of Technology (BME, TU/e)
o.lapuente.santana@tue.nl

#### Federico Marini

Institute of Medical Biostatistics, Epidemiology and Informatics (IMBEI, Mainz)
marinif@uni-mainz.de

#### Arsenij Ustjanzew

Institute of Medical Biostatistics, Epidemiology and Informatics (IMBEI, Mainz)
arsenij.ustjanzew@uni-mainz.de

#### Francesca Finotello

Institute of Bioinformatics, Biocenter Medical University of Innsbruck
francesca.finotello@i-med.ac.at

#### Federica Eduati

Computational Biology group, Department of Biomedical Engineering, Eindhoven University of Technology (BME, TU/e)
f.eduati@tue.nl

#### 2025-11-04

# 1 Intro to `easierData`

The `easierData` package includes an exemplary cancer dataset from Mariathasan et al. (2018) to showcase the `easier` package:

* **Mariathasan2018\_PDL1\_treatment**: exemplary bladder cancer dataset with samples from 192 patients. This is provided as a `SummarizedExperiment` object containing:

  + Two assays: `counts` and `tpm` expression values.
  + Additional sample metadata in the `colData` slot, including pat\_id (the id of the patient in the original study), BOR, and TMB (Tumor Mutational Burden).

  The processed data is publicly available from Mariathasan et al.  “TGF-B attenuates tumour response to PD-L1 blockade by contributing to exclusion of T cells”, published in Nature, 2018 [doi:10.1038/nature25501](https://doi.org/10.1038/nature25501) via [IMvigor210CoreBiologies](http://research-pub.gene.com/IMvigor210CoreBiologies/) package under the CC-BY license.

The `easierData` data package also includes multiple data objects so-called internal data of `easier` package since they are indispensable for the functional performance of the package. This includes:

* **opt\_models**: the cancer-specific model feature parameters learned in Lapuente-Santana et al. (2021). For each quantitative descriptor (e.g.  pathway activity), models were trained using multi-task learning with randomized cross-validation repeated 100 times. For each quantitative descriptor, 1000 models are available (100 per task). This is provided as a list containing, for each cancer type and quantitative descriptor, a matrix of feature coefficient values across different tasks.
* **opt\_xtrain\_stats**: the cancer-specific features mean and standard deviation of each quantitative descriptor (e.g. pathway activity) training set used in Lapuente-Santana et al. (2021) during randomized cross-validation repeated 100 times, required for normalization of the test set. This is provided as a list containing, for each cancer type and quantitative descriptor, a matrix with feature mean and sd values across the 100 cross-validation runs.
* **TCGA\_mean\_pancancer**: a numeric vector with the mean of the TPM expression of each gene across all TCGA cancer types, required for normalization of input TPM gene expression data.
* **TCGA\_sd\_pancancer**: a numeric vector with the standard deviation (sd) of the TPM expression of each gene across all TCGA cancer types, required for normalization of input TPM gene expression data.
* **cor\_scores\_genes**: a character vector with the list of genes used to define correlated scores of immune response. These scores were found to be highly correlated across all 18 cancer types (Lapuente-Santana et al. 2021).
* **intercell\_networks**: a list with the cancer-specific intercellular networks, including a pan-cancer network.
* **lr\_frequency\_TCGA**: a numeric vector containing the frequency of each ligand-receptor pair feature across the whole TCGA database.
* **group\_lrpairs**: a list with the information on how to group ligand-receptor pairs because of sharing the same gene, either as ligand or receptor.
* **HGNC\_annotation**: a data.frame with the gene symbols approved annotations obtained from <https://www.genenames.org/tools/multi-symbol-checker/> (Tweedie et al. 2020).
* **scores\_signature\_genes**: a list with the gene signatures for each score of immune response: CYT (Rooney et al. 2015), TLS (Cabrita et al. 2020), IFNy (McClanahan 2017), Ayers\_expIS (McClanahan 2017), Tcell\_inflamed (McClanahan 2017), Roh\_IS (Roh et al. 2017), Davoli\_IS (Davoli et al. 2017), chemokines (Messina et al. 2012), IMPRES (Auslander et al. 2018), MSI (Fu et al. 2019) and RIR (Jerby-Arnon et al. 2018).

# 2 Load easier Data

Starting R, this package can be installed as follows:

```
BiocManager::install("easierData")
```

The contents of the package can be seen by querying ExperimentHub for the package name:

```
suppressPackageStartupMessages({
    library("ExperimentHub")
    library("easierData")
})

eh <- ExperimentHub()
query(eh, "easierData")
#> ExperimentHub with 11 records
#> # snapshotDate(): 2025-10-29
#> # $dataprovider: NA, IMvigor210CoreBiologies package;  Mariathasan S, Turley...
#> # $species: Homo sapiens
#> # $rdataclass: list, numeric, data.frame, character, SummarizedExperiment
#> # additional mcols(): taxonomyid, genome, description,
#> #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
#> #   rdatapath, sourceurl, sourcetype
#> # retrieve records with, e.g., 'object[["EH6677"]]'
#>
#>            title
#>   EH6677 | Mariathasan2018_PDL1_treatment
#>   EH6678 | opt_models
#>   EH6679 | opt_xtrain_stats
#>   EH6680 | TCGA_mean_pancancer
#>   EH6681 | TCGA_sd_pancancer
#>   ...      ...
#>   EH6683 | intercell_networks
#>   EH6684 | lr_frequency_TCGA
#>   EH6685 | group_lrpairs
#>   EH6686 | HGNC_annotation
#>   EH6687 | scores_signature_genes
```

An overview is provided also in tabular form:

```
list_easierData()
#>     eh_id                          title
#> 1  EH6677 Mariathasan2018_PDL1_treatment
#> 2  EH6678                     opt_models
#> 3  EH6679               opt_xtrain_stats
#> 4  EH6680            TCGA_mean_pancancer
#> 5  EH6681              TCGA_sd_pancancer
#> 6  EH6682               cor_scores_genes
#> 7  EH6683             intercell_networks
#> 8  EH6684              lr_frequency_TCGA
#> 9  EH6685                  group_lrpairs
#> 10 EH6686                HGNC_annotation
#> 11 EH6687         scores_signature_genes
```

The individual data objects can be accessed using either their ExperimentHub accession number, or the convenience functions provided in this package - both calls are equivalent. For instance to access the `Mariathasan2018_PDL1_treatment` example dataset:

```
mariathasan_dataset <- eh[["EH6677"]]
mariathasan_dataset
#> class: SummarizedExperiment
#> dim: 31087 192
#> metadata(1): cancertype
#> assays(2): counts tpm
#> rownames(31087): A1BG NAT2 ... CASP8AP2 SCO2
#> rowData names(0):
#> colnames(192): SAM7f0d9cc7f001 SAM4305ab968b90 ... SAMda4d892fddc8
#>   SAMe3d4266775a9
#> colData names(3): pat_id BOR TMB

mariathasan_dataset <- get_Mariathasan2018_PDL1_treatment()
mariathasan_dataset
#> class: SummarizedExperiment
#> dim: 31087 192
#> metadata(1): cancertype
#> assays(2): counts tpm
#> rownames(31087): A1BG NAT2 ... CASP8AP2 SCO2
#> rowData names(0):
#> colnames(192): SAM7f0d9cc7f001 SAM4305ab968b90 ... SAMda4d892fddc8
#>   SAMe3d4266775a9
#> colData names(3): pat_id BOR TMB
```

# Session info

```
sessionInfo()
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
#>  [1] SummarizedExperiment_1.40.0 Biobase_2.70.0
#>  [3] GenomicRanges_1.62.0        Seqinfo_1.0.0
#>  [5] IRanges_2.44.0              S4Vectors_0.48.0
#>  [7] MatrixGenerics_1.22.0       matrixStats_1.5.0
#>  [9] ExperimentHub_3.0.0         AnnotationHub_4.0.0
#> [11] BiocFileCache_3.0.0         dbplyr_2.5.1
#> [13] BiocGenerics_0.56.0         generics_0.1.4
#> [15] easierData_1.16.0
#>
#> loaded via a namespace (and not attached):
#>  [1] KEGGREST_1.50.0      xfun_0.54            bslib_0.9.0
#>  [4] httr2_1.2.1          lattice_0.22-7       vctrs_0.6.5
#>  [7] tools_4.5.1          curl_7.0.0           tibble_3.3.0
#> [10] AnnotationDbi_1.72.0 RSQLite_2.4.3        blob_1.2.4
#> [13] pkgconfig_2.0.3      Matrix_1.7-4         lifecycle_1.0.4
#> [16] compiler_4.5.1       Biostrings_2.78.0    htmltools_0.5.8.1
#> [19] sass_0.4.10          yaml_2.3.10          pillar_1.11.1
#> [22] crayon_1.5.3         jquerylib_0.1.4      cachem_1.1.0
#> [25] DelayedArray_0.36.0  abind_1.4-8          tidyselect_1.2.1
#> [28] digest_0.6.37        purrr_1.1.0          dplyr_1.1.4
#> [31] BiocVersion_3.22.0   fastmap_1.2.0        grid_4.5.1
#> [34] cli_3.6.5            SparseArray_1.10.1   magrittr_2.0.4
#> [37] S4Arrays_1.10.0      withr_3.0.2          filelock_1.0.3
#> [40] rappdirs_0.3.3       bit64_4.6.0-1        rmarkdown_2.30
#> [43] XVector_0.50.0       httr_1.4.7           bit_4.6.0
#> [46] png_0.1-8            memoise_2.0.1        evaluate_1.0.5
#> [49] knitr_1.50           rlang_1.1.6          glue_1.8.0
#> [52] DBI_1.2.3            BiocManager_1.30.26  jsonlite_2.0.0
#> [55] R6_2.6.1
```

# References

Auslander, Noam, Gao Zhang, Joo Sang Lee, Dennie T. Frederick, Benchun Miao, Tabea Moll, Tian Tian, et al. 2018. “Robust Prediction of Response to Immune Checkpoint Blockade Therapy in Metastatic Melanoma.” *Nature Medicine* 24 (10): 1545–9. <https://doi.org/10.1038/s41591-018-0157-9>.

Cabrita, Rita, Martin Lauss, Adriana Sanna, Marco Donia, Mathilde Skaarup Larsen, Shamik Mitra, Iva Johansson, et al. 2020. “Tertiary Lymphoid Structures Improve Immunotherapy and Survival in Melanoma.” *Nature* 577 (7791): 561–65. <https://doi.org/10.1038/s41586-019-1914-8>.

Davoli, Teresa, Hajime Uno, Eric C. Wooten, and Stephen J. Elledge. 2017. “Tumor Aneuploidy Correlates with Markers of Immune Evasion and with Reduced Response to Immunotherapy.” *Science* 355 (6322). <https://doi.org/10.1126/science.aaf8399>.

Fu, Yelin, Lishuang Qi, Wenbing Guo, Liangliang Jin, Kai Song, Tianyi You, Shuobo Zhang, Yunyan Gu, Wenyuan Zhao, and Zheng Guo. 2019. “A Qualitative Transcriptional Signature for Predicting Microsatellite Instability Status of Right-Sided Colon Cancer.” *BMC Genomics* 20 (1): 769. <https://doi.org/10.1186/s12864-019-6129-8>.

Jerby-Arnon, Livnat, Parin Shah, Michael S. Cuoco, Christopher Rodman, Mei-Ju Su, Johannes C. Melms, Rachel Leeson, et al. 2018. “A Cancer Cell Program Promotes T Cell Exclusion and Resistance to Checkpoint Blockade.” *Cell* 175 (4): 984–997.e24. <https://doi.org/10.1016/j.cell.2018.09.006>.

Lapuente-Santana, Oscar, Maisa van Genderen, Peter A. J. Hilbers, Francesca Finotello, and Federica Eduati. 2021. “Interpretable Systems Biomarkers Predict Response to Immune-Checkpoint Inhibitors.” *Patterns*, 100293. <https://doi.org/10.1016/j.patter.2021.100293>.

Mariathasan, Sanjeev, Shannon J. Turley, Dorothee Nickles, Alessandra Castiglioni, Kobe Yuen, Yulei Wang, Edward E. Kadel III, et al. 2018. “TGFB Attenuates Tumour Response to Pd-L1 Blockade by Contributing to Exclusion of T Cells.” *Nature* 554 (7693): 544–48. <https://doi.org/10.1038/nature25501>.

McClanahan, Mark Ayers AND Jared Lunceford AND Michael Nebozhyn AND Erin Murphy AND Andrey Loboda AND David R. Kaufman AND Andrew Albright AND Jonathan D. Cheng AND S. Peter Kang AND Veena Shankaran AND Sarina A. Piha-Paul AND Jennifer Yearley AND Tanguy Y. Seiwert AND Antoni Ribas AND Terrill K. 2017. “IFN-Y–Related mRNA Profile Predicts Clinical Response to Pd-1 Blockade.” *The Journal of Clinical Investigation* 127 (8): 2930–40. <https://doi.org/10.1172/JCI91190>.

Messina, Jane L., David A. Fenstermacher, Steven Eschrich, Xiaotao Qu, Anders E. Berglund, Mark C. Lloyd, Michael J. Schell, Vernon K. Sondak, Jeffrey S. Weber, and James J. Mulé. 2012. “12-Chemokine Gene Signature Identifies Lymph Node-Like Structures in Melanoma: Potential for Patient Selection for Immunotherapy?” *Scientific Reports* 2 (1): 765. <https://doi.org/10.1038/srep00765>.

Roh, Whijae, Pei-Ling Chen, Alexandre Reuben, Christine N. Spencer, Peter A. Prieto, John P. Miller, Vancheswaran Gopalakrishnan, et al. 2017. “Integrated Molecular Analysis of Tumor Biopsies on Sequential Ctla-4 and Pd-1 Blockade Reveals Markers of Response and Resistance.” *Science Translational Medicine* 9 (379). <https://doi.org/10.1126/scitranslmed.aah3560>.

Rooney, Michael S., Sachet A. Shukla, Catherine J. Wu, Gad Getz, and Nir Hacohen. 2015. “Molecular and Genetic Properties of Tumors Associated with Local Immune Cytolytic Activity.” *Cell* 160 (1): 48–61. <https://doi.org/10.1016/j.cell.2014.12.033>.

Tweedie, Susan, Bryony Braschi, Kristian Gray, Tamsin E M Jones, Ruth L Seal, Bethan Yates, and Elspeth A Bruford. 2020. “Genenames.org: the HGNC and VGNC resources in 2021.” *Nucleic Acids Research* 49 (D1): D939–D946. <https://doi.org/10.1093/nar/gkaa980>.