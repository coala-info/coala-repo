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

## 5.1 allelicDepth

**Writing genotype likelihoods to a GLF file**

`allelicDepth` creates a table summarizing the composition of the bases covering each site. It is basically a flattened 4-dimensional table.

### 5.1.1 Input

**Required inputs :**

|  |  |
| --- | --- |
| `--bam Input_bam_file.bam` | Input BAM file. |

**Optional inputs :**

|  |  |
| --- | --- |
| `--recal recal.txt` | Quality score recalibration file (see [recal](#recal) for further information). |
| `--pmd Input_PMD.txt` | Post-mortem damage parameters (see [PMD](#PMD) for generating such a file). |

**Specific Parameters :**

|  |  |
| --- | --- |
| `--readUpToDepth integer_value` | To set read depth up-to which reads are to be considered and ignore additional bases. Default = 1000. |
| `--filterDepth integer_value1,integer_value2` | To filter out sites with sequencing depth outside the range [integer\_value1,integer\_value2]. Default = Will keep sites regardless of depth. |
| `--filterCpG` | To filter out CpG sites. Default = Will keep CpG sites. |
| `--maxRefN numeric_value` | To specify the max fraction of sites with reference=‘N’ in a window, for the window to still be considered. numeric\_value must be between 0 and 1 (inclusive). Default = 1. |
| `--filterBaseQual integer_value1,integer_value2` | To filter out bases with quality outside the range [integer\_value1,integer\_value2]. Default = [1,93]. |
| `--ignoreContexts` | To filter out bases based on context. Default = keep bases regardless of base context. |
| `--printAll` | To print cells with zero counts as well. Default = Will only print cells with non-zero counts. |

Engine parameters that are common to all tasks can be found [here](/engine#Engine).

### 5.1.2 Output

|  |  |
| --- | --- |
| \* | A table with the following columns: 1) A,C,G,T: 4 columns listing the amount of bases of each type. 2) Counts: the number of sites that have this specific base composition. 3) Depth: the total depth of the base composition (equal to sum of columns A,C,G and T). |

### 5.1.3 Usage Example

```
#! /bin/bash

# Set atlas path
atlas=$(dirname "$0")/../build/atlas

# Simulate a BAM File
$atlas simulate --logFile simulate.out

# Create allelicDepth histogram, limit depth to 100
$atlas allelicDepth --readUpToDepth 100 --bam ATLAS_simulations.bam --logFile allelicDepth.out
```