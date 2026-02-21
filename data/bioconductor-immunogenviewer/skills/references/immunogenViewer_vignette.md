# Using immunogenViewer to evaluate and choose antibodies

Katharina Waury1

1Vrije Universiteit Amsterdam, Amsterdam, The Netherlands

#### 30 October 2025

# 1 Introduction

The package `immunogenViewer` is meant to support researchers in comparing and choosing suitable antibodies provided that information on the immunogen used to raise the antibody is available. When the immunogen of an antibody is known, its binding site within the protein antigen is defined and can be examined in detail. As antibodies raised against peptide immunogens often do not function properly when used to detect natively folded proteins (Brown et al. [2011](#ref-Brown2011)), examination of the position of the immunogen within the full-length protein can provide insights. Using `immunogenViewer` provides an easy approach to visualize, evaluate and compare immunogens within the full-length sequence of a protein. Information on structural and functional annotations of the immunogen and thus antibody binding site can tell the user if an antibody is potentially useful for native protein detection (Trier, Hansen, and Houen [2012](#ref-Trier2012); Waury et al. [2022](#ref-Waury2022)).

Specifically, `immunogenViewer` can be used to retrieve protein features for a protein of interest using an API call to the [UniProtKB](https://www.uniprot.org/) (Bateman et al. [2022](#ref-Uniprot2022)) and [PredictProtein](https://predictprotein.org/) (Bernhofer et al. [2021](#ref-Bernhofer2021)) databases. The features are saved on a per-residue level in a dataframe. One or several immunogens can be associated with the protein. The immunogen(s) can then be visualized and evaluated regarding their structure and other annotations that can influence successful antibody recognition within the full-length protein. A summary report of the immunogen can be created to easily compare and select favorable immunogens and their respective antibodies. This package should be used as a pre-selection step to exclude unsuitable antibodies early on. It does not replace comprehensive antibody validation. For more information on validation, please refer to other excellent resources (Roncador et al. [2015](#ref-Roncador2015); Voskuil et al. [2020](#ref-Voskuil2020)).

# 2 Installation

The package can be installed directly from Bioconductor.

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("immunogenViewer")
```

```
library(immunogenViewer)
```

# 3 User guide

## 3.1 Retrieving the protein features

To retrieve the features for the protein of interest the correct UniProt ID (also known as accession number) is required. If the UniProt ID is not known yet, one can search the [UniProtKB](https://www.uniprot.org/) using the gene or protein name. Be sure to select the UniProt ID of the correct organism and preferable search within reviewed SwissProt entries instead of unreviewed TrEMBL entries. Our example protein is the human protein TREM2 (UniProt ID: [Q9NZC2](https://www.uniprot.org/uniprotkb/Q9NZC2/entry)). Using `getProteinFeatures()` relevant features from UniProt and PredictProtein are retrieved. Interaction with UniProt is done using the Bioconductor package [UniProt.ws](https://bioconductor.org/packages/release/bioc/html/UniProt.ws.html). To see how the dataframe is structured, we will look at the returned dataframe.

The following protein features are included:

* Secondary Structure: Each residue is assigned as helix, sheet or other conformation based on predictions by RePROF. Source:
  [PredictProtein](https://www.predictprotein.org/)
* Solvent Accessibility: Each residue is assigned as exposed or buried based on predictions by RePROF. Source:
  [PredictProtein](https://www.predictprotein.org/)
* Membrane: Residues that are annotated as [transmembrane](https://www.uniprot.org/help/transmem) or
  [intramembrane](https://www.uniprot.org/help/intramem). Source: [UniProtKB](https://www.uniprot.org/)
* Protein Binding: Each residue that is predicted to bind proteins based on predictions by ProNA. Source:
  [PredictProtein](https://www.predictprotein.org/)
* Disorder: Each residue that is predicted to be disordered based on predictions by Meta-Disorder. Source: [PredictProtein](https://www.predictprotein.org/)
* PTM: Residues that are annotated as [modified residues](https://www.uniprot.org/help/mod_res),
  [lipidation](https://www.uniprot.org/help/lipid) or [glycosylation](https://www.uniprot.org/help/carbohyd). Source:
  [UniProtKB](https://www.uniprot.org/)
* Disulfide Bridges: Residues that are annotated as [disulfide bonds](https://www.uniprot.org/help/disulfid). Source: [UniProtKB](https://www.uniprot.org/)

To see how the dataframe is structured, we will look at the returned dataframe.

```
protein <- getProteinFeatures("Q9NZC2")
# check protein dataframe
DT::datatable(protein, width = "80%", options = list(scrollX = TRUE))
```

## 3.2 Adding immunogens to the protein dataframe

After creating the protein dataframe using `getProteinFeatures()` immunogens to be visualized and evaluated can be added to the dataframe. For this purpose, we use `addImmunogen()`. With every call to the function one immunogen can be added to the protein dataframe. Besides the protein dataframe, we need to define the immunogen to be added by supplying the start and end position of the immunogen and a name.

Searching antibody database Antibodypedia, three antibodies are identified that were raised against known immunogens peptide. These immunogens are added to the dataframe by defining their start and end position or the immunogen peptide sequence within the full protein sequence and naming them after their catalog identifiers. Each immunogen is added as an additional column to the protein dataframe, the immunogen name is used as the column name.

```
protein <- addImmunogen(protein, start = 142, end = 192, name = "ABIN2783734_")
protein <- addImmunogen(protein, start = 196, end = 230, name = "HPA010917")
protein <- addImmunogen(protein, seq = "HGQKPGTHPPSELD", name = "EB07921")
# check that immunogens were added as columns
colnames(protein)
 [1] "Uniprot"            "Position"           "Residue"
 [4] "SecondaryStructure" "ProteinBinding"     "Membrane"
 [7] "PTM"                "DisulfideBridge"    "ABIN2783734_"
[10] "HPA010917"          "EB07921"
```

### 3.2.1 Renaming an immunogen

Already added immunogens can be renamed using `renameImmunogen()` if the provided start and end position are correct but the name should be updated. This way a typo can be corrected or a more informative name added instead of re-adding the immunogen. The column name in the protein dataframe is then updated.

```
protein <- renameImmunogen(protein, oldName = "ABIN2783734_", newName = "ABIN2783734")
# check that immunogen name was updated
colnames(protein)
 [1] "Uniprot"            "Position"           "Residue"
 [4] "SecondaryStructure" "ProteinBinding"     "Membrane"
 [7] "PTM"                "DisulfideBridge"    "ABIN2783734"
[10] "HPA010917"          "EB07921"
```

### 3.2.2 Removing an immunogen

A previously added immunogen can be removed from the protein dataframe using `removeImmunogen()`. The corresponding column is dropped from the protein dataframe.

```
protein <- removeImmunogen(protein, name = "HPA010917")
# check that immunogen was removed
colnames(protein)
 [1] "Uniprot"            "Position"           "Residue"
 [4] "SecondaryStructure" "ProteinBinding"     "Membrane"
 [7] "PTM"                "DisulfideBridge"    "ABIN2783734"
[10] "EB07921"
```

## 3.3 Visualizing the protein with the immunogens highlighted

After retrieval of the protein features and adding the relevant immunogens correctly, the full protein sequence can be plotted with the features and the immunogens annotated along the sequence. The plot allows to understand the position of the immunogen peptide within the full-length sequence as well as identify relevant obstacles within the protein that might hinder or limit successful antibody binding.

```
plotProtein(protein)
```

![](data:image/png;base64...)

## 3.4 Visualizing a specific immunogen

If interested in one specific immunogen, one can visualize the relevant
part of the protein sequence. In this plot the amino acid sequence of
the immunogen is shown along the x axis while the same features as in
the protein plot are included.

```
plotImmunogen(protein, "ABIN2783734")
```

![](data:image/png;base64...)

## 3.5 Evaluating the immunogens

Apart from visualizing specific immunogens, it is also possible to summarize the protein features within a specific immunogen. This can either be done for one immunogen of interest or for all immunogens added to a protein dataframe at once. The output is a summary dataframe that can be sorted by the feature columns. By sorting the most suitable immunogen, e.g., with the highest fraction of exposed residues, can be selected.

The following summary statistics are included:

* SumPTM: Number of PTM residues within the immunogen.
* SumDisulfideBridges: Number of disulfide bond residues within the immunogen.
* ProportionMembrane: Proportion of immunogen residues that are annotated as membrane residues.
* ProportionDisorder: Proportion of immunogen residues that are predicted as disordered.
* ProportionBinding: Proportion of immunogen residues that are predicted to bind proteins.
* ProportionsHelix: Proportion of immunogen residues that are predicted to form alpha helices.
* ProportionsSheet: Proportion of immunogen residues that are predicted to form beta sheets.
* ProportionsCoil: Proportion of immunogen residues that are predicted to form coils.
* ProportionsBuried: Proportion of immunogen residues that are predicted to be buried.
* ProportionsExposed: Proportion of immunogen residues that are predicted to be solvent exposed.

```
immunogens <- evaluateImmunogen(protein)
[1] "No immunogen specified, evaluating all immunogens."
[1] "Immunogen name: ABIN2783734"
[1] "Immunogen sequence: WFPGESESFEDAHVEHSISRSLLEGEIPFPPTSILLLLACIFLIKILAASA (Residues 142 - 192)"
[1] "Immunogen name: EB07921"
[1] "Immunogen sequence: HGQKPGTHPPSELD (Residues 199 - 212)"
# check summary dataframe
DT::datatable(immunogens, width = "80%", options = list(scrollX = TRUE))
```

# 4 Important Notes

* The length of an immunogen has to be between 10 and 50 amino acids.
* The secondary structure “Other” usually stand for coil structures.
* For the call to `getProteinFeatures()` the taxonomy ID for the
  protein’s species has to be set. The default is human (ID: 9606). If
  the protein of interest is from a different species, the correct
  taxonomy ID must be set as a parameter.

# References

Bateman, Alex, Maria-Jesus Martin, Sandra Orchard, Michele Magrane, Shadab Ahmad, Emanuele Alpi, Emily H Bowler-Barnett, et al. 2022. “UniProt: The Universal Protein Knowledgebase in 2023.” *Nucleic Acids Research* 51 (D1): D523–D531. <https://doi.org/10.1093/nar/gkac1052>.

Bernhofer, Michael, Christian Dallago, Tim Karl, Venkata Satagopam, Michael Heinzinger, Maria Littmann, Tobias Olenyi, et al. 2021. “PredictProtein - Predicting Protein Structure and Function for 29 Years.” *Nucleic Acids Research* 49 (W1): W535–W540. <https://doi.org/10.1093/nar/gkab354>.

Brown, Michael C., Tony R. Joaquim, Ross Chambers, Dale V. Onisk, Fenglin Yin, Janet M. Moriango, Yichun Xu, et al. 2011. “Impact of Immunization Technology and Assay Application on Antibody Performance – a Systematic Comparative Evaluation.” *PLoS ONE* 6 (12): e28718. <https://doi.org/10.1371/journal.pone.0028718>.

Roncador, Giovanna, Pablo Engel, Lorena Maestre, Amanda P. Anderson, Jacqueline L. Cordell, Mark S. Cragg, Vladka Č. Šerbec, et al. 2015. “The European Antibody Network’s Practical Guide to Finding and Validating Suitable Antibodies for Research.” *mAbs* 8 (1): 27–36. <https://doi.org/10.1080/19420862.2015.1100787>.

Trier, N. H., P. R. Hansen, and G. Houen. 2012. “Production and Characterization of Peptide Antibodies.” *Methods* 56 (2): 136–44. <https://doi.org/10.1016/j.ymeth.2011.12.001>.

Voskuil, Jan L. A., Anita Bandrowski, C. Glenn Begley, Andrew R. M. Bradbury, Andrew D. Chalmers, Aldrin V. Gomes, Travis Hardcastle, et al. 2020. “The Antibody Society’s Antibody Validation Webinar Series.” *mAbs* 12 (1). <https://doi.org/10.1080/19420862.2020.1794421>.

Waury, Katharina, Eline A. J. Willemse, Eugeen Vanmechelen, Henrik Zetterberg, Charlotte E. Teunissen, and Sanne Abeln. 2022. “Bioinformatics Tools and Data Resources for Assay Development of Fluid Protein Biomarkers.” *Biomarker Research* 10 (1). <https://doi.org/10.1186/s40364-022-00425-w>.

# Appendix

# A Session info

```
sessionInfo()
R version 4.5.1 Patched (2025-08-23 r88802)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default
BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0

locale:
 [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
 [3] LC_TIME=en_GB              LC_COLLATE=C
 [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
 [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
 [9] LC_ADDRESS=C               LC_TELEPHONE=C
[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base

other attached packages:
[1] immunogenViewer_1.4.0 BiocStyle_2.38.0

loaded via a namespace (and not attached):
 [1] KEGGREST_1.50.0      gtable_0.3.6         xfun_0.53
 [4] bslib_0.9.0          ggplot2_4.0.0        httr2_1.2.1
 [7] htmlwidgets_1.6.4    Biobase_2.70.0       crosstalk_1.2.2
[10] vctrs_0.6.5          rjsoncons_1.3.2      tools_4.5.1
[13] generics_0.1.4       stats4_4.5.1         curl_7.0.0
[16] tibble_3.3.0         AnnotationDbi_1.72.0 RSQLite_2.4.3
[19] blob_1.2.4           pkgconfig_2.0.3      BiocBaseUtils_1.12.0
[22] dbplyr_2.5.1         RColorBrewer_1.1-3   S7_0.2.0
[25] S4Vectors_0.48.0     lifecycle_1.0.4      compiler_4.5.1
[28] farver_2.1.2         Biostrings_2.78.0    progress_1.2.3
[31] tinytex_0.57         Seqinfo_1.0.0        htmltools_0.5.8.1
[34] sass_0.4.10          yaml_2.3.10          pillar_1.11.1
[37] crayon_1.5.3         jquerylib_0.1.4      DT_0.34.0
[40] cachem_1.1.0         magick_2.9.0         tidyselect_1.2.1
[43] digest_0.6.37        dplyr_1.1.4          bookdown_0.45
[46] labeling_0.4.3       UniProt.ws_2.50.0    fastmap_1.2.0
[49] grid_4.5.1           cli_3.6.5            magrittr_2.0.4
[52] patchwork_1.3.2      dichromat_2.0-0.1    withr_3.0.2
[55] prettyunits_1.2.0    filelock_1.0.3       scales_1.4.0
[58] rappdirs_0.3.3       bit64_4.6.0-1        rmarkdown_2.30
[61] XVector_0.50.0       httr_1.4.7           bit_4.6.0
[64] png_0.1-8            hms_1.1.4            memoise_2.0.1
[67] evaluate_1.0.5       knitr_1.50           IRanges_2.44.0
[70] BiocFileCache_3.0.0  rlang_1.1.6          Rcpp_1.1.0
[73] glue_1.8.0           DBI_1.2.3            BiocManager_1.30.26
[76] BiocGenerics_0.56.0  jsonlite_2.0.0       R6_2.6.1
```