* [Atlas Documentation](./)
* [ATLAS and the ATLAS-pipeline](/)
* [**1** Getting started](/getting_started)
  + [**1.1** Installation using Conda](/installation-using-conda)
  + [**1.2** Installation from source](/installation-from-source)
  + [**1.3** Running ATLAS](/running-atlas)
  + [**1.4** Quickstart](/quickstart)
* [**2** Workflows](/workflows)
  + [**2.1** Low-depth sequencing](/low-depth-sequencing)
  + [**2.2** Ancient DNA](/ancient-dna)
* [**3** Tutorial](/tutorial)
  + [**3.1** Data from a Single Individual](/data-from-a-single-individual)
  + [**3.2** Data from One Population](/data-from-one-population)
  + [**3.3** Data from many Populations](/data-from-many-populations)
* [**4** Read tasks](/read-tasks)
  + [**4.1** assessSoftClipping](/assesssoftclipping)
  + [**4.2** BAMDiagnostics](/bamdiagnostics)
  + [**4.3** downsample](/downsample)
  + [**4.4** filterBAM](/filterbam)
  + [**4.5** mergeOverlappingReads](/mergeoverlappingreads)
  + [**4.6** mergeRG](/mergerg)
  + [**4.7** PMDS](/pmds)
  + [**4.8** qualityTransformation](/qualitytransformation)
* [**5** Site tasks](/site-tasks)
  + [**5.1** allelicDepth](/allelicdepth)
  + [**5.2** call](/call)
  + [**5.3** createMask](/createmask)
  + [**5.4** estimateErrors](/estimateerrors)
  + [**5.5** GLF](/glf)
  + [**5.6** summaryStats](/summarystats)
  + [**5.7** mutationLoad](/mutationload)
  + [**5.8** pileup](/pileup)
  + [**5.9** pileupToBed](/pileuptobed)
  + [**5.10** PSMC](/psmc)
  + [**5.11** thetaRatio](/thetaratio)
* [**6** Population tasks](/population-tasks)
  + [**6.1** alleleCounts](/allelecounts)
  + [**6.2** alleleFreq](/allelefreq)
  + [**6.3** ancestralAlleles](/ancestralalleles)
  + [**6.4** calculateF2](/calculatef2)
  + [**6.5** geneticDist](/geneticdist)
  + [**6.6** inbreeding](/inbreeding)
  + [**6.7** majorMinor](/majorminor)
  + [**6.8** printGLF](/printglf)
  + [**6.9** saf](/saf)
* [**7** VCF Tasks](/vcf-tasks)
  + [**7.1** convertVCF](/convertvcf)
  + [**7.2** testHardyWeinberg](/stesthardyweinberg)
  + [**7.3** VCFCompare](/vcfcompare)
  + [**7.4** VCFDiagnostics](/vcfdiagnostics)
* [**8** Simulation Tasks](/simulation-tasks)
  + [**8.1** simulate](/simulate)
* [**9** File Formats](/fileformats)
  + [**9.1** Beagle](/beagle)
  + [**9.2** geno](/geno)
  + [**9.3** LFMM](/lfmm)
  + [**9.4** posfile](/posfile)
  + [**9.5** genfile](/genfile)
* [**10** Filter parameters](/filter)
  + [**10.1** Filter parameters for Reads](/filter-parameters-for-reads)
  + [**10.2** Filter parameters for bases](/filter-parameters-for-bases)
  + [**10.3** Filter parameters for Parsing window settings](/filter-parameters-for-parsing-window-settings)
* [**11** Engine parameters](/engine)
* [**12** ATLAS-Pipeline](/atlas-pipeline)
  + [**12.1** Getting started](/getting-started)
  + [**12.2** Gaia](/gaia)
  + [**12.3** Rhea](/rhea)
  + [**12.4** Perses](/perses)
  + [**12.5** Pallas](/pallas)
  + [**12.6** Troubleshooting](/troubleshooting)
