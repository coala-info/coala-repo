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

## 4.5 mergeOverlappingReads

**Merging paired-end reads in BAM file**

`mergeOverlappingReads` should be run before any consecutive variant discovery or population genetic tool to merge paired end reads. You need to specify which read groups should be considered for merging. Others will just be written to the BAM as they are.

### 4.5.1 Input

**Required inputs :**

|  |  |
| --- | --- |
| `--bam Input_bam_file.bam` | Input bam file. |
| `--readGroupSettings Input_text_file.txt` | Input text file specifying read group settings: the names of the read group to be considered, if they are single-end read, paired or mixed, and if they are single-end or paired their maximum cycle number (separated by any white space). The read group names can be found in the header of your BAM file, but note that ‘ID:’ is not part of the read group name. If you do not know the maximum cycle number the genome was sequenced at, you can find the maximum read length in the BAM file with the task [BAMDiagnostics](/bamdiagnostics#BAMDiagnostics). If you do not know whether a read group was sequenced with a paired or single-end protocol, or whether it is mixed (i.e. contains reads from both paired and single-end sequencing) you can check the SAM flags of the reads. If you specify the wrong type, ATLAS will throw an error saying that it found nonsensical settings for an offending read. |

**Optional inputs :**

|  |  |
| --- | --- |
| `--blacklist blacklist.txt` | Input text file to filter out specific reads (each on a new line) provided as a list that should be ignored and just written to file. Default = nothing specific is filtered out. |
| `--recal OR --RGInfo sample_RGInfo.json` | Quality score recalibration file (see [estimateErrors](/estimateerrors#estimateErrors) for further information). |
| `--pmd OR --RGInfo sample_RGInfo.json` | Post-mortem damage parameters (see [estimateErrors](/estimateerrors#estimateErrors) for further information). |

**Specific Parameters :**

|  |  |
| --- | --- |
| `--mergingMethod method_to_be_used_for_merging` | To specify the method to be used for merging. Options: middle, firstMate, secondMate, highestQuality, randomRead. Default = middle. |
| `--outQual integer_1,integer_2` | To constrain the quality scores to the indicated range when writing alignments. Default = Will use the full range of quality scores when writing alignments. |
| `--writeBinnedQualities` | To write Illumina-binned quality scores. Default = Writes raw quality scores. |
| `--keepOrphans` | To keep orphaned reads. Default = Will filter out orphaned reads. |
| `--acceptedDistance integer_value` | To specify distance up-to which mates will **not** be considered orphans. Default = 2000 bp. |
| `--removeSoftClippedBases` | To remove all softclipped bases. Default = Will not remove softclipped bases. |

Engine parameters that are common to all tasks can be found [here](/engine#Engine).

### 4.5.2 Output

|  |  |
| --- | --- |
| \*\_merged.bam | A BAM file with merged reads. |
| \*\_merged.bam.bai | Index files for merged BAM files. |
| \*\_filterSummary.txt | A text file with filter summary. |

### 4.5.3 Usage Example

```
#! /bin/bash

# Set atlas path
atlas=$(dirname "$0")/../build/atlas

# Simulate a BAM File with paired end reads
$atlas simulate --logFile simulate.out --seqType "paired"

# Merge reads
$atlas mergeOverlappingReads --bam ATLAS_simulations.bam --logFile mergeOverlappingReads.out
```

### 4.5.4 Additional Information

**Merging Methods**

|  |  |
| --- | --- |
| `none` | No merging. |
| `middle` | Will keep half of the overlapping positions of each mate. |
| `firstMate` | Will merge first mate at overlapping positions. |
| `secondMate` | Will merge second mate at overlapping positions. |
| `highestQuality` | Will keep read with the highest minimum quality at overlapping positions. |
| `randomRead` | Will keep random read for all overlapping positions. |