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

## 3.2 Data from One Population

Let us first create a directory specific for this tutorial:

```
mkdir atlas-tutorial_B
cd atlas-tutorial_B
```

### 3.2.1 Simulating a Population

We will start by simulating a population of 11 samples, adding some Postmortem Damage and Sequencing Errors. We will use the following, non-standard, site frequency spectrum:

```
echo '#SHAPE=<23>
0.96 0.005 0.01 0.0025 0.003 0.002 0.0016 0.0014 0.0013 0.001 0.001 0.0009 0.0008 0.00075 0.0007 0.00065 0.0006 0.0005 0.0006 0.0005 0.0005 0.0005 0.0004' > sfs.txt
```

```
atlas --task simulate --type SFS --sfs sfs.txt \
       --sampleSize 11 --chrLength 123456 --depth 13 --ploidy 2 \
      --recal "intercept[0.1];quality:polynomial[0.95,0.01]" \
      --pmd "CT5:0.09*exp(-0.2*p)+0.01;GA3:0.11*exp(-0.2*p)+0.01"
```

### 3.2.2 Estimating the Errors

First, for each bam-file, we need to estimate the PMD and Sequencing errors. This time, we will estimate the default empiric error model (this may take a few minutes):

```
for bam in *.bam; do
    atlas estimateErrors --minDeltaLL 0.1 --fasta ATLAS_simulations.fasta --bam $bam
done
```

This creates 11 json-files, called ATLAS\_simulations\_ind{1..11}\_RGInfo.json

### 3.2.3 Genotype Likelihood Files

The bam-file format is a per-read file format, however, for most downstream analysis, and especially when comparing different samples, we want to do this per site (position on chromosome). For this, the Genotype Likelihood File Format is convenient, which stores for each site the likelihoods of the ten genotypes: AA, AC, AG, AT, CC, CG, CT, GG, GT, TT.

Now, we can create the GLF files using the task GLF, and provide the correct RGInfo JSON file with learned sequencing errors and PMD for each sample:

```
for bam in *.bam; do
    RGInfo=${bam%.bam}_estimateErrors_RGInfo.json
    atlas GLF --bam $bam --RGInfo $RGInfo
done
```

The GLF-files are called `*.glf.gz`, and the index-files `*.glf.idx`. You can open the index-files with a text editor and verify that they all have the same number of chromosomes and the same length.

You can print a GLF-file using the following command:

```
atlas printGLF --glf ATLAS_simulations_ind5_GLF.glf.gz | less
```

The values of the likelihoods are 16-bit Phreds `= -1000*log10(P))`, so a value of 301 would mean a log10Probability of -0.301 or a Probability of 0.5.

We will define a variable that holds all the glf-files:

```
samples=$(ls -1 *.glf.gz | paste -s -d ',' -)
```

### 3.2.4 Major and Minor Alleles

Now that we have the GLF-files, we can do various population tasks on them. Let’s start by Estimating major and minor alleles with the task `majorMinor`

```
atlas majorMinor --glf $samples
```

This creates the Variant Call Format file called ATLAS\_majorMinor.vcf.gz

### 3.2.5 Site Frequency Spectrum (SFS)

We simulated the population with a given SFS, so let’s see if we can estimate it. First, we need to estimate the site allele frequencies using the task `saf`:

```
atlas saf --glf $samples --fasta ATLAS_simulations.fasta
```

This creates saf-files. If you wish to view it, you can use the command `realSFS print` of the angsd tool chain.

To infer the site frequency spectrum of our population, we will use the tool winsfs. Please follow the following instructions to install it:

<https://github.com/malthesr/winsfs?tab=readme-ov-file#installation>

Please set `winsfs` as a global alias with:

```
alias winsfs="/path/to/your/winsfs/build/winsfs"
```

We can calculate and view the normalized site frequency spectrum using the same command:

```
winsfs saf.saf.idx | winsfs view --normalise
```

Is it similar to the one we simulated? What would the SFS look like without correcting the PMD and sequencing errors?

### 3.2.6 Deviations from HWE

We simulated the data under Hardy-Weinberg equilibrium (HWE). Let’s check if the simulated data is compatible with HWE or whether we identify any deviations of HWE in our data. We will do so using two different approaches.

First, let’s visually inspect whether some loci show deviations from HWE. For that we will infer allele and genotype frequencies for each locus and plot them against each other. We can use the task `alleleFreq` of for that:

```
atlas alleleFreq --vcf ATLAS_majorMinor.vcf.gz --writeGenoFreq
```

This task estimates allele frequencies under i) HWE and ii) from genotype frequencies (no HWE assumption). The option `--writeGenoFreq` tells Atlas to also write the genotype frequncies. Once this is done, we can plot the frequencies of heterozygous individuals against that of the allele frequencies estimated from the genotype frequencies. Under HWE, we have clear expectations for this relationship:

```
af <- read.table("ATLAS_majorMinor_alleleFreq.txt.gz", header=TRUE)

plot(af$freqAltGF_Population, af$freqGenoRefAlt_Population)

add expectation
f <- seq(0, 0.5, length.out = 1000)
lines(f, 2*f*(1-f), lwd = 2, col = 'orange2')
```

Note that this worked well for the simulated data here but could be difficult for real data with many more sites. It could thus make sense to limit this analysis to just sites with a meaningful allele frequency, for instance using the argument `--minMAF` when running the task `alleleFreq`.

Second, let’s infer the inbreeding coefficient F from the genotype likelihood using the task `inbreeding`:

```
atlas inbreeding --vcf ATLAS_majorMinor.vcf.gz --minMAF 0.05 --numBurnin 5 --iterations 10000
```

This will generate a Bayesian estimate of the inbreeding coefficient using an MCMC algorithm, so it will take some time. To speed it up, we used the argument `--minMAF 0.05` to limit is to polymoprhic sites with a minimal allele frequency, as monomorphic (or low-frequency) sites have no (or very little) info regarding inbreeding. We chose 0.05 as the threshold as this is a tiny bit more than a singleton (1/22 = 0.045). We also used `--numBurnin 5` and `--iterations 10000` to run the MCMC a bit shorter so we do not need to wait too long here - the default is probably better for your real data.

Once it finished, there are several output files of interest:
- The file ATLAS\_majorMinor\_F\_statePosteriors.txt will give you the posteriors for a model with F>0 (state\_1), so basically how sure we are that F is not zero.
- The file ATLAS\_majorMinor\_F\_meanVar.txt gives you the mean and variance of the posterior on F.
- the file ATLAS\_majorMinor\_F\_trace.txt gives you the trace of F that can be used to plot the posterior distribution as follows:

```
mcmc <- read.table("ATLAS_majorMinor_F_trace.txt", header=TRUE)
plot(density(mcmc$F))
```

As you should see, there is very strong evidence for inbreeding. That is because we similated a non-HWE SFS. So let’s see some data that is actually in HWE for a comparison! You can easily generate such data as follows:

```
atlas simulate --vcf --type HW --sampleSize 11 --out inHWE
```

Note that we here simulated data without the need to recalibrate and also directly simulated a VCF to avoid the steps needed to obtain one we did above. This is just to speed this demonstration up a bit - for your real data you would need to go through all steps, of course. Also we changed the name of the output files ti have prefix `inHWE`, so the VCf file is called inHWE.vcf.gz.

If you now check for a deviation in HWE for this data, does it look different?

You can also simulate data with a specific inbreeding coefficient to check using the argument `--F`:

```
atlas simulate --vcf --type HW --F 0.2 --sampleSize 11
```