* [Published with bookdown](https://github.com/rstudio/bookdown)

# [Welcome to ATLAS, your guide to the world of low-depth and ancient DNA!](./)

## 5.2 call

**Calling genotypes**

`call` generates a VCF file that is used to encode genetic variant sites and genotypes. See [VCFCompare](/vcfcompare#VCFCompare) for more information on VCF file format.`call` can make use of different callers to produce a VCF file. Some are maximum likelihood callers, like the “MLE” caller, and others are Bayesian callers, like “Bayesian” and “allelePresence”. For the Bayesian callers, we define the prior based on `theta` and the allele frequencies (see below for more details). The parameters of the priors can either be estimated in a first step and then in a second step assumed to be known when making the genotype call, or they can be fixed to a value.

### 5.2.1 Input

**Required inputs :**

|  |  |
| --- | --- |
| `--bam Input_bam_file.bam` | Input bam file |
| `--fasta Input_refrence_genome_file.fasta` | reference genome FASTA file |

**Optional inputs :**

|  |  |
| --- | --- |
| `--pmd "library_type:model_for_5'_and_or_3'_read"` | library type followed by the model to be used in case of single stranded library or library type followed by the model to be used for the 5-prime read-end and the 3-prime read-end in case of double stranded library. Model can be either “Exponential” or “Empiric”.All arguments must be provided as a string, divided by colons (:). e.g. : `--pmdModels "doubleStrand:Exponential:Exponential"` |
| `--recal recalibaration_parameters_file.txt` | A .txt file with suffix “\_recalibrationEM.txt” specifying the recalibration parameters for all covariates and readgroups. Default = default rho is used (can be changed using `--rho`) |
| `--alleles alleles_of_interest.txt` | Provide a file that specifies the sites for which variants should be called and the known alleles at those sites. Provide file with known alleles (1-based!) with the following tab-separated format: `chr position ref_allele alt_allele` |

**Specific Parameters :**

|  |  |
| --- | --- |
| `--method caller_of_choice_for_variant calling` | caller type for variant calling. Following options are available : MLE, Bayesian, allelePresence, randomBase, majorityBase |
| `--priors prior_type` | Prior for the callers allelePresence and Bayesian. Following options are available for prior type: `--fixedTheta integer_value`: provide fixed theta value instead of estimating it for every window. `--equalBaseFreqs`: assume all base frequencies to be 0.25 instead of estimating them for every window. `defaultTheta integer_value`: provide a fixed theta value to be used for all windows for which theta can not be estimated due to lack of data (algorithm does not converge). Default = theta and base frequencies estimated individually for each window. |
| `--infoFields DP` | redundant?? |
| `--formatFields format_fields` | To print the VCF format fields that are specified. Available options are: GT: genotype string, DP: sequencing depth, GQ: genotype quality, AD: allelic depths for all alleles in call in order listed, AP: Phred-scaled allelic posterior probabilities for the four alleles A, C, G and T, GL: normalized genotype likelihoods, PL: phred-scaled normalized genotype likelihoods, GP: Genotype posterior probabilities (phred-scaled), AB: alleleic imbalance, AI: Binomial probability of allelic imbalance if Hz site. All arguments must be provided as a string, separated by comma (,). e.g. : `--formatFields GT,DP,AD, GQ, PL`. Default = only GT,DP,AD, GQ, PL are printed. |
| `--printAll` | To print all sites, also invariant ones. Default = Will print only sites with data. |
| `--noAltIfHomoRef` | To specify to not print alternative alleles if call is homozygous reference, but still use them to calculate call quality. Default = Will print the most likely alternative allele even if the call is homozygous reference |
| `--noTriallelic` | To only allow one alternative allele. Default = Will allow for genotypes with two alternative alleles. |
| `--noCallsViolatingBest` | To not call genotypes from known alleles that conflict with best call across all genotypes. Default = Will call genotypes from known alleles even if they differ from best call across all genotypes. |
| `--sampleName name` | To define a sample name for the header of the vcf file. Default = prefix specified with the out parameter. |
| `--alleles` | To limit calls to sites with known alleles. Default = Will call without prior knowledge on alleles. |

* See [Filter parameters](/filter#Filter) to apply specific filters for bases, reads and parsing window setting.

Engine parameters that are common to all tasks can be found [here](/engine#Engine).

### 5.2.2 Output

|  |  |
| --- | --- |
| \**calls*.vcf.gz | tab delimited text file containing meta-information lines, a header line, and data lines each containing information about a position in the genome. |
| \*\_RGInfo.json | File containing read group info. |
| \*\_filterSummary.txt | File containing filter summary of general filter counts. |

### 5.2.3 Usage Example

```
#! /bin/bash

# Set atlas path
atlas=$(dirname "$0")/../build/atlas

# Simulate a BAM File
$atlas simulate --logFile simulate.out

# Call sites
$atlas call --bam ATLAS_simulations.bam --fasta ATLAS_simulations.fasta --logFile call.out
```