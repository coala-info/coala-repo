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

## 4.3 downsample

**Downsampling a BAM file by removing reads**

`downsample` creates downsampled BAM files that contain a specified percentage of the original number of reads. More than one percentage/probability can be specified, and thus allows the creation of several downsampled BAM files at a time. In this task, all reads are considered, even those that do not pass the usual SAM flag filters.

### 4.3.1 Input

**Required inputs :**

|  |  |
| --- | --- |
| `--bam Input_bam_file.bam` | Input bam file |

**Optional inputs :**

* `None`

**Specific parameters :**

|  |  |
| --- | --- |
| `--prob numeric_value` | One value or a vector of percentages of reads to be kept in the downsampled BAM files.numeric\_value must be between 0 and 1 (inclusive). It is possible to obtain replicates by adding the desired number of replicates in curly brackets {} after the concerned percentage. |
| `--separateReads` or `--writeN` | `--separateReads` will down sample by removing reads and `--writeN` will down sample by setting bases to N. Default = `--writeN` |

**Optional parameters :**

|  |  |
| --- | --- |
| `--outQual integer_1,integer_2` | to constrain the quality scores to the indicated range (inclusive) when writing alignments. Default = uses the full range of quality scores when writing alignments. |
| `--writeBinnedQualities` | to write Illumina-binned quality scores. Default = writes raw quality scores. |

Engine parameters that are common to all tasks can be found [here](/engine#Engine).

### 4.3.2 Output

|  |  |
| --- | --- |
| \*\_separated\_\*Prob\*.bam or \*\_downsampled\_\*Prob\*.bam or | Downsampled BAM files(downsampled by removing reads) or Downsampled BAM files(downsampled by setting bases to N). |
| \*\_separated\_\*Prob\*.bam.bai or \*\_downsampled\_\*Prob\*.bam.bai | Index files for downsampled BAM files (downsampled by removing reads) or Index files for downsampled BAM files (downsampled by setting bases to N). |
| \*\_filterSummary.txt | .txt file with per readgroup general filter counts and all readgroups general filter counts. |

### 4.3.3 Usage Example

```
#! /bin/bash

# Set atlas path
atlas=$(dirname "$0")/../build/atlas

# Simulate a BAM File with depth 15
$atlas simulate --logFile simulate.out --depth 15

# downsample to depth 3.14
$atlas downsample --bam ATLAS_simulations.bam --depth 3.14 --logFile downsample.out

# simplify name of downsampled bam-file
mv ATLAS_simulations_downsampled_*.bam downsampled.bam
mv ATLAS_simulations_downsampled_*.bam.bai downsampled.bam.bai

# Calculate depth of downsampled BAM File
$atlas BAMDiagnostics --bam downsampled.bam --logFile BAMDiagnostics.out
```