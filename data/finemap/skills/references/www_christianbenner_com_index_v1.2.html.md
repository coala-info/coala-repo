FINEMAP

---

[**Command-line arguments**](#cmd) **|** [**Input**](#input) **|** [**Output**](#output) **|** [**Examples**](#sss)

---

FINEMAP is a program for

* **1**identifying causal SNPs
* **2**estimating effect sizes of causal SNPs
* **3**estimating the heritability contribution of causal SNPs

in genomic regions associated with complex traits and disease. FINEMAP is computationally efficient by using summary statistics from genome-wide association studies and robust by using a shotgun stochastic search algorithm (Hans *et al*., 2007). It produces accurate results in a fraction of processing time of existing approaches. It is therefore the ideal tool for analyzing growing amounts of data produced in genome-wide association studies and emerging sequencing or biobank projects.

### Download

### ([license](license_finemap_v1.2.html))

* [finemap\_v1.2\_MacOSX.tgz (Mac OS X)](finemap_v1.2_MacOSX.tgz)
* [finemap\_v1.2\_x86\_64.tgz (Unix)](finemap_v1.2_x86_64.tgz)
* (Updated 9-May-2018)* * To receive email reminders about updates of FINEMAP, send an email to finemap@christianbenner.com.

### Command-line arguments

|  |  |  |  |  |
| --- | --- | --- | --- | --- |
| --config |  | Evaluate a single causal configuration without performing shotgun stochastic search |  | Subprogram |
| --corr-config |  | The posterior probability of a causal configuration is set to zero if it includes a pair of SNPs with absolute correlation above this threshold |  | Default is 0.95 (with --sss) |
| --dataset |  | Option to specify delimiter-separated list of datasets for fine-mapping as given in the master file (e.g. 1,2 or 1|2) |  | All datasets are processed by default |
| --help |  | Command-line help |  |  |
| --in-files |  | Master file (see below) |  | With --sss/--config |
| --log |  | Option to write output to log files specified in column 'log' in the master file |  | No log files are written by default |
| --n-causal-snps |  | Maximum number of allowed causal SNPs |  | Default is 5 |
| --n-configs-top |  | Number of top causal configurations to be saved |  | Default is 50000 |
| --n-convergence |  | Number of iterations that the added probability mass is required to be below the specified threshold (--prob-tol) before the shotgun stochastic search is terminated |  | Default is 1000 |
| --n-iterations |  | Maximum number of iterations before the shotgun stochastic search is terminated |  | Default is 100000 |
| --prior-k |  | Option to use prior probabilities for the number of causal SNPs as specified in K files (see below) in the master file |  | SNPs are by default assumed to be causal with probability 1 / (# of SNPs in the genomic region) |
| --prior-k0 |  | Prior probability that there is no causal SNP in the genomic region. Only used when computing posterior probabilities for the number of causal SNPs but not during fine-mapping itself |  | Default is 0.0 |
| --prior-std |  | Comma-separated list of prior standard deviations of effect sizes. |  | Default is 0.05 |
| --prob-tol |  | Tolerance at which the added probability mass (over --n-convergence iterations) is considered small enough to terminate the shotgun stochastic search |  | Default is 0.001 |
| --rsids |  | Comma-separated list of SNP identifiers corresponding with the rsid column in Z files (see below) |  | With --config |
| --sss |  | Fine-mapping with shotgun stochastic search |  | Subprogram |

### Input

#### (1) Master file

The master file is a **semicolon-separated** text file and contains no space. It contains the following column names and one dataset per line.

* z column contains the names of Z files (input).
* ld column contains the names of LD files (input).
* snp column contains the names of SNP files (output).
* config column contains the names of CONFIG files (output).
* n\_samples column contains the GWAS sample sizes.
* k column contains the optional K files (input).
* log column contains the optional LOG files (output).

* File extensions must correspond with the column names in the header line!

A master file with two datasets could look as follows.

|  |
| --- |
| z;ld;snp;config;log;n\_samples |
| dataset1.z;dataset1.ld;dataset1.snp;dataset1.config;dataset1.log;5363 |
| dataset2.z;dataset2.ld;dataset2.snp;dataset2.config;dataset2.log;5363 |

#### (2) Z file

The dataset.z file is a **space-delimited** text file and contains the GWAS summary statistics one SNP per line. It contains exactly the column names in the following order.

* rsid column contains the SNP identifiers. The identifier can be a rsID number or a combination of chromosome name and genomic position (e.g. XXX:yyy).
* chromosome column contains the chromosome names. The chromosome names can be chosen freely, e.g. 'X', '0X' or 'chrX'.
* position column contains the base pair positions
* noneff\_allele column contains the non-effect alleles.
* eff\_allele column contains the effect alleles. The effect allele is the allele that corresponds to the effect size parameter in GWAS software. SNPTEST uses 'allele\_B' as the effect allele, whereas BOLT-LMM uses 'ALLELE1' as the effect allele.
* maf column contains the minor allele frequencies.
* beta column contains the estimated effect sizes.
* se column contains the standard errors of effect sizes.

* Columns beta and se are required for fine-mapping. Column maf is needed to output posterior effect size estimates on the allelic scale. All other columns are not required for computations and can be specified arbitrarily.

A dataset.z file with three SNPs could look as follows.

|  |
| --- |
| rsid chromosome position noneff\_allele eff\_allele maf beta se |
| rs1 10 1 T C 0.35 0.0050 0.0208 |
| rs2 10 1 A G 0.04 0.0368 0.0761 |
| rs3 10 1 G A 0.18 0.0228 0.0199 |

* SNPs do not have to be ordered by genomic positions and can reside on different chromsomes. However, the order of SNPs in dataset.z must correspond to the order of SNPs in dataset.ld!

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

* We assume that the genomic region includes at least one causal SNP and thus *p*0 = 0. A non-zero prior probability *p*0 that there is no causal SNP in the genomic region can be specified with the command-line argument --prior-k0. This value is only used when computing posterior probabilities *p**k*|data = Pr(# of causal SNPs is *k* | data) but not during fine-mapping itself. We further assume that *pk* = 0 for *k* = *K* +1,...,*m*, where *m* is the number of SNPs in the dataset.z file.

### Output

#### (1) SNP file

The dataset.snp file is a **space-delimited** text file. It contains the GWAS summary statistics and model-averaged posterior summaries for each SNP one per line.

* index column contains the line numbers in which SNPs appear in the dataset.z file.
* rsid column contains the SNP identifiers.
* chromosome column contains the chromosome names.
* position column contains the base pair positions
* noneff\_allele column contains the non-effect alleles.
* eff\_allele column contains the effect alleles. The effect allele is the allele that corresponds to the effect size parameter in GWAS software.
* maf column contains the minor allele frequencies.
* beta column contains the estimated effect sizes.
* se column contains the standard errors of effect size estimates.
* z column contains the *z*-scores.
* prob column contains the marginal Posterior Inclusion Probabilities (PIP). The PIP for the *l* th SNP is the posterior probability that this SNP is causal. It is computed by summing up the posterior probabilities of all causal configurations in the dataset.config file in which *l* th SNP is included.
* log10bf column contains the log10 Bayes factors. The Bayes factor quantifies the evidence that the *l* th SNP is causal with log10 Bayes factors greater than 2 reporting considerable evidence.
* mean column contains the marginalized shrinkage estimates of the posterior effect size mean. The marginalized shrinkage estimate for the *l* th SNP is computed by averaging the posterior effect size means of this SNP from all causal configurations in the dataset.config file assuming that the effect size of the *l* th SNP is zero if the SNP is absent from a causal configuration.
* sd column contains the marginalized shrinkage estimates of the posterior effect size standard deviation. The estimates are computed in the same way as the marginalized shrinkage estimates of the posterior effect size mean.
* mean\_incl column contains the conditional estimates of the posterior effect size mean. The conditional estimate for the *l* th SNP is computed by averaging the posterior effect size means of this SNP from causal configurations in the dataset.config file in which it is included.
* sd\_incl column contains the conditional estimates of the posterior effect size standard deviation. The estimates are computed in the same way as the conditional estimates of the posterior effect size mean.

#### (2) CONFIG file

The dataset.config file is a **space-delimited** text file. It contains the posterior summaries for each causal configuration one per line.

* rank column contains the ranking.
* config column contains the SNP identifiers.
* prob column contains the posterior probabilities that configurations are the causal configuration.
* log10bf column contains the log10 Bayes factors. The Bayes factor quantifies the evidence for a causal configuration over the null configuration (no SNPs are causal).
* odds column contains the odds of the top causal configurations.
* h2 column contains the heritability contribution of SNPs.
* h2\_0.95CI column contains the 95% credible interval of the heritability contribution of SNPs.
* mean column contains the joint posterior effect size means.
* sd column contains the joint posterior effect size standard deviations.

#### (3) LOG file

The dataset.log file outputs additional information. It contains the following output.

* Posterior probabilities Pr(# of causal SNPs is *k* | data) for *k* = 1,...,*K*, where *K* is the maximum number of allowed causal SNPs.
* A log10 Bayes factor to quantify the evidence of at least one causal SNP in the genomic region.
* Model-averaged heritability and 95% credible interval to quantify the contribution from causal SNPs.

### Fine-mapping example

Using genotype data with 50 SNPs and 5363 individuals, a quantitative phenotype was simulated using a linear model with 2 causal SNPs. Single-SNP testing was performed to obtain *z*-scores. SNP correlations were computed from GWAS genotype data.

Fine-mapping the SNPs in genomic region 1 in the example folder is done follows.

./finemap\_v1.2\_MacOSX --sss --in-files example/data --dataset 1
./finemap\_v1.2\_x86\_64 --sss --in-files example/data --dataset 1

### Single causal configuration example

The same data as in the fine-mapping example above are used. Without having to perform shotgun stochastic search, information about a single causal configuration can be obtain by specifying SNP identifiers as follows

./finemap\_v1.2\_MacOSX --config --in-files example/data --dataset 1 --rsids rs30,rs11
./finemap\_v1.2\_x86\_64 --config --in-files example/data --dataset 1 --rsids rs30,rs11

### References

|  |
| --- |
| Benner, C. *et al*. [FINEMAP: Efficient variable selection using summary data from genome-wide association studies](https://doi.org/10.1093/bioinformatics/btw018). *Bioinformatics* 32, 1493-1501 (2016). |
| Hans, D. *et al*. Shotgun stochastic search for "large p" regression. *J Am Stat Assoc* 102, 507-516 (2007). |

### Acknowledgements

[Matti Pirinen](http://www.helsinki.fi/~mjxpirin) contributed to the design and implementation of FINEMAP.

* [Legal disclosure (Impressum)](notice.html)
* [Data privacy policy](privacy.html)