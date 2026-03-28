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

## 4.8 qualityTransformation

**Printing Quality Transformation**

`qualityTransformation` allows you to track how the base quality scores are transformed by recalibration (either BQSR or [recal](#recal)). Specifically, you can make pairwise comparisons between two sets of quality scores:

* the original quality scores versus those obtained through BQSR or recal recalibration
* the quality scores resulting from BQSR versus those resulting from a run of recal
* the quality scores resulting from two different runs of recal, e.g. one performed using the X chromosome and one performed using mitochondrial DNA

The log file reports the [R squared](https://en.wikipedia.org/wiki/Coefficient_of_determination), which represents the correlation between the two sets of quality scores.

### 4.8.1 Input

**Required inputs :**

|  |  |
| --- | --- |
| `--bam Input_bam_file.bam` | Input bam file |

**Optional inputs :**

|  |  |
| --- | --- |
| `--pmd "library_type:model_for_5'_read:model_for_3'_read"` or `--RGInfo` | Library type followed by the model to be used for the 5-prime read-end and the 3-prime read-end which can be either “Exponential” or “Empiric”. All three arguments must be provided as a string, divided by colons (:). e.g. : –pmdModels “doubleStrand:Exponential:Exponential”. Used to specify Post-mortem damage parameters. Can also be provided as a `.txt` file (see [PMD](#PMD)for generating such a file). Default = Will assume there is no PMD in the data. |
| `--recal recal_model` or `--RGInfo` | A common recal model for all read groups. Used to specify Quality score recalibration parameters. Can also be provided as a .txt file (see [recal](#recal) for further information). Default = ‘-’, no recalibration is performed. |

**Specific Parameters :**

* See [Filter parameters](/filter#Filter) to apply specific filters for bases, reads and parsing window setting.

Engine parameters that are common to all tasks can be found [here](/engine#Engine).

### 4.8.2 Output

|  |  |
| --- | --- |
| \*\_RGInfo.json | File containing read group info. |
| \*\_SimReadGroup1\_qualityTransformation.txt | File containing quality transformation for each read group. |
| \*\_qualityTransformation.txt | File containing quality transformation of total data. |
| \*\_filterSummary.txt | File containing Filter summary of general filter counts. |

### 4.8.3 Usage Example

```
#! /bin/bash

# Set atlas path
atlas=$(dirname "$0")/../build/atlas

# Simulate a BAM File with actual quality = 0.9*BaseQuality
$atlas simulate --logFile simulate.out --recal "quality:polynomial[0.9]"

# Create Quality Transformation
$atlas qualityTransformation --bam ATLAS_simulations.bam --logFile qualityTransformation.out
```