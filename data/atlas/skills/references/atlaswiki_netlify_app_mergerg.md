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

## 4.6 mergeRG

**Merging read groups in a BAM file**

`mergeRG` merges together read groups that are too small for data analysis. Some data analysis tools require certain amount of reads per read group in order to work properly. Base Quality Score Recalibration (BQSR), for example, requires a minimum of around 6 million reads. If some read groups are too small, `mergeRG` can be used to merge them.

Read groups should be merged according to library, sequencing run and sequencing lane, in that order. The more diverse the read groups are, the less it is advised to merge them, since programs like BQSR estimate parameters that are very specific to the read group. Read groups that have different post-mortem damage patterns should not be merged. For example, read groups that were treated for post-mortem damage e.g. with Uracil-DNA glycosylase should not be merged with read groups that were not.

### 4.6.1 Input

**Required inputs :**

|  |  |
| --- | --- |
| `--bam Input_bam_file.bam` | Input bam file. |
| `--readGroups Input_text_file.txt` | Input text file with information about Read groups to be merged. All read groups that are to be merged should be in written in a single line separated by a tab.First Read group on the line specifies the name of the new, combined read group. File can contain multiple lines indicating multiple merges. |

**Optional inputs :**

* `none`

**Specific Parameters :**

|  |  |
| --- | --- |
| `--outQual integer_1,integer_2` | to constrain the quality scores to the indicated range (inclusive) when writing alignments. Default = uses the full range of quality scores when writing alignments. |
| `--writeBinnedQualities` | to write Illumina-binned quality scores. Default = writes raw quality scores. |

* See [Filter parameters](/filter#Filter) to apply specific filters for bases, reads and parsing window setting.

Engine parameters that are common to all tasks can be found [here](/engine#Engine).

### 4.6.2 Output

|  |  |
| --- | --- |
| \*\_mergedRG.bam | BAM file with merged Read groups. |
| \*\_mergedRG.bam.bai | Index file for BAM file with merged Read groups. |
| \*\_filterSummary.txt | Filter summary File with information about all Read groups: merged or otherwise. |

### 4.6.3 Usage Example

```
#! /bin/bash

# Set atlas path
atlas=$(dirname "$0")/../build/atlas

# Simulate a BAM File with 3 readgroups
$atlas simulate --logFile simulate.out --numReadGroups 3

# Create merge-file which merges SimReadGroup2 into SimReadGroup1
echo "receiver donor" > rgs.txt
echo "SimReadGroup1 SimReadGroup2" >> rgs.txt

# Merge readgroups
$atlas mergeRG --bam ATLAS_simulations.bam --logFile mergeRG.out --readGroups rgs.txt
```