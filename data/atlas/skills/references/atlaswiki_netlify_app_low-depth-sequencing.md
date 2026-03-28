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

## 2.1 Low-depth sequencing

There are multiple reasons to perform so-called low-depth sequencing (with an average sequencing depth often far below 10X). While sometimes it is due to sample accessibility (not enough material available, see also [Ancient DNA](/ancient-dna#ancient-dna)), low-depth sequencing can also be highly beneficial in cases where questions need to be answered on a population level instead of an individual level. For these research questions, sequencing more samples at a lower depth instead of fewer samples at a high depth gives the opportunity to increase the knowledge on allele frequencies within and between populations.

**BAM file generation**
It is important, that all your BAM files are aligned and filtered the same way to avoid batch effects and reference biases. We further highly recommend performing a local In-Del realignment ([GATK 3.5](https://gatk.broadinstitute.org/hc/en-us)) and to merge the mates in paired-end read groups to avoid overlapping read-ends to be counted twice in your analysis. For all steps from sequencing data to population genetic analysis, we provide our in-house [Pipeline].

**Genotype likelihoods**
As with a lower sequencing depth, sources of errors such as sequencing errors and wrongly mapped reads decrease the accuracy of genotype calls and lead to biases in downstream analysis (e.g. underestimating genetic diversity), we advise inferring genotype likelihoods instead. Genotype likelihoods are assessed for all possible true genotypes while accounting for genotyping uncertainty. (For more information on how we access genotype likelihoods, see [GLF](/glf#GLF)).

**Base quality recalibration**
However, genotype likelihoods rely heavily on the assumption that error rates are correct. These are reported as base qualities by the sequencing machine. Most of the time, these reported base qualities are inaccurate and must be recalibrated. While there are existing methods for base quality recalibration, they rely either on the knowledge of variant sites in the genome or on sequencing depth. We thus implemented a way to learn sequencing errors without prior knowledge of variant sites, but rather based on monomorphic or pseudohaploid regions in the genome (estimateErrors). The recalibration of base quality scores is highly recommended not only - but especially when using genotype likelihoods. For more information on how we learn and apply base quality recalibration, see [estimateErrors](/estimateerrors#estimateErrors).

**Downstream analysis**
On a single sample basis, you can now infer heterozygosity (\(\theta\)) or - if further downstream analysis depend on it - you can also base call with *ATLAS*.
To assess genetic diversity within and between populations, the major and minor alleles can further be inferred from *GLF* files. The task [majorMinor](/majorminor#majorMinor) prints the genotype likelihood for major and minor alleles, respectively into one *VCF* file which can be used for several downstream population genetic analyses such as [Inbreeding](/inbreeding#inbreeding). The MajorMinor *VCF* can also be transformed to *Beagle* format to perform a PCA with [*ANGSD*](http://www.popgen.dk/angsd/index.php/ANGSD) .