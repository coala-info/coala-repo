FINEMAP

---

[**Command-line arguments**](#cmd) **|** [**Input**](#input) **|** [**Output**](#output) **|** [**Fine-mapping example**](#sss) **|** [**Correlation example**](#corr)

---

FINEMAP is a program for identifying causal SNPs in genomic regions associated with complex traits and disease. FINEMAP is computationally efficient by using summary statistics from genome-wide association studies and robust by using a shotgun stochastic search algorithm (Hans *et al*., 2007). It produces accurate results in a fraction of processing time of existing approaches and is therefore the ideal tool for analyzing growing amounts of data produced in genome-wide association studies and emerging sequencing or biobank projects.

### Download

### ([license](license_finemap_v1.1.html))

* Be aware that FINEMAP v1.1 cannot handle large effect size regions!* [finemap\_v1.1\_MacOSX.tgz (Mac OS X)](finemap_v1.1_MacOSX.tgz)
  * [finemap\_v1.1\_x86\_64.tgz (Unix)](finemap_v1.1_x86_64.tgz)
  * (Updated 20-July-2016)* * To receive email reminders about updates of FINEMAP, send an email to finemap@christianbenner.com.

### Command-line arguments

|  |  |  |  |  |
| --- | --- | --- | --- | --- |
| --corr |  | Determine highly correlated SNPs |  | Subprogram |
| --corr-config |  | The posterior probability of a causal configuration is set to zero if it includes a pair of SNPs with absolute correlation above this threshold |  | Default is 0.95 (with --sss) |
| --corr-filter |  | SNPs are discarded such that no pair of SNPs remains with absolute correlation greater above this threshold |  | Default is 0.95 (with --corr) |
| --help |  | Command-line help |  |  |
| --in-files |  | Master file (see below) |  | With --sss/--corr |
| --log |  | Option to write output to log files specified in column 'log' in the master file |  | No log files are written by default |
| --n-causal-max |  | Maximum number of allowed causal SNPs |  | Default is 5 |
| --n-configs-top |  | Number of top causal configurations to be saved |  | Default is 50000 |
| --n-convergence |  | Number of iterations that the added probability mass is required to be below the specified threshold (--prob-tol) before the shotgun stochastic search is terminated |  | Default is 1000 |
| --n-iterations |  | Maximum number of iterations before the shotgun stochastic search is terminated |  | Default is 100000 |
| --prior-k |  | Option to use prior probabilities for the number of causal SNPs as specified in K files (see below) in the master file |  | SNPs are by default assumed to be causal with probability 1 / (# of SNPs in the genomic region) |
| --prior-k0 |  | Prior probability that there is no causal SNP in the genomic region. Only used when computing posterior probabilities for the number of causal SNPs but not during fine-mapping itself |  | Default is 0.0 |
| --prior-std |  | Prior standard deviation of effect sizes |  | Default is 0.05 |
| --prob-tol |  | Tolerance at which the added probability mass (over --n-convergence iterations) is considered small enough to terminate the shotgun stochastic search |  | Default is 0.001 |
| --regions |  | Option to specify delimiter-separated list of datasets for fine-mapping as given in the master file (e.g. 1,2 or 1|2) |  | All regions are processed by default |
| --sss |  | Fine-mapping with shotgun stochastic search |  | Subprogram |

### Input

#### (1) Master file

The master file is a **semicolon-separated** text file and contains no space. It contains the following column names and one dataset per line.

* z column contains the names of Z files (input).
* ld column contains the names of LD files (input).
* snp column contains the names of SNP files (output).
* config column contains the names of CONFIG files (output).
* n-ind column contains the GWAS sample sizes.
* k column contains the optional K files (input).
* log column contains the optional LOG files (output).

* File extensions must correspond with the column names in the header line!

A master file with two datasets could look as follows.

|  |
| --- |
| z;ld;snp;config;log;n-ind |
| dataset1.z;dataset1.ld;dataset1.snp;dataset1.config;dataset1.log;5363 |
| dataset2.z;dataset2.ld;dataset2.snp;dataset2.config;dataset2.log;5363 |

#### (2) Z file

The dataset.z file is a **space-delimited** text file. It contains the following two columns and one SNP per line.

* 1st column contains the SNP identifiers. The identifier can be a rsID number or combination of chromosome name and genomic position (e.g. XXX:yyy).
* 2nd column contains the *z*-scores.

A dataset.z file with three SNPs could look as follows.

|  |
| --- |
| rs1 0.240 |
| rs2 0.483 |
| rs3 1.145 |

* The order of SNPs in dataset.z must correspond to the order of SNPs in dataset.ld!

#### (3) LD file

The dataset.ld file is a **space-delimited** text file and contains the SNP correlation matrix (Pearson's correlation). The order of the SNPs in the dataset.ld must correspond to the order of variants in dataset.z.

A dataset.ld file with three SNPs could look as follows.

|  |
| --- |
| 1.00 0.95 0.98 |
| 0.95 1.00 0.96 |
| 0.97 0.96 1.00 |

* Ideally, the SNP correlation matrix is computed from the genotype data on the same samples from which the GWAS summary statistics orginate. Read [*here*](https://doi.org/10.1016/j.ajhg.2017.08.012) what could happen if SNP correlations from reference genotypes (e.g. [1000 Genomes Project](http://www.1000genomes.org)) do not match well with the GWAS summary statistics.

#### (4) Optional K file

By default, FINEMAP assumes that SNPs are causal with prior probability 1 / (# of SNPs in the genomic region). As an alternative, it is possible to specify prior probabilities for the number of causal SNPs in the genomic region by using a dataset.k file. This is a **space-delimited** text file and contains the prior probabilities *pk* = Pr(# of causal SNPs is *k*) for *k* = 1,...,*K*, where *K* is the number of entries in the dataset.k file. The prior probabilities must be non-negative and will be normalized to sum to one.

A dataset.k file allowing for three causal SNPs with *p*1 = 0.6, *p*2 = 0.3 and *p*3 = 0.1 would look as follows.

|  |
| --- |
| 0.6 0.3 0.1 |

* We assume that the genomic region includes at least one causal SNP and thus *p*0 = 0. A non-zero prior probability *p*0 that there is no causal SNP in the genomic region can be specified with the command-line argument --prior-k0. This value is only used when computing posterior probabilities *p**k*|data = Pr(# of causal SNPs is *k* | data) but not during fine-mapping itself. We further assumen that *pk* = 0 for *k* = *K* +1,...,*m*, where *m* is the number of SNPs in the dataset.z file.

### Output

#### (1) SNP file

The dataset.snp file is a **space-delimited** text file. It contains the model-averaged posterior summaries for each SNP one per line.

* index column contains the line numbers in which SNPs appear in the dataset.z file.
* snp column contains the SNP identifiers.
* snp\_prob column contains the marginal Posterior Inclusion Probabilities (PIP). The PIP for the *l* th SNP is the posterior probability that this SNP is causal. It is computed by summing up the posterior probabilities of all causal configurations in the dataset.config file in which *l* th SNP is included.
* snp\_log10bf column contains the log10 Bayes factors. The Bayes factor quantifies the evidence that the *l* th SNP is causal with log10 Bayes factors greater than 2 reporting decisive evidence.

#### (2) CONFIG file

The dataset.config file is a **space-delimited** text file. It contains the posterior summaries for each causal configuration one per line.

* rank column contains the ranking.
* config column contains the SNP identifiers.
* config\_prob column contains the posterior probability. For a causal configuration γ, an entry in this column is the posterior probability that SNPs in this configuration are causal.
* config\_log10bf column contains the log10 Bayes factors. The Bayes factor quantifies the evidence for a causal configuration γ over the null configuration γ0.

#### (3) LOG file

The dataset.log file outputs additional information. It contains the following output.

* Posterior probabilities Pr(# of causal SNPs is *k* | data) for *k* = 1,...,*K*, where *K* is the maximum number of allowed causal SNPs.
* A log10 Bayes factor to quantify the evidence of at least one causal SNP in the genomic region.

### Fine-mapping example

Using genotype data with 50 SNPs and 5363 individuals, a quantitative phenotype was simulated using a linear model with 2 causal SNPs. Single-SNP testing was performed to obtain *z*-scores. SNP correlations were computed from individual-level genotype data.

Fine-mapping the SNPs in genomic region 1 in the example folder is done follows:

./finemap --sss --in-files example/data --regions 1

### Correlation example

The same data as in the fine-mapping example above are used. Repairing non-positive definiteness of a SNP correlation matrix (with Pearson's correlation coefficients) can sometimes be done by discarding SNPs such that no pair of SNPs remains with absolute correlation greater than some specified threshold (--corr-filter, default is 0.95). A search through the correlation matrix is performed to determine SNPs that need to be removed. The absolute values of pair-wise correlations are considered. If two SNPs have a high correlation, the mean absolute correlation of each SNP is considered and the SNP with the largest mean absolute correlation is removed.

Pair-wise SNP correlations can be reduced, for instance according to threshold |*rij* |<0.98, as follows:

./finemap --corr --in-files example/data --corr-filter 0.98

This removed the SNPs 1, 24, 27, 35, 37.

### References

|  |
| --- |
| Benner, C. *et al*. [FINEMAP: Efficient variable selection using summary data from genome-wide association studies](https://doi.org/10.1093/bioinformatics/btw018). *Bioinformatics* 32, 1493-1501 (2016). |
| Hans, D. *et al*. Shotgun stochastic search for "large p" regression. *J Am Stat Assoc* 102, 507-516 (2007). |

### Acknowledgements

[Matti Pirinen](http://www.helsinki.fi/~mjxpirin) contributed to the design and implementation of FINEMAP.

* [Legal disclosure (Impressum)](notice.html)
* [Data privacy policy](privacy.html)