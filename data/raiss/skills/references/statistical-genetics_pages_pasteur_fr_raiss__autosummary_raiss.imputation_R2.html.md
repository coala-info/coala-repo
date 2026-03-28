[RAISS](../index.html)

* [raiss.imputation\_launcher](raiss.imputation_launcher.html)
* [raiss.ld\_matrix](raiss.ld_matrix.html)
* [raiss.stat\_models](raiss.stat_models.html)
* [raiss.windows](raiss.windows.html)
* [raiss.filter\_format\_output](raiss.filter_format_output.html)
* raiss.imputation\_R2

[RAISS](../index.html)

* raiss.imputation\_R2
* [View page source](../_sources/_autosummary/raiss.imputation_R2.rst.txt)

---

# raiss.imputation\_R2[](#module-raiss.imputation_R2 "Link to this heading")

Module for imputation performance evaluation

Functions to generate test dataset with missing SNPs, impute missing SNPs
and compare precision with original dataset.

In other word, this module provides function to empirically measure imputation R2 on independant dataset.

Functions

|  |  |
| --- | --- |
| `generated_test_data`(zscore[, N\_to\_mask, ...]) | Mask N\_to\_mask Snps in the dataframe zscore and return the dataframe with missing SNPs. |
| `grid_search`(zscore\_folder, masked\_folder, ...) | Compute the imputation performance for several eigen ratioself. The procedure is the following: \* Masked N\_to\_mask Snps in the input dataset (chosen at random) \* for eigen ratio in **eigen\_ratio\_grid**: \* Impute SNPs \* Compute performance on masked SNPs (R-square and mean absolute error) :param zscore\_folder: path toward the input data folder :type zscore\_folder: str :param masked\_folder: path toward the folder to save the dataframe with masked SNPs :type masked\_folder: str :param output\_folder: path toward the folder to save the imputed dataframe :type output\_folder: str :param ref\_folder: path toward the folder to save the imputed dataframe :type ref\_folder: str :param ld\_folder: path toward the Linkage desiquilibrium matrices to save the imputed dataframe :type ld\_folder: str :param gwas: gwas identifier in the following format : 'CONSORTIA\_TRAIT' :type gwas: str :param chrom: chromosome in the format "chr.." :type chrom: str :param eigen\_ratio\_grid: list of eigen\_ratio to test (must be between 0 and 1) :type eigen\_ratio\_grid: list :param ld\_threshold\_grid: list of minimum-ld to test (must be > 0 ) :type ld\_threshold\_grid: list :param window\_size: imputation parameter (see raiss command line documentation) :param buffer\_size: imputation parameter (see raiss command line documentation) :param l2\_regularization: imputation parameter (see raiss command line documentation) :param R2\_threshold: imputation parameter (see raiss command line documentation) :param N\_to\_mask: Number of SNPs masked in the initial dataset to compute the correlation between true value and imputed value :type N\_to\_mask: int :param ref\_panel\_suffix: suffix :type ref\_panel\_suffix: str :param ld\_type: The type of file where the LD is stored should be 'plink' or 'scipy' :type ld\_type: str :param stratifying\_vector: a continuous vector containin one value per SNPs used to stratify the sampling of SNPs to mask :type stratifying\_vector: pd.Series :param stratifying\_bins: a vector specifying the boundary values to form the bins :type stratifying\_bins: list. |
| `imputation_performance`(zscore\_initial, ...) | Compute imputation performance on real data the performance is computed as the correlation between imputed and real values and as the mean absolute deviation between imputed and real values :param zscore\_initial: :type zscore\_initial: pandas DataFrame :param zscore\_imputed: :type zscore\_imputed: pandas DataFrame :param masked: SNPs ids which have been masked by imputation |
| `z_amplitude_effect`(zscore\_folder, ...[, ...]) | Compute the imputation performance on SNPs with different amplitude The procedure is the following: \* Masked Snps in the input dataset in function of the amplitude |

[Previous](raiss.filter_format_output.html "raiss.filter_format_output")

---

© Copyright 2018, hjulienne.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).