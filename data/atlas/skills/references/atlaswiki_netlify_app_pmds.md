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

## 4.7 PMDS

**Filtering for ancient reads using PMDS (Post mortem damage score)**

Contamination from present-day DNA is a fundamental issue when studying ancient DNA from historical or archaeological material, and quantifying the amount of contamination is essential for downstream analyses. One way of measuring contamination or filtering out reads that most likely originate from modern DNA is to use the post-mortem damage score (PMDS) introduced by Skoglund et al. (2014). With this task, you can use ATLAS to calculate the PMDS for all reads. The output is a new BAM file, where each alignment is described by a field DS:f:<PMDS>, which specifies the alignment’s PMDS score. If the DS field already exists, it will be overwritten. It is possible to filter out the reads with a low PMDS score while writing the BAM file by using the option minPMDS or maxPMDS to specify the threshold value.

A PMDS score > 0 means that the read is more likely ancient than modern. The higher the score, the higher its probability of being ancient.

### 4.7.1 Input

**Required inputs :**

|  |  |
| --- | --- |
| `--bam Input_bam_file.bam` | Input bam file. |
| `--fasta Input_refrence_genome_file.fasta` | Reference genome. |

**Optional inputs :**

|  |  |
| --- | --- |
| `--recal recal.txt` | Quality score recalibration file (see [recal](#recal%7D%20for%20further%20information). |
| `--pmd Input_PMD.txt` | Post-mortem damage parameters (see [PMD](#PMD) for generating such a file). |

**Specific Parameters :**

|  |  |
| --- | --- |
| `--minPMDS integer_value` | Filter out reads that have a PMDS score below the specified value. Default = -10000. |
| `--maxPMDS integer_value` | Filter out reads that have a PMDS score above the specified value. Default = 10000. |

**Engine Parameters :**

Engine parameters that are common to all tasks can be found [here](/engine#Engine).

### 4.7.2 Output

|  |  |
| --- | --- |
| \*\_PMDS.bam | bam file where each alignment has a tag DS:f:<PMDS> |

### 4.7.3 Usage Example

```
#! /bin/bash

# Set atlas path
atlas=$(dirname "$0")/../build/atlas

# Simulate a BAM File with exponential pmd pattern
$atlas simulate --logFile simulate.out --pmd "CT5:0.2*exp(-0.3*p)+0.07;GA3:0.2*exp(-0.25*p)+0.06"

# estimate PMD pattern
$atlas estimateErrors --bam ATLAS_simulations.bam --fasta ATLAS_simulations.fasta --logFile estimateErrors.out --out ee

# Create BAM file with PMDS scores using PMD pattern in 'ee_RGInfo.json'
$atlas PMDS --bam ATLAS_simulations.bam --fasta ATLAS_simulations.fasta --RGInfo ee_RGInfo.json --logFile PMDS.out

# filter file with PMDS score > 1
$atlas filterBAM --filterPMDS 1 --bam ATLAS_simulations_PMDS.bam --logFile filterBAM.out
```