FINEMAP

---

[**Command-line arguments**](#cmd) **|** [**Input**](#input) **|** [**Output**](#output) **|** [**Examples**](#sss)

---

### FINEMAP-ing articles

|  |  |  |
| --- | --- | --- |
| - |  | [Refining fine-mapping: effect sizes and regional heritability](https://www.biorxiv.org/content/early/2018/05/10/318618). *bioRxiv.* (2018). |
| - |  | [Prospects of fine-mapping trait-associated genomic regions by using summary statistics from genome-wide association studies](https://doi.org/10.1016/j.ajhg.2017.08.012). *Am. J. Hum. Genet.* (2017). |
| - |  | [FINEMAP: Efficient variable selection using summary data from genome-wide association studies](https://doi.org/10.1093/bioinformatics/btw018). *Bioinformatics* 32, 1493-1501 (2016). |

FINEMAP is a program for

* **1**identifying causal SNPs
* **2**estimating effect sizes of causal SNPs
* **3**estimating the heritability contribution of causal SNPs

in genomic regions associated with complex traits and disease. FINEMAP is computationally efficient by using summary statistics from genome-wide association studies and robust by applying a shotgun stochastic search algorithm (Hans *et al*., 2007). It produces accurate results in a fraction of processing time of existing approaches. It is therefore the ideal tool for analyzing growing amounts of data produced in genome-wide association studies and emerging sequencing or biobank projects.

### Download

### ([license](license_finemap_v1.3.html))

* [finemap\_v1.3.1\_MacOSX.tgz (Mac OS X)](finemap_v1.3.1_MacOSX.tgz)
* [finemap\_v1.3.1\_x86\_64.tgz (Unix)](finemap_v1.3.1_x86_64.tgz)
* Updated 19-Oct-2018* (1) Credible sets* * [finemap\_v1.3\_MacOSX.tgz (Mac OS X)](finemap_v1.3_MacOSX.tgz)
      * [finemap\_v1.3\_x86\_64.tgz (Unix)](finemap_v1.3_x86_64.tgz)
      * Updated 06-July-2018* (1) BGEN support (e.g. for UK biobank data)* (2) Stepwise conditional search* (3) Group-wise SNP probabilities* * Mac OSX users: If you see dyld: Library not loaded: /usr/local/lib/libzstd.1.dylib, install [Zstandard](https://facebook.github.io/zstd/).* * [finemap\_v1.2\_MacOSX.tgz (Mac OS X)](finemap_v1.2_MacOSX.tgz)
                    * [finemap\_v1.2\_x86\_64.tgz (Unix)](finemap_v1.2_x86_64.tgz)
                    * [Documentation](index_v1.2.html)
                    * * Be aware that FINEMAP v1.1 cannot handle large effect size regions!* [finemap\_v1.1\_MacOSX.tgz (Mac OS X)](finemap_v1.1_MacOSX.tgz)
                        * [finemap\_v1.1\_x86\_64.tgz (Unix)](finemap_v1.1_x86_64.tgz)
                        * [Documentation](index_v1.1.html)
                        * * To receive email reminders about updates of FINEMAP, send an email to finemap@christianbenner.com.

### Command-line arguments

|  |  |  |  |  |
| --- | --- | --- | --- | --- |
| --cond |  | Fine-mapping with stepwise conditional search |  | Subprogram |
| --config |  | Evaluate a single causal configuration without performing shotgun stochastic search |  | Subprogram |
| --corr-config |  | Option to set the posterior probability of a causal configuration to zero if it includes a pair of SNPs with absolute correlation above this threshold |  | Default is 0.95 |
| --corr-group |  | Option to set the threshold for grouping a pair of SNPs with absolute correlation above this threshold |  | Default is 0.99 |
| --dataset |  | Option to specify a delimiter-separated list of datasets for fine-mapping as given in the master file (e.g. 1,2 or 1|2) |  | All datasets are processed by default |
| --flip-beta |  | Option to read a column 'flip' in the Z file with binary indicators specifying if the direction of the estimated SNP effect sizes needs to be flipped to match SNP correlations |  | With --cond, --config and --sss |
||  |  |  |  |  |
| --- | --- | --- | --- | --- |
| --group-snps |  | Option to group SNPs on the basis of their correlations |  | With --cond and --sss |
| --help |  | Command-line help |  |  |
| --in-files |  | Master file (see below) |  | With --cond, --config and --sss |
| --log |  | Option to write output to log files specified in column 'log' in the master file |  | No log files are written by default |
| --n-causal-snps |  | Option to set the maximum number of allowed causal SNPs |  | Default is 5 |
| --n-configs-top |  | Option to set the number of top causal configurations to be saved |  | Default is 50000 |
| --n-convergence |  | Option to set the number of iterations that the added probability mass is required to be below the specified threshold (--prob-tol) before the shotgun stochastic search is terminated |  | Default is 1000 |
| --n-iterations |  | Option to set the maximum number of iterations before the shotgun stochastic search is terminated |  | Default is 100000 |
| --prior-k |  | Option to use prior probabilities for the number of causal SNPs as specified in K files (see below) in the master file |  | SNPs are by default assumed to be causal with probability 1 / (# of SNPs in the genomic region) |
| --prior-k0 |  | Option to set the prior probability that there is no causal SNP in the genomic region. Only used when computing posterior probabilities for the number of causal SNPs but not during fine-mapping itself |  | Default is 0.0 |
| --prior-std |  | Option to specify a comma-separated list of prior standard deviations of effect sizes. |  | Default is 0.05 |
| --prob-tol |  | Option to set the tolerance at which the added probability mass (over --n-convergence iterations) is considered small enough to terminate the shotgun stochastic search |  | Default is 0.001 |
| --rsids |  | Option to sepcify a comma-separated list of SNP identifiers corresponding with the rsid column in Z files (see below) |  | With --config |
| --sss |  | Fine-mapping with shotgun stochastic search |  | Subprogram |

### Input

#### (1) Master file

The master file is a **semicolon-separated** text file and contains no space. It contains the following mandatory column names and one dataset per line.

* z column contains the names of Z files (input)
* ld column contains the names of LD files (input)
* bgen column contains the names of BGEN files (input)
* bgi column contains the names of BGI files (input)
* dose column contains the names of DOSE files (output)
* sample column contains the names of SAMPLE files (input)
* incl column contains the names of INCL files (input)
* snp column contains the names of SNP files (output)
* config column contains the names of CONFIG files (output)
* cred column contains the names of CRED files (output)
* n\_samples column contains the GWAS sample sizes
* k column contains the optional K files (optional input)
* log column contains the optional LOG files (optional output)

* File extensions must correspond with the column names in the header line!
* The master file can contain columns ld, bgen, bgi and dose simultaneously. For each dataset per line, entries need to be specified for precomputed SNP correlations in column ld or for BGEN support using all three columns bgen, bgi and dose. If a line contains entries in all four columns, then precomputed SNP correlations are used.
* Entries in columns sample and incl need to be specified if the GWAS sample size in column n\_samples is smaller than the number of samples in the BGEN file.
* A master file with two datasets using precomputed SNP correlations could look as follows.

|  |
| --- |
| z;ld;snp;config;cred;log;n\_samples |
| dataset1.z;dataset1.ld;dataset1.snp;dataset1.config;dataset1.cred;dataset1.log;5363 |
| dataset2.z;dataset2.ld;dataset2.snp;dataset2.config;dataset2.cred;dataset2.log;5363 |

* A master file with two datasets using precomputed SNP correlations in the first dataset and BGEN support in the second dataset could look as follows.

|  |
| --- |
| z;ld;bgen;bgi;dose;snp;config;cred;log;n\_samples |
| dataset1.z;dataset1.ld;;;;dataset1.snp;dataset1.config;dataset1.cred;dataset1.log;5363 |
| dataset2.z;;dataset2.bgen;dataset2.bgi;dataset2.dose;dataset2.snp;dataset2.config;dataset2.cred;dataset2.log;5363 |

* A master file with one datasets using BGEN support and a subset of 5,000 samples could look as follows.

|  |
| --- |
| z;bgen;bgi;dose;sample;incl;snp;config;cred;log;n\_samples |
| dataset2.z;dataset2.bgen;dataset2.bgi;dataset2.dose;dataset.sample;dataset.incl;dataset.snp;dataset.config;dataset.cred;dataset.log;5000 |

#### (2) Z file

The dataset.z file is a **space-delimited** text file and contains the GWAS summary statistics one SNP per line. It contains the mandatory column names in the following order.

* rsid column contains the SNP identifiers. The identifier can be a rsID number or a combination of chromosome name and genomic position (e.g. XXX:yyy)
* chromosome column contains the chromosome names. The chromosome names can be chosen freely with precomputed SNP correlations (e.g. 'X', '0X' or 'chrX')
* position column contains the base pair positions
* allele1 column contains the "first" allele of the SNPs. In SNPTEST this corresponds to 'allele\_A', whereas BOLT-LMM uses 'ALLELE1'
* allele2 column contains the "second" allele of the SNPs. In SNPTEST this corresponds to 'allele\_B', whereas BOLT-LMM uses 'ALLELE0'
* maf column contains the minor allele frequencies
* beta column contains the estimated effect sizes as given by GWAS software
* se column contains the standard errors of effect sizes as given by GWAS software
* flip optional column - see below

* Columns beta and se are required for fine-mapping. Column maf is needed to output posterior effect size estimates on the allelic scale. All other columns are not required for computations and can be specified arbitrarily.
* When using BGEN support, entries for each SNP in columns rsid, chromosome, position, allele1 and allele2 need to correspond with the information in BGEN files. The chromosome column may have to contain '0X' for X = 1,...,9, where X is the chromosome number, to correspond to the information in the BGEN file. Listing SNPs in a BGEN file with the BGENIX software outputs columns first\_allele and alternative\_alleles, whereas QCTOOL uses allele\_A and allele\_B as column names. These columns correspond with FINEMAP's allele1 and allele2 columns.
* It is recommended to compute all SNP correlations from allele counts of one of the alleles. In this case, estimated effect sizes and their standard errors from GWAS software can be used directly if the software always codes the same allele as the effect allele. This is the case in software SNPTEST (uses 'allele\_B' as the effect allele) and BOLT-LMM (uses 'ALLELE1' as the effect allele). However, if the GWAS software codes the minor allele of the SNPs as the effect allele, then the direction of estimated effect sizes needs to be flipped to either the first or the second allele. This can be done by specifying the --flip-beta command-line argument and augmenting dataset.z by a flip column which contains 1 in a line if the direction of the estimated effect size of the SNP needs to be flipped and 0, otherwise.
* SNPs do not have to be ordered by genomic positions and can reside on different chromsomes. However, the order of SNPs in dataset.z must correspond to the order of SNPs in dataset.ld!
* A dataset.z file with three SNPs could look as follows.

|  |
| --- |
| rsid chromosome position allele1 allele2 maf beta se |
| rs1 10 1 T C 0.35 0.0050 0.0208 |
| rs2 10 1 A G 0.04 0.0368 0.0761 |
| rs3 10 1 G A 0.18 0.0228 0.0199 |

#### (3) LD file

The dataset.ld file is a **space-delimited** text file and contains the SNP correlation matrix (Pearson's correlation).

* Ideally, the SNP correlation matrix is computed from the genotype data on the same samples from which the GWAS summary statistics orginate. Read [*here*](https://doi.org/10.1016/j.ajhg.2017.08.012) what could happen if SNP correlations from reference genotypes (e.g. [1000 Genomes Project](http://www.1000genomes.org)) do not match well with the GWAS summary statistics.
* With imputed biobank-scale genotype data, it is important to compute SNP correlations from the same genotype data used in GWAS software. Read [*here*](https://doi.org/10.1101/255224) for an example highlighting the importance of computing SNP correlations from the same dosage data used in GWAS software. For example, if GWAS summary statistics are generated with BOLT-LMM using SNP dosages (e.g. when used with BGEN files), then SNP correlations need to be computed from the same SNP dosage data. The same applies to SNPTEST when using the -method expected option to deal with genotype uncertainty. If GWAS summary statistics are computed from SNP dosage data using BGEN files, we recommended to use the LDstore software to compute SNP correlations or FINEMAP's BGEN support and disadvise to convert genotype probabilities to best-guess genotypes in order to compute SNP correlations.
* The order of the SNPs in the dataset.ld must correspond to the order of variants in dataset.z.
* A dataset.ld file with three SNPs could look as follows.

|  |
| --- |
| 1.00 0.95 0.98 |
| 0.95 1.00 0.96 |
| 0.97 0.96 1.00 |

#### (4) BGEN, BGI, SAMPLE and INCL file

These are Oxford file formats and described [here](http://www.well.ox.ac.uk/~gav/bgen_format/) (BGEN), [here](https://bitbucket.org/gavinband/bgen/wiki/The_bgenix_index_file_format) (BGI) and [here](https://www.well.ox.ac.uk/~gav/qctool_v2/documentation/sample_file_formats.html) (SAMPLE). The dataset.incl file is a text file to restrict estimation of SNP correlations to genotype data from a subset of samples in dataset.sample. It constains one sample ID per line.

* FINEMAP supports the BGEN format up to v1.3.

  * Genotype data from the UK biobank is available in this format.

#### (5) Optional K file

By default, FINEMAP assumes that SNPs are causal with prior probability 1 / (# of SNPs in the genomic region). As an alternative, it is possible to specify prior probabilities for the number of causal SNPs in the genomic region by using a dataset.k file. This is a **space-delimited** text file and contains the prior probabilities *pk* = Pr(# of causal SNPs is *k*) for *k* = 1,...,*K*, where *K* is the number of entries in the dataset.k file. The prior probabilities must be non-negative and will be normalized to sum to one.

* We assume that the genomic region includes at least one causal SNP and thus *p*0 = 0. A non-zero prior probability *p*0 that there is no causal SNP in the genomic region can be specified with the command-line argument --prior-k0. This value is only used when computing posterior probabilities *p**k*|data = Pr(# of causal SNPs is *k* | data) but not during fine-mapping itself. We further assume that *pk* = 0 for *k* = *K* +1,...,*m*, where *m* is the number of SNPs in the dataset.z file.
* A dataset.k file allowing for three causal SNPs with *p*1 = 0.6, *p*2 = 0.3 and *p*3 = 0.1 would look as follows.

|  |
| --- |
| 0.6 0.3 0.1 |

### Output

#### (1) SNP file

The dataset.snp file is a **space-delimited** text file. It contains the GWAS summary statistics 