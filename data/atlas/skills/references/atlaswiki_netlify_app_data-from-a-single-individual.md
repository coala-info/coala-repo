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

## 3.1 Data from a Single Individual

In this tutorial, you will learn how to interact with ATLAS, how to provide input and interpret output. It will also guide you through a typical workflow when working with ancient or other low-depth data, focusing on the analysis of a single individual. We will then introduce working with multiple individuals in the next tutorial.

### 3.1.1 Simulating some Data

We will begin by simulating sequencing data of a single individual using ATLAS. We will directly simulate a BAM file that contains data from two sequencing runs present in two distinct read groups.

Let us first create a directory specific for this tutorial:

```
mkdir atlas-tutorial_A
cd atlas-tutorial_A
```

To simulate data from multiple readgroups, ATLAS expects details for those read groups in a read group info file. Let us create such a file as follows:

```
echo '
{
    "RG_one": {
        "seqType" : "single",
        "mappingQuality" : "fixed(50)",
        "baseQuality" : "unif()[10,30]",
        "seqCycles" : "100"
    },
    "RG_two":{
        "seqType" : "single",
        "mappingQuality" : "normal(50,10)[10,80]",
        "baseQuality" : "poisson(20)[1,40]",
        "seqCycles" : "100"
    }
}' > ReadGroupInfo.json
```

You can look at this file using the command `cat ReadGroupInfo.json`.

It indicates that both read groups were sequenced as single-end (column seqType) and that the second,
RG\_two, has non-fixed mapping qualities (column mappingQuality).

You may now use this file to simulate a BAM file as follows:

```
atlas simulate --chrLength 1000000 --depth 20 --RGInfo ReadGroupInfo.json
```

Several output files will be created:

|  |  |
| --- | --- |
| \*.bam | Simulated bam file called ATLAS\_simulations.bam. |
| \*.bam.bai | Index file for the simulated bam file called ATLAS\_simulations.bam.bai. |
| \*.fasta | Simulated reference sequence file called ATLAS\_simulations.fasta. |
| \*.fasta.fai | Index file for the simulated reference sequence file called ATLAS\_simulations.fasta.fai. |
| \*.parameters | File listing all parameters used called simulate.parameters. |

* You may change the prefix form ATLAS\_simulations to whatever you like with `--out`.

