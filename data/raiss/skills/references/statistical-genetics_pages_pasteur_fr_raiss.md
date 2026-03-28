RAISS

* [raiss.imputation\_launcher](_autosummary/raiss.imputation_launcher.html)
* [raiss.ld\_matrix](_autosummary/raiss.ld_matrix.html)
* [raiss.stat\_models](_autosummary/raiss.stat_models.html)
* [raiss.windows](_autosummary/raiss.windows.html)
* [raiss.filter\_format\_output](_autosummary/raiss.filter_format_output.html)
* [raiss.imputation\_R2](_autosummary/raiss.imputation_R2.html)

RAISS

* Welcome to the Robust and Accurate Imputation from Summary Statistics (RAISS) documentation!
* [View page source](_sources/index.rst.txt)

---

# Welcome to the Robust and Accurate Imputation from Summary Statistics (RAISS) documentation![](#welcome-to-the-robust-and-accurate-imputation-from-summary-statistics-raiss-documentation "Link to this heading")

# What is RAISS ?[](#what-is-raiss "Link to this heading")

RAISS is a python package to impute missing SNP summary statistics from
neighboring SNPs in linkage desiquilibrium.

The statistical model used to make the imputation is described in [[PZS+14](#id10 "Bogdan Pasaniuc, Noah Zaitlen, Huwenbo Shi, Gaurav Bhatia, Alexander Gusev, Joseph Pickrell, Joel Hirschhorn, David P. Strachan, Nick Patterson, and Alkes L. Price. Fast and accurate imputation of summary statistics enhances evidence of functional enrichment. Bioinformatics (Oxford, England), 30(20):2906–2914, 2014. arXiv:arXiv:1309.3258v1, doi:10.1093/bioinformatics/btu416.")], [[LBR+13](#id12 "Donghyung Lee, T Bernard Bigdeli, Brien P Riley, Ayman H Fanous, and Silviu-Alin Bacanu. Dist: direct imputation of summary statistics for unmeasured snps. Bioinformatics, 29(22):2925–2927, 2013.")] and [[JSPA19](#id8 "Hanna Julienne, Huwenbo Shi, Bogdan Pasaniuc, and Hugues Aschard. RAISS: robust and accurate imputation from summary statistics. Bioinformatics, 35(22):4837-4839, 06 2019. URL: https://doi.org/10.1093/bioinformatics/btz466, arXiv:https://academic.oup.com/bioinformatics/article-pdf/35/22/4837/30706731/btz466.pdf, doi:10.1093/bioinformatics/btz466.")].
The implementation and performances of RAISS are described in [[JSPA19](#id8 "Hanna Julienne, Huwenbo Shi, Bogdan Pasaniuc, and Hugues Aschard. RAISS: robust and accurate imputation from summary statistics. Bioinformatics, 35(22):4837-4839, 06 2019. URL: https://doi.org/10.1093/bioinformatics/btz466, arXiv:https://academic.oup.com/bioinformatics/article-pdf/35/22/4837/30706731/btz466.pdf, doi:10.1093/bioinformatics/btz466.")].

The imputation execution time is optimized by precomputing Linkage desiquilibrium between SNPs.

# Dependencies[](#dependencies "Link to this heading")

If you need to compute LD matrices from your reference panel,
RAISS requires plink version 1.9 for the precomputation of LD: <https://www.cog-genomics.org/plink2>

# Installation[](#installation "Link to this heading")

```
pip3 install git+https://gitlab.pasteur.fr/statistical-genetics/raiss.git
pip3 install -r https://gitlab.pasteur.fr/statistical-genetics/raiss/-/raw/master/requirements.txt
```

Alternatively, RAISS is available as a docker container:

<https://quay.io/repository/biocontainers/raiss?tab=tags>

# Precomputation of LD-correlation[](#precomputation-of-ld-correlation "Link to this heading")

The imputation is based the Linkage desiquilibrium
between SNPs.

To save computation time, the LD is computed before imputation and saved as tabular format.
To limit the number of SNP pairs, the LD is computed between pairs of
SNPs in a approximately LD-independent regions. Regions defined by [[BP15](#id11 "Tomaz Berisa and Joseph K. Pickrell. Approximately independent linkage disequilibrium blocks in human populations. Bioinformatics, 32(2):283–285, 2015. doi:10.1093/bioinformatics/btv546.")] or computed using
[bigsnpr](https://privefl.github.io/bigsnpr/reference/snp_ldsplit.html) ([[Pri21](#id9 "Florian Privé. Optimal linkage disequilibrium splitting. Bioinformatics, 38(1):255-256, 07 2021. URL: https://doi.org/10.1093/bioinformatics/btab519, arXiv:https://academic.oup.com/bioinformatics/article-pdf/38/1/255/41891000/btab519.pdf, doi:10.1093/bioinformatics/btab519.")]) are provided in the package
data folder for all several genome build and ancestries.

To compute the LD you need to specify a reference panel splitted by chromosomes
(bed, fam and bim formats of plink, see [PLINK formats](https://www.cog-genomics.org/plink2/formats) )

```
# path to the Region file
region_berisa = "/mnt/atlas/PCMA/WKD_Hanna/cleaned_jass_input/Region_LD.csv"
# Path to the reference panel
ref_folder="/mnt/atlas/PCMA/1._DATA/ImpG_refpanel"
# path to the folder to store the results
ld_folder_out = "/mnt/atlas/PCMA/WKD_Hanna/impute_for_jass/berisa_ld_block"
raiss.LD.generate_genome_matrices(, ...)
```

Since 2021, LD can also be specified as scipy sparse matrix (.npz), the index must be provided in a separate file (one id by line)

# Input format:[](#input-format "Link to this heading")

GWAS results files must be provided in the tabular format by chromosome (tab separated)
all in the same folder with the following columns with the same header:

| rsID | pos | A0 | A1 | Z |
| --- | --- | --- | --- | --- |
| rs6548219 | 30762 | A | G | -1.133 |

The files names must follow this pattern “z\_{GWAS\_TAG}\_chr{1..22}.txt”
This format can be obtained with the [JASS PreProcessing package](https://gitlab.pasteur.fr/statistical-genetics/JASS_Pre-processing).

# Launching imputation on one chromosome[](#launching-imputation-on-one-chromosome "Link to this heading")

RAISS has an interface with the command line.

Here is an example for imputing the file z\_FINNS\_IL-6\_chr22.txt

```
raiss --chrom chr22 --gwas FINNS_IL-6 --ld-folder ${path-to-ld-matrices} --ref-folder ${path-to-the-reference-panel}  --zscore-folder ${path-to-input data} --output-folder ${folder to store imputed files} --eigen-threshold 0.000001
```

see details and all parameters in Command Line Usage bellow and note that the eigen\_threshold parameter should be adapted to your reference panel (see the **Optimizing RAISS parameters for your data** section)

If you have access to a cluster, an efficient way to use RAISS is to launch
the imputation of each chromosome on a separate cluster node. The script
[launch\_imputation\_all\_gwas.sh](https://gitlab.pasteur.fr/statistical-genetics/raiss/blob/master/scripts/launch_imputation_all_gwas.sh)
contain an example of raiss usage with a SLURM scheduler.

# Output[](#output "Link to this heading")

The raiss package outputs imputed GWAS files in the tabular format:

| rsID | pos | A0 | A1 | Z | Var | ld\_score | imputation\_R2 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| rs3802985 | 198510 | T | C | 0.334 | -1.0 | inf | 2.0 |
| rs111876722 | 201922 | C | T | 0.297 | 0.09 | 5.412 | 0.91578 |

*Variance is set to -1 for variants present in the input dataset*

# Optimizing RAISS parameters for your data[](#optimizing-raiss-parameters-for-your-data "Link to this heading")

Raiss package contains a subcommand **raiss performance-grid-search**
to assess its performance on your data and fine tune RAISS parameter.

Test procedure :
1. Mask N SNPs on a chromosome
2. Impute masked files for different values of the –eigen-threshold
and the –minimum-ld parameters
3. Compute correlation (and other statistics) between genotype Z-values to imputed Z-values

To perform this test follow this procedure :

1. Create a folder to store masked z-score files
2. Create a folder to store z-score files imputed with different parameter
3. Adapt the following command snippet to apply the command to your data:

Here the command example run for the harmonized GWAS files z\_FINNS-IL-6.txt for eigen\_threshold values in [0.000001, 0.001,0.1] and ld-threshold in [0,10,20].
Note that if you allocate more than 1 cpu to the job, different parameter combination will be tested in parallel.

```
raiss --ld-folder ${path-to-ld-matrices} --ref-folder ${path-to-the-reference-panel} --gwas FINNS_IL-6 --chrom chr22 --ld-type ${'scipy' or 'plink'} performance-grid-search --harmonized-folder ${path-to-harmonized data} --masked-folder ${folder to store partially masked input data} --imputed-folder $ --output-path ${path-to-save the performance report} --eigen-ratio-grid '[0.000001, 0.001,0.1]' --ld-threshold-grid '[0,10,20]' --n-cpu ${number of cpu to be allocated to the job}
```

The file Perf\_GWAS\_TAG (Perf\_FINNS\_IL-6 here) ressembles the following output:

Performance Report[](#id13 "Link to this table")

| eigen\_ratio | min\_ld | N\_SNP | fraction\_imputed | cor | mean\_absolute\_error | median\_absolute\_error | min\_absolute\_error | max\_absolute\_error | SNP\_max\_error |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 0.1 | 0 | 2970 | 0.594 | 0.978 | 0.277 | 0.171 | 1.47e-05 | 6.92 | rs5756504 |
| 0.1 | 2 | 2970 | 0.594 | 0.978 | 0.277 | 0.171 | 1.47e-05 | 6.92 | rs5756504 |
| 0.1 | 5 | 2840 | 0.568 | 0.978 | 0.277 | 0.169 | 1.47e-05 | 6.92 | rs5756504 |
| 0.1 | 7 | 2550 | 0.51 | 0.978 | 0.275 | 0.164 | 0.000285 | 6.92 | rs5756504 |
| 0.15 | 0 | 2470 | 0.494 | 0.976 | 0.282 | 0.172 | 2.43e-05 | 4.22 | rs59411032 |
| 0.15 | 2 | 2470 | 0.494 | 0.976 | 0.282 | 0.172 | 2.43e-05 | 4.22 | rs59411032 |
| 0.15 | 5 | 2450 | 0.49 | 0.976 | 0.281 | 0.172 | 2.43e-05 | 4.22 | rs59411032 |
| 0.15 | 7 | 2320 | 0.465 | 0.976 | 0.282 | 0.172 | 0.00044 | 4.22 | rs59411032 |
| 0.2 | 0 | 2040 | 0.409 | 0.973 | 0.291 | 0.168 | 6.61e-05 | 4.37 | rs5752798 |
| 0.2 | 2 | 2040 | 0.409 | 0.973 | 0.291 | 0.168 | 6.61e-05 | 4.37 | rs5752798 |
| 0.2 | 5 | 2040 | 0.408 | 0.973 | 0.291 | 0.168 | 6.61e-05 | 4.37 | rs5752798 |
| 0.2 | 7 | 2020 | 0.403 | 0.973 | 0.291 | 0.168 | 6.61e-05 | 4.37 | rs5752798 |

* **eigen\_ratio** : eigen ratio parameter that was tested.
* **min\_ld** : eigen ratio parameter that was tested.
* **N\_SNP** : number of the masked SNPs that were successfully imputed (i.e. not filtered out by the R2 criteria and/or min\_ld criteria)
* **fraction\_imputed** : fraction of the masked SNPs that were successfully imputed (N\_SNP / total\_number\_of\_masked\_SNP)
* **cor** : the correlation between imputed and genotyped Z-scores.
* **mean\_absolute\_error** : \(\mathbb{E}|Z\_{imputed} - Z\_{masked}|\)
* **median\_absolute\_error** : \(median|Z\_{imputed} - Z\_{masked}|\)
* **min\_absolute\_error** : \(min|Z\_{imputed} - Z\_{masked}|\)
* **max\_absolute\_error** : \(max|Z\_{imputed} - Z\_{masked}|\)
* **SNP\_max\_error** : \(argmax|Z\_{imputed} - Z\_{masked}|\)

To pick the best parameters, we recommend to search for a compromise between low imputation error and an high fraction of masked SNPs imputed
(a trade-off between **fraction\_imputed** and **mean\_absolute\_error**).

The optimal eigen\_ratio and min\_ld can vary depending on the density of your reference panel and input data.
Hence, we recommend to run a grid search to pick the best parameter for your data.
However, so far, we never observed a difference of performance from one chromosome to another.
We suggest testing on the chr22 for computational efficiency. Note that this performance report
evaluate RAISS on limited number of SNPs. Hence, we recommend to complement this report with our sanity check report\_snps
that check if the number of new genome wide significant hits is coherent with the number of imputes SNPs.

# Generating report and sanity ckecks[](#generating-report-and-sanity-ckecks "Link to this heading")

Once you have imputed your dataset, you might want to know how many SNPs have been imputed and
with which imputation quality. More importantly, you might want to make sure that the distribution
of imputed signal is coherent with what is expected.

Indeed, if the population of your reference panel is too different from the one of your study, the Linkage
desequilibrium matrices derived from your panel might not be adapted and might generate false positive

To run a sanity check on your data use the **raiss sanity-check** command

```
raiss sanity-check --trait z_{trait} --harmonized-folder {folder_input_data_files} --imputed-folder {folder_imputed_files}
```

Here is a sanity check log example :

```
Number of SNPs
in harmonized file: 7245111
in imputed file: 10665361
Proportion imputed : 0.32068769167775946

Number of SNPs by level of significance
                 harmonized  harmonized_by_1Mbregion  imputed  imputed_by_1MBregion  imputed_proportion  imputed_hit_OR
5.00e-02-1.00e+00     6506492                       16  9628715                    14            0.324262        0.932818
5.00e-06-5.00e-02      738573                     2682  1036583                  2684            0.287493        0.999821
5.00e-08-5.00e-06          43                       17       60                    20            0.283333        1.080485
0.00e+00-5.00e-08           3                        1        3                     1            0.000000        0.999448

Number of imputed SNPs by level of imputation quality
(0.8, 0.9]     2086501
(0.6, 0.8]     1333749
(0.0, 0.6]           0
(0.9, 0.95]          0
(0.95, 1.0]          0
```

The first block of the log gives you information about total number of SNPs
contained in the harmonized file and imputed file.

The second block reports the number of SNPs by significance strata in the harmonized file and imputed file.
the \_by\_1MBregion columns reports the number of 1Mb region reaching significance (minimal p-value of snps contained in the region).
This provide you with a rough estimate of the number of LD independent hits before and after imputation.
the imputed\_hit\_OR compares the imputed\_by\_1MBregion and harmonized\_by\_1Mbregion and reports if the number of new hit in imputed data
is reasonable knowing the increased coverage.

The third block provides the number of imputed SNPs by imputation quality strata.

# Command Line Usage[](#command-line-usage "Link to this heading")

raiss command launch imputation for one trait on one chromosome

```
usage: raiss [-h] [--chrom CHROM] [--gwas GWAS] [--ref-folder REF_FOLDER]
             [--ld-folder LD_FOLDER] [--zscore-folder ZSCORE_FOLDER]
             [--output-folder OUTPUT_FOLDER] [--window-size WINDOW_SIZE]
             [--buffer-size BUFFER_SIZE]
             [--l2-regularization L2_REGULARIZATION]
             [--eigen-threshold EIGEN_THRESHOLD] [--R2-threshold R2_THRESHOLD]
             [--ld-type LD_TYPE] [--ref-panel-prefix REF_PANEL_PREFIX]
             [--ref-panel-suffix REF_PANEL_SUFFIX] [--minimum-ld MINIMUM_LD]
             {sanity-check,performance-grid-search} ...
```

## Named Arguments[](#named-arguments "Link to this heading")

`--chrom`
:   chromosome to impute to the chrd+ format

`--gwas`
:   GWAS to impute to the consortia\_trait format

`--ref-folder`
:   reference panel location (used to determine which snp to impute)

`--ld-folder`
:   Location LD correlation matrices

`--zscore-folder`
:   Location of the zscore files of the gwases to impute

`--output-folder`
:   Location of the impute zscore files

`--window-size`
:   Size of the no