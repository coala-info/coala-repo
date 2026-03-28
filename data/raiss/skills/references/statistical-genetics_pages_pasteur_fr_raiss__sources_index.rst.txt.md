.. RAISS documentation master file, created by
sphinx-quickstart on Mon Aug 20 16:17:59 2018.
You can adapt this file completely to your liking, but it should at least
contain the root `toctree` directive.
Welcome to the Robust and Accurate Imputation from Summary Statistics (RAISS) documentation!
============================================================================================
.. toctree::
:caption: Table of Contents
:maxdepth: 2
index
What is RAISS ?
===============
RAISS is a python package to impute missing SNP summary statistics from
neighboring SNPs in linkage desiquilibrium.
The statistical model used to make the imputation is described in :cite:`Pasaniuc2014`, :cite:`lee2013dist` and :cite:`Julienne2019`.
The implementation and performances of RAISS are described in :cite:`Julienne2019`.
The imputation execution time is optimized by precomputing Linkage desiquilibrium between SNPs.
Dependencies
============
If you need to compute LD matrices from your reference panel,
RAISS requires plink version 1.9 for the precomputation of LD: ``\_
Installation
============
.. code-block:: shell
pip3 install git+https://gitlab.pasteur.fr/statistical-genetics/raiss.git
pip3 install -r https://gitlab.pasteur.fr/statistical-genetics/raiss/-/raw/master/requirements.txt
Alternatively, RAISS is available as a docker container:
https://quay.io/repository/biocontainers/raiss?tab=tags
Precomputation of LD-correlation
=================================
The imputation is based the Linkage desiquilibrium
between SNPs.
To save computation time, the LD is computed before imputation and saved as tabular format.
To limit the number of SNP pairs, the LD is computed between pairs of
SNPs in a approximately LD-independent regions. Regions defined by :cite:`Berisa2015` or computed using
`bigsnpr `\_ (:cite:`privee2022`) are provided in the package
data folder for all several genome build and ancestries.
To compute the LD you need to specify a reference panel splitted by chromosomes
(bed, fam and bim formats of plink, see `PLINK formats `\_ )
.. code-block:: python
# path to the Region file
region\_berisa = "/mnt/atlas/PCMA/WKD\_Hanna/cleaned\_jass\_input/Region\_LD.csv"
# Path to the reference panel
ref\_folder="/mnt/atlas/PCMA/1.\_DATA/ImpG\_refpanel"
# path to the folder to store the results
ld\_folder\_out = "/mnt/atlas/PCMA/WKD\_Hanna/impute\_for\_jass/berisa\_ld\_block"
raiss.LD.generate\_genome\_matrices(, ...)
Since 2021, LD can also be specified as scipy sparse matrix (.npz), the index must be provided in a separate file (one id by line)
Input format:
=============
GWAS results files must be provided in the tabular format by chromosome (tab separated)
all in the same folder with the following columns with the same header:
+----------+-------+------+-----+--------+
| rsID | pos | A0 | A1 | Z |
+==========+=======+======+=====+========+
| rs6548219| 30762 | A | G | -1.133 |
+----------+-------+------+-----+--------+
The files names must follow this pattern "z\_{GWAS\_TAG}\_chr{1..22}.txt"
This format can be obtained with the `JASS PreProcessing package `\_.
Launching imputation on one chromosome
======================================
RAISS has an interface with the command line.
Here is an example for imputing the file z\_FINNS\_IL-6\_chr22.txt
.. code-block:: shell
raiss --chrom chr22 --gwas FINNS\_IL-6 --ld-folder ${path-to-ld-matrices} --ref-folder ${path-to-the-reference-panel} --zscore-folder ${path-to-input data} --output-folder ${folder to store imputed files} --eigen-threshold 0.000001
see details and all parameters in Command Line Usage bellow and note that the eigen\_threshold parameter should be adapted to your reference panel (see the \*\*Optimizing RAISS parameters for your data\*\* section)
If you have access to a cluster, an efficient way to use RAISS is to launch
the imputation of each chromosome on a separate cluster node. The script
`launch\_imputation\_all\_gwas.sh `\_
contain an example of raiss usage with a SLURM scheduler.
Output
======
The raiss package outputs imputed GWAS files in the tabular format:
+-------------+----------+------------+------------+---------+-------+----------+---------------+
| rsID | pos | A0 | A1 | Z | Var | ld\_score | imputation\_R2 |
+=============+==========+============+============+=========+=======+==========+===============+
| rs3802985 | 198510 | T | C | 0.334 | -1.0 | inf | 2.0  |
+-------------+----------+------------+------------+---------+-------+----------+---------------+
| rs111876722 | 201922 | C | T | 0.297 | 0.09 | 5.412 | 0.91578 |
+-------------+----------+------------+------------+---------+-------+----------+---------------+
\*Variance is set to -1 for variants present in the input dataset\*
Optimizing RAISS parameters for your data
========================================
Raiss package contains a subcommand \*\*raiss performance-grid-search\*\*
to assess its performance on your data and fine tune RAISS parameter.
Test procedure :
1. Mask N SNPs on a chromosome
2. Impute masked files for different values of the --eigen-threshold
and the --minimum-ld parameters
3. Compute correlation (and other statistics) between genotype Z-values to imputed Z-values
To perform this test follow this procedure :
1. Create a folder to store masked z-score files
2. Create a folder to store z-score files imputed with different parameter
3. Adapt the following command snippet to apply the command to your data:
Here the command example run for the harmonized GWAS files z\_FINNS-IL-6.txt for eigen\_threshold values in [0.000001, 0.001,0.1] and ld-threshold in [0,10,20].
Note that if you allocate more than 1 cpu to the job, different parameter combination will be tested in parallel.
.. code-block:: shell
raiss --ld-folder ${path-to-ld-matrices} --ref-folder ${path-to-the-reference-panel} --gwas FINNS\_IL-6 --chrom chr22 --ld-type ${'scipy' or 'plink'} performance-grid-search --harmonized-folder ${path-to-harmonized data} --masked-folder ${folder to store partially masked input data} --imputed-folder $ --output-path ${path-to-save the performance report} --eigen-ratio-grid '[0.000001, 0.001,0.1]' --ld-threshold-grid '[0,10,20]' --n-cpu ${number of cpu to be allocated to the job}
The file Perf\_GWAS\_TAG (Perf\_FINNS\_IL-6 here) ressembles the following output:
.. csv-table:: Performance Report
:widths: 10, 10, 10,10, 10, 10,10,10,10,10
:header-rows: 1
"eigen\_ratio","min\_ld","N\_SNP","fraction\_imputed","cor","mean\_absolute\_error","median\_absolute\_error","min\_absolute\_error","max\_absolute\_error","SNP\_max\_error"
0.1,0,2970,0.594,0.978,0.277,0.171,1.47e-05,6.92,"rs5756504"
0.1,2,2970,0.594,0.978,0.277,0.171,1.47e-05,6.92,"rs5756504"
0.1,5,2840,0.568,0.978,0.277,0.169,1.47e-05,6.92,"rs5756504"
0.1,7,2550,0.51,0.978,0.275,0.164,0.000285,6.92,"rs5756504"
0.15,0,2470,0.494,0.976,0.282,0.172,2.43e-05,4.22,"rs59411032"
0.15,2,2470,0.494,0.976,0.282,0.172,2.43e-05,4.22,"rs59411032"
0.15,5,2450,0.49,0.976,0.281,0.172,2.43e-05,4.22,"rs59411032"
0.15,7,2320,0.465,0.976,0.282,0.172,0.00044,4.22,"rs59411032"
0.2,0,2040,0.409,0.973,0.291,0.168,6.61e-05,4.37,"rs5752798"
0.2,2,2040,0.409,0.973,0.291,0.168,6.61e-05,4.37,"rs5752798"
0.2,5,2040,0.408,0.973,0.291,0.168,6.61e-05,4.37,"rs5752798"
0.2,7,2020,0.403,0.973,0.291,0.168,6.61e-05,4.37,"rs5752798"
\* \*\*eigen\_ratio\*\* : eigen ratio parameter that was tested.
\* \*\*min\_ld\*\* : eigen ratio parameter that was tested.
\* \*\*N\_SNP\*\* : number of the masked SNPs that were successfully imputed (i.e. not filtered out by the R2 criteria and/or min\_ld criteria)
\* \*\*fraction\_imputed\*\* : fraction of the masked SNPs that were successfully imputed (N\_SNP / total\_number\_of\_masked\_SNP)
\* \*\*cor\*\* : the correlation between imputed and genotyped Z-scores.
\* \*\*mean\_absolute\_error\*\* : :math:`\mathbb{E}|Z\_{imputed} - Z\_{masked}|`
\* \*\*median\_absolute\_error\*\* : :math:`median|Z\_{imputed} - Z\_{masked}|`
\* \*\*min\_absolute\_error\*\* : :math:`min|Z\_{imputed} - Z\_{masked}|`
\* \*\*max\_absolute\_error\*\* : :math:`max|Z\_{imputed} - Z\_{masked}|`
\* \*\*SNP\_max\_error\*\* : :math:`argmax|Z\_{imputed} - Z\_{masked}|`
To pick the best parameters, we recommend to search for a compromise between low imputation error and an high fraction of masked SNPs imputed
(a trade-off between \*\*fraction\_imputed\*\* and \*\*mean\_absolute\_error\*\*).
The optimal eigen\_ratio and min\_ld can vary depending on the density of your reference panel and input data.
Hence, we recommend to run a grid search to pick the best parameter for your data.
However, so far, we never observed a difference of performance from one chromosome to another.
We suggest testing on the chr22 for computational efficiency. Note that this performance report
evaluate RAISS on limited number of SNPs. Hence, we recommend to complement this report with our sanity check report\_snps
that check if the number of new genome wide significant hits is coherent with the number of imputes SNPs.
Generating report and sanity ckecks
=======================================================
Once you have imputed your dataset, you might want to know how many SNPs have been imputed and
with which imputation quality. More importantly, you might want to make sure that the distribution
of imputed signal is coherent with what is expected.
Indeed, if the population of your reference panel is too different from the one of your study, the Linkage
desequilibrium matrices derived from your panel might not be adapted and might generate false positive
To run a sanity check on your data use the \*\*raiss sanity-check\*\* command
.. code-block:: shell
raiss sanity-check --trait z\_{trait} --harmonized-folder {folder\_input\_data\_files} --imputed-folder {folder\_imputed\_files}
Here is a sanity check log example :
.. code-block:: text
Number of SNPs
in harmonized file: 7245111
in imputed file: 10665361
Proportion imputed : 0.32068769167775946
Number of SNPs by level of significance
harmonized harmonized\_by\_1Mbregion imputed imputed\_by\_1MBregion imputed\_proportion imputed\_hit\_OR
5.00e-02-1.00e+00 6506492 16 9628715 14 0.324262 0.932818
5.00e-06-5.00e-02 738573 2682 1036583 2684 0.287493 0.999821
5.00e-08-5.00e-06 43 17 60 20 0.283333 1.080485
0.00e+00-5.00e-08 3 1 3 1 0.000000 0.999448
Number of imputed SNPs by level of imputation quality
(0.8, 0.9] 2086501
(0.6, 0.8] 1333749
(0.0, 0.6] 0
(0.9, 0.95] 0
(0.95, 1.0] 0
The first block of the log gives you information about total number of SNPs
contained in the harmonized file and imputed file.
The second block reports the number of SNPs by significance strata in the harmonized file and imputed file.
the \_by\_1MBregion columns reports the number of 1Mb region reaching significance (minimal p-value of snps contained in the region).
This provide you with a rough estimate of the number of LD independent hits before and after imputation.
the imputed\_hit\_OR compares the imputed\_by\_1MBregion and harmonized\_by\_1Mbregion and reports if the number of new hit in imputed data
is reasonable knowing the increased coverage.
The third block provides the number of imputed SNPs by imputation quality strata.
Command Line Usage
==================
.. argparse::
:ref: raiss.\_\_main\_\_.add\_chromosome\_imputation\_argument
:prog: raiss
Indices and tables
==================
\* :ref:`genindex`
\* :ref:`modindex`
.. automodule:: raiss
:members:
\* :ref:`search`
.. autosummary::
:toctree: \_autosummary
.. bibliography:: reference.bib