More information on `simulate` can be found [here](/simulate#simulate).

### 3.1.2 Diagnosing the Simulated BAM File

You may of course look at the simulated BAM file using samtools. However, BAM files are typically very large, and we may be more interested in summary statistics than the raw sequencing data. You can easily obtain such summary statistics with ATLAS by using the task `BAMDiagnostics` as follows:

```
atlas BAMDiagnostics --bam ATLAS_simulations.bam
```

This is a good time to carefully study the detailed log ATLAS is writing to the command line: it details every step and informs you about every parameter (i.e. argument) used, as well as about additional options that may be used.

* Can you find how you could limit the analysis to reads with high mapping quality only?

```
atlas BAMDiagnostics --bam ATLAS_simulations.bam --filterBaseQual 1,90
```

You may also decide to suppress the log with `--silent` or write no logFile using ‘–noLogFile’.

Running BAM diagnostics produces several output files, among which the file `ATLAS_simulations_diagnostics.txt` lists per-read group summary statistics. You may look at it using

```
cat ATLAS_simulations_BAMDiagnostics_diagnostics.txt
```

* Do both readgroups contribute equally to the total depth?

More information on `BAMDiagnostics` can be found [here](/bamdiagnostics#BAMDiagnostics).

### 3.1.3 Filtering Data

ATLAS offers a wide range of filters, which are detailed [here](/filter#Filter) or also in the log.

Try to rerun `BAMDiagnostics` only on the reads mapping in forward strand. Then, check the log for the filter info as well as the filter statistics printed after the BAM file was parsed. These statistics are all provided as a file `ATLAS_simulations_filterSummary.txt`.

### 3.1.4 Calling Genotypes

For most applications, we recommend inferring parameters of interest directly from genotype likelihoods, rather than first calling genotypes and basing subsequent inferences on those. The reason is simply: calling genotypes requires relatively high depth to be accurate enough to ignore their uncertainty downstream.

Nonetheless, genotypes may need to be called for several applications, and ATLAS boosts many different callers for that purpose, starting from random read callers to Bayesian callers using specific priors.

Calling genotypes for a single individual is very easy. Simply type:

```
atlas call --bam ATLAS_simulations.bam --fasta ATLAS_simulations.fasta
```

This will generate a gzipped VCF file `ATLAS_simulations_calls_maximumLikelihood.vcf.gz` with calls the default MLE (Maximum Likelihood Estimation) caller. You can take a look at it using

```
zcat ATLAS_simulations_call_calls_maximumLikelihood.vcf.gz | less
```

The caller offers plenty of settings, such as which VCF fields shall be printed, if sites without data should be added to the file (default: no), or if genotypes with two alleles different from the reference are allowed (default: yes). All the parameters can be found [here](/call#call)

If you prefer a different caller, you may set it with `--method`.

### 3.1.5 Estimating Heterozygosity

Let us next use ATLAS to infer something interesting: the heterozygosity of the sample along the genome. You can do so in two ways:

* 1. You may call genotypes and count how many are heterozygous. This requires considerable depth, as genotyping errors affect your estimates.
* 2. You may infer heterozygosity from genotype likelihoods, which account for genotyping uncertainty and should be accurate even at low depth.

Since we simulated data with a high depth (50), let us try both!

Let us first count the number of heterozygous and homozygous calls in the VCF file. You can get the counts and fraction of heterozygous calls using:

```
zcat ATLAS_simulations_call_calls_maximumLikelihood.vcf.gz \
     | awk '$1!~/#/{print $10}' | cut -d':' -f1 \
     | awk -F '/' '{if($1==$2){++hom}else{++het}}END{print het, hom, het/(het+hom)}'
```

To estimate heterozygosity from genotype likelihoods, we use the task `summaryStats` as follows:

```
atlas summaryStats --bam ATLAS_simulations.bam --fasta ATLAS_simulations.fasta
```

This task estimates the heterozygosity using different estimators: the Felsenstein model, the HKY85 model and the Pi model (<https://en.wikipedia.org/wiki/Substitution_model>). The estimates are written to the log and in the file `ATLAS_simulations_stats.txt.gz`. The ‘FelsensteinHet’, ‘HKY85Het’ and ‘PiHet’ values should be close to 0.000768, which correspondens to a Felsenstein ‘theta’-value of 0.001, which is the default used in the simulations.

You should see that these estimates are pretty similar - which is expected given the high depth.

More information on `summaryStats` can be found [here](/summarystats#summaryStats).

### 3.1.6 Downsampling your Data

Now, let’s assess how these two estimates depend on depth. An easy way to do so is to downsample the simulated data and rerun the estimation. You can downsample simulated data with task `downsample` as

```
atlas downsample --bam ATLAS_simulations.bam --prob 0.5,0.1,0.04
```

Here, the parameter `--prob` specifies the probabilities with which sequencing reads are kept. With `--prob 0.5,0.1,0.04` ATLAS will generate three new BAM files, for which only 50%, 10% or 4% of all reads will be kept, resulting in a depth of about 25, 5 and 2, respectively. You can check with `BAMDiagnostics` if the resulting files `ATLAS_simulations_downsampled_*0.100000*.bam` have the correct depth.

Now repeat the estimation of heterozygosity for them by both calling and using genotype likelihoods.

* Do they still match?

More information on `downsample` can be found [here](/downsample#downsample).

### 3.1.7 Post-Mortem Damage

#### 3.1.7.1 The problem

The data we simulated above had sequencing errors, but none of the other complications of ancient DNA. One of those complications is post-mortem damage (PMD), which we want to study next.

Let us begin by simulating data with PMD:

```
atlas simulate --RGInfo ReadGroupInfo.json --chrLength 1000000 --depth 2 \
      --pmd "CT5:0.2*exp(-0.3*p)+0.07;GA3:0.1*exp(-0.3*p)+0.2" --out Ancient
```

Here, we indicate the PMD-pattern using `--pmd`. The PMD pattern on the 5’ end is C->T and follows an exponential curve, the pattern on the 3’ end is G->A with slightly different values for the exponential curve. We also used `--out Ancient` to set the output prefix to `Ancient`. The resulting BAM file will thus be named `Ancient.bam`.

This data was again simulated with default Felsenstein \(\theta=0.001\). But what is the estimate of \(\theta\) from that data? It should be much higher due to PMD being considered true variants.

```
atlas summaryStats --bam Ancient.bam --fasta Ancient.fasta
```

#### 3.1.7.2 The solution

To correct for PMD, we first need to estimate the errors from the data (as we know the true patterns only for simulated data). You can estimate PMD as

```
atlas estimateErrors --bam Ancient.bam --fasta Ancient.fasta --minDeltaLL 0.1 --out AncientEE
```

We set a relatively high deltaLL of 0.1 to make the estimation finish quicker, in reality, you should use a deltaLL of 0.001 or smaller. (`estimateErrors` also estimates the base-quality score recalibration at the same time, see next section.)

These estimates were written to the file `AncientEE_RGInfo.json`.

We can now use the learned pattern to account for PMD when calculating genotype likelihoods with `--RGInfo AncientEE_RGInfo.json`:

```
atlas summaryStats --bam Ancient.bam --fasta Ancient.fasta --RGInfo AncientEE_RGInfo.json
```

Do you now get \(\theta\) estimates close to \(\theta=0.001\)? Note that we only had 2x data for 1Mb with a lot of PMD!
Note also that the PMD pattern in the json-File works with all tasks in ATLAS, including calls:

```
atlas call --bam Ancient.bam --fasta Ancient.fasta --RGInfo AncientEE_RGInfo.json
```

### 3.1.8 Base-Quality Score Recalibration

#### 3.1.8.1 The Problem

Another issue with most low-depth data, whether ancient or modern, is that the base quality scores provided by the sequencing machines are usually off. That is an issues since the genotype likelihood calculation relies on them.

To illustrate the problem, we can again simulate data, this time with distorted quality scores using

```
atlas simulate --RGInfo ReadGroupInfo.json --chrLength 1000000 --depth 5 \
      --recal "intercept[0.1];quality:polynomial[0.9]" --out Distorted
```

Here we use a simple distortion where the real quality scores are only 90% of the sequencing machines values. Again, the default \(\theta=0.001\) was used to simulate data, but which \(\theta\) do you estimate? It should be too high, as the simulations indicate too high base qualities (i.e. too much confidence in the sequencing data).

```
atlas summaryStats --bam Distorted.bam --fasta Distorted.fasta
```

#### 3.1.8.2 The solution

Just as for PMD, we can estimate recal error patterns. As we simulated a polynomial quality-pattern, let’s see whether we can reproduce it:

```
atlas estimateErrors --bam Distorted.bam --fasta Distorted.fasta \
      --recalModel "intercept;quality:polynomial1" --poolRecal "all" --poolPMD "all" \
      --out DistortedPoly --minDeltaLL 0.5
```

Here we provide the model with `--recalModel "intercept;quality:polynomial1"`, saying we only want to estimate it based on the quality scores and a constant term (intercept). With `poolRecal "all"`, we are pooling the data of the two readgroups togehter, as we did not simulate a different pattern per readgroup. We als use `poolPMD "all"`, atlas will estimate a PMD-pattern, however, it’s values will be close to 0.

You can now use the polynomial re