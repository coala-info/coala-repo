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

# Welcome to ATLAS, your guide to the world of low-depth and ancient DNA!

*last update: 2026-02-03*

# ATLAS and the ATLAS-pipeline

ATLAS, the Analysis Tools for Low-depth and Ancient Samples, are a suite of bioinformatic tools that cover all steps to gain insights from low-depth samples, including ancient samples. It learns and accounts for sequencing errors as well as post-mortem damage to calauclate accurate genotype likelihoods. These are then used to obtain variant calls, estimate genetic diversity of both individuals and populations, or to generate input files for a wide range of downstream analyses. It further offers a large suite of tools to process, diagnose and summarize sequencing data.

ATLAS is most easily used on batches of samples via the ATLAS-pipeline, a snakemake pipeline built around ATLAS.

### Contributors

ATLAS and the ATLAS-pipeline are highly collaborative projects driven passionately by:

#### Project Lead

* Daniel Wegmann (initial developer, project lead)

#### ATLAS Lead Developers

* Andreas Füglistaler (current)
* Vivian Link (former)
* Athanasios Kousathanas (former)

#### ATLAS-Pipeline Lead Developers

* Xenia Wietlisbach (current)
* Ilektra Schulz (former)

#### Contributors

* Madleina Caduff
* Raphael Eckel
* Carlos Reyna
* Aparna Pandey
* Michael Jopiti
* Marc-Olivier Beausoleil
* Zuzana Hofmanova
* Kamil S Jaroň

#### Conceptual Input

* Jens Blöcher
* Christoph Leuenberger
* Krishna Veeramah
* Joachim Burger

#### Testing

* Christian Sell
* Amelie Scheu

### Citation

A paper describing ATLAS in detail is currently in the works. In the meantime, please cite our (unfortunately a bit dated) preprint:

ATLAS: Analysis Tools for Low-depth and Ancient Samples
Vivian Link, Athanasios Kousathanas, Krishna Veeramah, Christian Sell, Amelie Scheu, Daniel Wegmann. bioRxiv 105346; doi: <https://doi.org/10.1101/105346>

If you make use of the ATLAS-pipeline, please cite the following paper:

The genomic origins of the world’s first farmers
Marchi Nina, Laura Winkelbach, Ilektra Schulz, Maxime Barmi et al. Cell 185(11) doi: 10.1016/j.cell.2022.04.008