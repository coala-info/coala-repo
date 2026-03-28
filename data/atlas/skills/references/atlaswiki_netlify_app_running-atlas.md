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

## 1.3 Running ATLAS

### 1.3.1 Argument syntax

The program ATLAS is launched via the command line, followed by the task name and argument names and the name of argument input files.

```
/path/to/atlas/build/atlas [taskname] --[argument_name] /path/to/input/for/argument/[argument_input_file]
```

Or you can add the path to atlas as an alias in your .bashrc file as follows to avoid having to indicate the path to atlas/build all the time.

```
alias atlas='/path/to/atlas/build/atlas'
```

```
atlas [taskname] --[arguments] /path/to/input/for/argument/[argument_input_file]
```

On the command line, the first entry must be the exact task name (e.g. `BAMDiagnostics`), followed by the argument names and their optional values. The order of arguments does not matter and if the same argument is listed more than once, only the latest entry is considered (facilitates the use of default-parameters for your pipelines). Go to [Quickstart](/quickstart#quickstart) for a usage example.

Specific parameters can be found on the respective page of this manual.
A list of all tasks can be found
[here](#Tasklist). Engine
parameters that are common to all tasks can be found
[here](/engine#Engine).

### 1.3.2 Argument files

All necessary arguments can also be specified in the argument file.
On each line, you can specify a pair of argument name and corresponding value (separated by one or several white space characters, i.e. blanks or tabs).
The order is of no importance. Comments are proceeded with a double slash ’‘//’’.
Empty lines may be present anywhere within the file and are ignored.

For example, if the argument file is named **example.arguments**, the
program has to be launched as follows:

`/path/to/atlas/build/atlas example.arguments`

An example for a \*.arguments file to run
[BAMDiagnostics](/bamdiagnostics#BAMDiagnostics) would be:

> task BAMDiagnostics
> // this is a comment
> bam example.bam
> //comment
> filterMappingLength [55,100]
> keepDuplicates
> filterSoftClips //add comment here
> // Add additional arguments as required

Additional, arguments can be passed on the command line. In that case, they will be interpreted “after” the arguments from the file and overwrite double entries.

### 1.3.3 Progress Report & Log File

By default, ATLAS writes out verbose information to stdout.
To reduce the amount of information printed, use the argument `--silent`.
To save the progress report into a file (e.g. **out.txt**), simply redirect
the output using
`/path/to/atlas/build/atlas example.arguments verbose > out.txt`

Alternatively, ATLAS can also write the progress report to a log file.
To invoke this, simply use the argument `--logFile`, followed by the
name of the desired file. Note that this will overwrite any existing
file with that name. Note, verbose and logFile can both be
used at the same time.