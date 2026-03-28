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

## 4.4 filterBAM

**Writing reads that pass filters to BAM file**

`filterBAM` filters BAM files and produces a filtered BAM file along with index. See [Filter parameters](/filter#Filter) for all possible filter methods along with their respective default settings. Counts of all removed reads are printed to the terminal as well after filtering.

### 4.4.1 Input

**Required inputs :**

|  |  |
| --- | --- |
| `--bam Input_bam_file.bam` | Input bam file |

**Optional inputs :**

|  |  |
| --- | --- |
| `--pmd Input_PMD.txt` | post-mortem damage parameters (see [PMD](#PMD) for generating such a file) |
| `--recal recal.txt` | quality score recalibration file (see [recal](#recal) for further information) |

**Specific Parameters :**

|  |  |
| --- | --- |
| `--outQual integer_1,integer_2` | to constrain the quality scores to the indicated range (inclusive) when writing alignments. Default = uses the full range of quality scores when writing alignments. |
| `--writeBinnedQualities` | To write Illumina-binned quality scores. Default = Will write raw quality scores |
| `--acceptedDistance integer_value` | To specify distance up-to which mates will **not** be considered orphans. Default = 2000 bp. |
| `--keepOrphans` | To keep orphaned reads. Default = Will filter out orphaned reads. |
| `--removeSoftClippedBases` | To remove all softclipped bases. Default = Will not remove softclipped bases. |

**Note:** If both `outQual` and `writeBinnedQualities` are given, qualities will be truncated first, then binned, and may thus fall outside the requested range.

* See [Filter parameters](/filter#Filter) to apply specific filters for bases, reads and parsing window setting.

Engine parameters that are common to all tasks can be found [here](/engine#Engine).

### 4.4.2 Output

|  |  |
| --- | --- |
| \*.bam.bai | BAM index file |
| \*\_filterSummary.txt | .txt file with list of all applied filters, along with counts of removed reads. |
| \*\_\_filtered.bam | Filtered BAM file. |
| \*\_filtered.bam.bai | Index for filtered BAM file. |

### 4.4.3 Usage Example

```
#! /bin/bash

# Set atlas path
atlas=$(dirname "$0")/../build/atlas

# Simulate a BAM File with 3 diploid chromosomes and 1 haploid chromosome
$atlas simulate --logFile simulate.out --ploidy "2{3},1"

# Keep only the 3 diploid chromosomes and MQ>50
$atlas filterBAM --bam ATLAS_simulations.bam --chr "chr1,chr2,chr3" --filterMQ "[50,256]" --logFile filterBAM.out
```