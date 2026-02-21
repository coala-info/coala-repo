# Contents

* [1 Abstract](#abstract)
* [2 Introduction](#introduction)
* [3 Installation instructions](#installation-instructions)
* [4 Case-study](#case-study)
  + [4.1 Study subject](#study-subject)
  + [4.2 Metabonomic data](#metabonomic-data)
  + [4.3 Clinical data](#clinical-data)
  + [4.4 Load data](#load-data)
  + [4.5 Quality control (QC) analysis](#quality-control-qc-analysis)
  + [4.6 Metabolome-wide associations](#metabolome-wide-associations)
  + [4.7 NMR metabolite assignment using STOCSY](#nmr-metabolite-assignment-using-stocsy)
  + [4.8 Mapping metabolites of interest onto KEGG pathways](#mapping-metabolites-of-interest-onto-kegg-pathways)
* [References](#references)

MWASTools

Andrea Rodriguez Martinez,
Joram M. Posma, Rafael Ayala, Ana L. Neves, Maryam Anwar, Jeremy K. Nicholson, Marc-Emmanuel Dumas

May 26, 2017

# 1 Abstract

“MWASTools” is an R package designed to provide an integrated
and user-friendly pipeline to analyze metabonomic data in the context of large-scale
epidemiological studies. Key functionalities of the package include: quality control analysis;
metabolite-phenotype association models; data visualization tools;
metabolite assignment using statistical total correlation spectroscopy (STOCSY);
and biological interpretation of MWAS results.

# 2 Introduction

Metabonomics is a powerful systems biology approach that targets metabolites from biofluids (e.g. urine or plasma) or tissues, providing metabolic patterns that correspond to the metabolic status of the organism as a function of genetic and environmental influences (Nicholson *et al.* [2002](#ref-nicholson2002)). Thanks to the recent developments in high-throughput platforms (i.e. nuclear magnetic resonance (NMR) and mass spectrometry
(MS)), metabolic profiling is now being used for large-scale epidemiological applications
such as metabolome-wide association studies (MWAS) (Holmes *et al.* [2008](#ref-holmes2008); Elliott *et al.* [2015](#ref-posma2015)).

Customized statistical modeling approaches and data visualization tools are essential for biomarker discovery in large-scale metabolic phenotyping studies. Several software packages have
been developed to detect and visualize metabolic changes between conditions of interest (e.g. disease *vs* control) using multivariate statistical methods (e.g. OPLS-DA) (Gaude *et al.* [2013](#ref-gaude2013); Thevenot *et al.* [2015](#ref-thevenot2015)). However, a major limitation of these multivariate models from the epidemiological perspective is that they do not properly account for cofounding factors (e.g. age, gender), which might distort the observed associations between the metabolites and the condition under study. Here, we present a package to perform MWAS using univariate hypothesis testing with efficient handling of epidemiological confounders. Our package provides a versatile and user-friendly
MWAS pipeline with the following key functionalities: quality control (QC) analysis; metabolite-phenotype association models (partial correlations, generalized linear models) adjusted for epidemiological confounders (e.g. age or gender); bootstrapping of association models; visualization of statistical outcomes; metabolite assignment using Statistical Total Correlation Spectroscopy (STOCSY) (Cloarec *et al.* [2005](#ref-cloarec2005)); and biological interpretation of MWAS results (Kanehisa & Goto [2000](#ref-kanehisa2000)).

# 3 Installation instructions

Assuming that R (>=3.3) and Bioconductor have been correctly
installed, MWASTools can be installed with:

```
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("MWASTools", version = "devel")
```

# 4 Case-study

## 4.1 Study subject

The FGENTCARD cohort is a Lebanese clinical cohort of patients with/without coronary artery disease (CAD) (Platt *et al.* [2015](#ref-platt2015)). Plasma samples from this cohort were profiled by 1H NMR, to identify metabolites associated with risk factors of CAD. In this case study, we describe how the “MWASTools” package was used to identify metabolites associated with type II diabetes (T2D).

## 4.2 Metabonomic data

1H NMR plasma spectra were acquired on a Bruker Avance III 600 MHz spectrometer, in a randomized design. Quality control (QC) samples, composed of identical aliquots of a representative pool of the experimental samples, were injected regularly throughout the run. Following phasing and baseline correction in TopSpin 3.2 software, the spectra were calibrated to the glucose alpha anomeric signal at δ 5.23 (Pearce *et al.* [2008](#ref-pearce2008)) and aligned using recursive segment-wise peak alignment (Veselkov *et al.* [2009](#ref-veselkov2009)). For simplification purposes, this case study focuses on the analysis of the spectral region: δ 1.60 - 0.80

## 4.3 Clinical data

For each patient of the cohort, information regarding age, gender, T2D status, and body mass index (BMI) was recorded.

## 4.4 Load data

First we loaded the “MWASTools” package:

```
library(MWASTools)
```

We then loaded the dataset required to perform the analysis:

```
data("metabo_SE")
metabo_SE
```

```
## class: SummarizedExperiment
## dim: 595 516
## metadata(0):
## assays(1): metabolic_data
## rownames(595): 0.80006656 0.80141232 ... 1.59810224 1.599448
## rowData names(0):
## colnames(516): P1 P2 ... QC9 QC10
## colData names(5): Age Gender T2D BMI sample_type
```

metabo\_SE is a SummarizedExperiment object, generated
with the function “MWAS\_SummarizedExperiment()”, and containing the following information:
- *metabolic\_data*: matrix containing the 1H NMR profiles (δ 1.60 -
0.80) of the experimental samples (n = 506) and the QC samples (n = 10).
- *clinical\_data*: matrix containing clinical data (age, gender, T2D and BMI)
and sample type information (i.e. experimental or QC sample).

## 4.5 Quality control (QC) analysis

To ensure the stability and reproducibility of the analytical run, we performed QC analysis based on principal component analysis (PCA) and coefficient of variation (CV) (sd/mean) across the QC samples (Dumas *et al.* [2006](#ref-dumas2006)).

```
# PCA model
PCA_model = QC_PCA(metabo_SE, scale = FALSE, center = TRUE)

# Plot PCA scores (PC1 vs PC2 & PC3 vs PC4)
par(mfrow = c(1, 2))
QC_PCA_scoreplot(PCA_model, metabo_SE, main = "PC1 vs PC2")
QC_PCA_scoreplot(PCA_model, metabo_SE, px = 3, py = 4, main = "PC3 vs PC4")
```

![](data:image/png;base64...)

In both score plots, the QC samples appear tightly clustered in the center of the Hotelling´s ellipse confirming the absence of batch effects, and ensuring the
reproducibility of the analytical run.

Following QC analysis *via* PCA, we calculated the CVs of the NMR signals across the QC samples. Notice that CV = 0.30 and CV = 0.15 are the thresholds established by the FDA (U.S. Food and Drug Administration) for biomarker discovery and quantification, respectively.

```
# CV calculation
metabo_CV = QC_CV(metabo_SE, plot_hist = FALSE)

# NMR spectrum colored according to CVs
CV_spectrum = QC_CV_specNMR(metabo_SE, ref_sample = "QC1")
```

![](data:image/png;base64...)

The results from CV analysis show that most metabolic features
exhibit low CV values (99 % with CV < 0.30 and 92 % with CV < 0.15), further confirming the reproducibility of the dataset. The metabolic matrix was then CV-filtered to remove
non-reproducible features:

```
# Filter metabolic-matrix based on a CV cut-off of 0.30
metabo_SE = CV_filter(metabo_SE, metabo_CV, CV_th = 0.3)
```

## 4.6 Metabolome-wide associations

In order to identify metabolites associated with T2D, we run logistic regression models between T2D and each NMR variable, adjusted for age, gender, and BMI. To correct the p-values for multiple-testing we used Benjamini-Hochberg (BH) correction.

```
# Run MWAS
MWAS_T2D = MWAS_stats(metabo_SE, disease_id = "T2D",
    confounder_ids = c("Age", "Gender", "BMI"), assoc_method = "logistic",
    mt_method = "BH")
```

*MWAS\_T2D* is 3-column matrix, with the metabolic features (ppm values) in the rows. The columns contain the following information: estimates (i.e. beta coefficients), raw p-values and BH-corrected p-values (pFDR). These results were visualized using the function “MWAS\_skylineNMR( )”.

```
# Visualize MWAS results
skyline = MWAS_skylineNMR(metabo_SE, MWAS_T2D, ref_sample = "QC1")
```

![](data:image/png;base64...)

## 4.7 NMR metabolite assignment using STOCSY

We then used STOCSY to assign the unknown NMR signals associated with T2D. An illustrative example using δ 1.04 as driver signal is shown below.

```
stocsy = STOCSY_NMR(metabo_SE, ppm_query = 1.04)
```

![](data:image/png;base64...)

The STOCSY plot shows the covariance (height) and the correlation (color) of each NMR signal with the driver signal. The most highlighted signals of the plot are two doublets at δ 1.04 and at δ 0.99, indicating that the unknown signal corresponds to valine.

## 4.8 Mapping metabolites of interest onto KEGG pathways

Finally, we mapped some of the metabolites of interest
detected by MWAS analysis (valine “cpd:C00183” and isoleucine “cpd:C00407”) onto
the KEGG pathways.

```
kegg_pathways = MWAS_KEGG_pathways(metabolites = c("cpd:C00183", "cpd:C00407"))
head(kegg_pathways[, c(2, 4)])
```

```
##            compound_name pathway_name
## cpd:C00183 "cpd:C00183"  "Valine, leucine and isoleucine degradation"
## cpd:C00183 "cpd:C00183"  "Valine, leucine and isoleucine biosynthesis"
## cpd:C00183 "cpd:C00183"  "Penicillin and cephalosporin biosynthesis"
## cpd:C00183 "cpd:C00183"  "Cyanoamino acid metabolism"
## cpd:C00183 "cpd:C00183"  "Pantothenate and CoA biosynthesis"
## cpd:C00183 "cpd:C00183"  "Glucosinolate biosynthesis"
```

This function also exported a network file that allows
generating a pathway-based metabolic network in Cytoscape (Shannon *et al.* [2003](#ref-shanon2003)), as shown
below. In this network, human pathways are highlighted and the color of the edges
indicates pathway class.

![](data:image/png;base64...)

# References

Cloarec, O., Dumas, M.E., Craig, A., Barton, R.H., Trygg, J., Hudson, J., Blancher, C., Gauguier, D., Lindon, J.C., Holmes, E. & Nicholson, J.K. (2005). Statistical total correlation spectroscopy: An exploratory approach for latent biomarker identification from metabolic 1HNMR data sets. *Analytical Chemistry*, **77**, 1282–1289. Retrieved from <http://pubs.acs.org/doi/10.1021/ac048630x>

Dumas, M.E., Maibaum, E.C., Ueshima, H., Zhou, B., Lindon, J.C., Nicholson, J.K., Stamler, J., Elliot, P., Chan, Q. & Holmes, E. (2006). Assessment of analytical reproducibility of 1HNMR spectroscopy based metabonomics for large-scale epidemiological research: The intermap study. *Analytical Chemistry*, **78**, 2199–2208. Retrieved from <http://pubs.acs.org/doi/10.1021/ac0517085>

Elliott, P., Posma, J.M., Chan, Q., Garcia-Perez, I., Wijeyesekera, A., Bictash, M., Ebbels, T.M., Ueshima, H., Zhao, L., Van-Horn, L., Daviglus, M., Stamler, J., Holmes, E. & Nicholson, J.K. (2015). Urinary metabolic signatures of human adiposity. *Science Translational Medicine*, **7**, 285ra62. Retrieved from <http://stm.sciencemag.org/content/7/285/285ra62>

Gaude, R., Chignola, F., Spiliotopoulos, D., Spitaleri, A., Ghitti, M., Garcia-Manteiga, J., Mari, S. & Musco, G. (2013). Muma, an r package for metabolomics univariate and multivariate statistical analysis. *Current Metabolomics*, **1**, 180–189. Retrieved from <http://dx.doi.org/10.2174/2213235X11301020005>

Holmes, E., Loo, R.L., Stamler, J., Bictash, M., Yap, I.K., Chang, Q., Ebbels, T., De-Iorio, M., Brown, I.J., Veselkov, K.A., Daviglus, M.L., Kesteloot, H., Ueshima, H., Zhao, L., Nicholson, J.K. & Elliott, P. (2008). Human metabolic phenotype diversity and its association with diet and blood pressure. *Nature*, **453**, 396–400. Retrieved from <http://www.nature.com/nature/journal/v453/n7193/full/nature06882.html>

Kanehisa, M. & Goto, S. (2000). KEGG: Kyoto encyclopedia of genes and genomes. *Nucleic Acids Research*, **28**, 27–30. Retrieved from <http://nar.oxfordjournals.org/content/28/1/27>

Nicholson, J.K., Connelly, J., Lindon, J.C. & Holmes, E. (2002). Metabonomics: A platform for studying drug toxicity and gene function. *Nature Reviews Drug Discovery*, **1**, 153–161. Retrieved from <http://www.nature.com/nrd/journal/v1/n2/full/nrd728.html>

Pearce, J.T.M., Athersuch, T.J., Ebbels, T.M.D., Lindon, J.C., Nicholson, J.K. & Keun, H.C. (2008). Robust algorithms for automated chemical shift calibration of 1D 1HNMR spectra of blood serum, analytical chemistry. *Analytical Chemistry*, **80**, 7158–7162. Retrieved from <http://pubs.acs.org/doi/10.1021/ac8011494>

Platt, D.E., Ghassibe-Sabbagh, M., Youhanna, S., Hager, J., Cazier, J., Kamatani, Y., Salloum, A., Haber, M., Romanos, J., Doueihy, B., Mouzaya, F., Kibbani, S., Sbeite, H., Deeb, M.E., Chammas, E., El-Bayeh, H., Khazen, G., Gauguier, D., Zalloua, P.A. & Abchee, A.B. (2015). Circulating lipid levels and risk of coronary artery disease in a large group of patients undergoing coronary angiography. *Journal of Thrombosis and Thrombolysis*, **39**, 15–22. Retrieved from [http://link.springer.com/article/10.1007%2Fs11239-014-1069-2](http://link.springer.com/article/10.1007/s11239-014-1069-2)

Shannon, P., Markiel, A., Ozier, O., Baliga, N.S., Wang, J.T., Ramage, D., Amin, N. & Ideker, B.S.T. (2003). Cytoscape: A software environment for integrated models of biomolecular interaction networks. *Genome Research*, **13**, 2498–2504. Retrieved from <http://genome.cshlp.org/content/13/11/2498>

Thevenot, E., Roux, A., Xu, Y., Ezan, E. & Junot, C. (2015). Analysis of the human adult urinary metabolome variations with age, body mass index, and gender by implementing a comprehensive workflow for univariate and opls statistical analyses. *Journal of Proteome Research*, **14**, 3322–3335. Retrieved from <http://pubs.acs.org/doi/abs/10.1021/acs.jproteome.5b00354>

Veselkov, K.A., Lindon, J.C., Ebbels, T.M., Crockford, D., Volynkin, W., Holmes, E., Davies, D.B. & Nicholson, J.K. (2009). Recursive segment-wise peak alignment of biological 1HNMR spectra for improved metabolic biomarker recovery. *Analytical Chemistry*, **81**, 56–66. Retrieved from <http://pubs.acs.org/doi/10.1021/ac8011544>