[canu](index.html)

latest

* [Canu Quick Start](quick-start.html)
* [Canu FAQ](faq.html)
* [Canu Tutorial](tutorial.html)
* [Canu Pipeline](pipeline.html)
* Canu Parameter Reference
  + [Global Options](#global-options)
  + [Process Control](#process-control)
  + [General Options](#general-options)
  + [File Staging](#file-staging)
  + [Cleanup Options](#cleanup-options)
  + [Executive Configuration](#executive-configuration)
  + [Overlapper Configuration](#overlapper-configuration)
    - [Overlapper Configuration, ovl Algorithm](#overlapper-configuration-ovl-algorithm)
    - [Overlapper Configuration, mhap Algorithm](#overlapper-configuration-mhap-algorithm)
    - [Overlapper Configuration, mmap Algorithm](#overlapper-configuration-mmap-algorithm)
  + [Overlap Store](#overlap-store)
  + [Meryl](#meryl)
  + [Overlap Based Trimming](#overlap-based-trimming)
  + [Trio binning Configuration](#trio-binning-configuration)
  + [Grid Engine Support](#grid-engine-support)
    - [Grid Engine Configuration](#grid-engine-configuration)
    - [Grid Options](#grid-options)
  + [Algorithm Selection](#algorithm-selection)
    - [Algorithm Execution Method](#algorithm-execution-method)
  + [Overlap Error Adjustment](#overlap-error-adjustment)
  + [Unitigger](#unitigger)
  + [Consensus Partitioning](#consensus-partitioning)
  + [Read Correction](#read-correction)
  + [Output Filtering](#output-filtering)
* [Software Background](history.html)

[canu](index.html)

* [Docs](index.html) »
* Canu Parameter Reference
* [Edit on GitHub](https://github.com/marbl/canu/blob/master/documentation/source/parameter-reference.rst)

---

# Canu Parameter Reference[¶](#canu-parameter-reference "Permalink to this headline")

To get the most up-to-date options, run

> canu -options

The default values below will vary based on the input data type and genome size.

Boolean options accept true/false or 1/0.

Memory sizes are assumed to be in gigabytes if no units are supplied. Values may be non-integer
with or without a unit - ‘k’ for kilobytes, ‘m’ for megabytes, ‘g’ for gigabytes or ‘t’ for
terabytes. For example, “0.25t” is equivalent to “256g” (or simply “256”).

## Global Options[¶](#global-options "Permalink to this headline")

The catch all category.

rawErrorRate <float=unset>
:   The allowed difference in an overlap between two uncorrected reads, expressed as fraction error.
    Sets [corOvlErrorRate](#corovlerrorrate) and [corErrorRate](#corerrorrate). The
    [rawErrorRate](#rawerrorrate) typically does not need to be modified. It might need to be
    increased if very early reads are being assembled. The default is 0.300 For PacBio reads, and
    0.500 for Nanopore reads.

correctedErrorRate <float=unset>
:   The allowed difference in an overlap between two corrected reads, expressed as fraction error.
    Sets [obtOvlErrorRate](#obtovlerrorrate), [utgOvlErrorRate](#utgovlerrorrate),
    [obtErrorRate](#obterrorrate), [utgErrorRate](#utgerrorrate), and [cnsErrorRate](#cnserrorrate).
    The [correctedErrorRate](#correctederrorrate) can be adjusted to account for the quality of
    read correction, for the amount of divergence in the sample being assembled, and for the amount of
    sequence being assembled. The default is 0.045 for PacBio reads, and 0.144 for Nanopore reads.

    For low coverage datasets (less than 30X), we recommend increasing [correctedErrorRate](#correctederrorrate) slightly, by 1% or so.

    For high-coverage datasets (more than 60X), we recommend decreasing [correctedErrorRate](#correctederrorrate) slightly, by 1% or so.

    Raising the [correctedErrorRate](#correctederrorrate) will increase run time. Likewise,
    decreasing [correctedErrorRate](#correctederrorrate) will decrease run time, at the risk of
    missing overlaps and fracturing the assembly.

minReadLength <integer=1000>
:   Reads shorter than this are not loaded into the assembler. Reads output by correction and
    trimming that are shorter than this are discarded.

    Must be no smaller than minOverlapLength.

    [In Canu v1.9 and earlier] If set high enough, the gatekeeper module will claim there are errors in the input reads,
    as too many of the input reads have been discarded. As long as there is sufficient coverage,
    this is not a problem. See [stopOnReadQuality](#stoponreadquality) and
    [stopOnLowCoverage](#stoponlowcoverage)

minOverlapLength <integer=500>
:   Overlaps shorter than this will not be discovered. Smaller values can be used to overcome lack of
    read coverage, but will also lead to false overlaps and potential misassemblies. Larger values
    will result in more correct assemblies, but more fragmented, assemblies.

    Must be no bigger than minReadLength.

readSamplingCoverage <integer=unset>
:   After loading all reads into the sequence store, discard some reads so that
    this amount of coverage remains. Reads are discarded according to the score
    described in [readSamplingBias](#readsamplingbias).

readSamplingBias <float=0.0>
:   Adjust the sampling bias towards discarding longer (negative numbers) or
    shorter (positive numbers) reads. Reads are assigned a score equal to
    random\_number \* read\_length ^ bias and the lowest scoring reads are
    discarded, as described in [readSamplingCoverage](#readsamplingcoverage).

    In the pictures below, green reads are kept, while purple reads are
    discarded. The reads are along the X axis, sorted by decreasing score.
    The Y axis is the length of each read.

    A bias of 0.0 will retain random reads:

    ![_images/bias=+00.png](_images/bias=+00.png)

    A negative bias will retain shorter reads:

    ![_images/bias=-01.png](_images/bias=-01.png)
    ![_images/bias=-10.png](_images/bias=-10.png)

    A positive bias will retain longer reads:

    ![_images/bias=+01.png](_images/bias=+01.png)
    ![_images/bias=+10.png](_images/bias=+10.png)

genomeSize <float=unset> *required*
:   An estimate of the size of the genome. Common suffices are allowed, for example, 3.7m or 2.8g.

    The genome size estimate is used to decide how many reads to correct (via the [corOutCoverage](#coroutcoverage)
    parameter) and how sensitive the mhap overlapper should be (via the [mhapSensitivity](#mhapsensitivity)
    parameter). It also impacts some logging, in particular, reports of NG50 sizes.

fast <toggle>
:   This option uses MHAP overlapping for all steps, not just correction, making assembly significantly faster. It can be used on any genome size but may produce less continuous assemblies on genomes larger than 1 Gbp. It is recommended for nanopore genomes smaller than 1 Gbp or metagenomes.

    The fast option will also optionally use [wtdbg](https://github.com/ruanjue/wtdbg2) for unitigging if wtdbg is manually copied to the Canu binary folder. However, this is only tested with very small genomes and is **NOT** recommended.

canuIteration <internal parameter, do not use>
:   Which parallel iteration is being attempted.

canuIterationMax <integer=2>
:   How many parallel iterations to try. Ideally, the parallel jobs, run under grid control, would
    all finish successfully on the first try.
    Sometimes, jobs fail due to other jobs exhausting resources (memory), or by the node itself
    failing. In this case, canu will launch the jobs again. This parameter controls how many times
    it tries.

onSuccess <string=unset>
:   Execute the command supplied when Canu successfully completes an assembly. The command will
    execute in the <assembly-directory> (the -d option to canu) and will be supplied with the name of
    the assembly (the -p option to canu) as its first and only parameter.

onFailure <string=unset>
:   Execute the command supplied when Canu terminates abnormally. The command will execute in the
    <assembly-directory> (the -d option to canu) and will be supplied with the name of the assembly
    (the -p option to canu) as its first and only parameter.

    There are two exceptions when the command is not executed: if a ‘spec’ file cannot be read, or if
    canu tries to access an invalid parameter. The former will be reported as a command line error,
    and canu will never start. The latter should never occur except when developers are developing
    the software.

## Process Control[¶](#process-control "Permalink to this headline")

showNext <boolean=false>
:   Report the first major command that would be run, but don’t run it. Processing to get to that
    command, for example, checking the output of the previous command or preparing inputs for the next
    command, is still performed.

stopOnReadQuality <string=false>
:   [In Canu v1.9 and earlier] If set, Canu will stop with the following error if there are significantly fewer reads or bases
    loaded into the read store than what is in the input data.

    ```
    Gatekeeper detected potential problems in your input reads.

    Please review the logging in files:
      /assembly/godzilla/asm.gkpStore.BUILDING.err
      /assembly/godzilla/asm.gkpStore.BUILDING/errorLog

    If you wish to proceed, rename the store with the following command and restart canu.

      mv /assembly/godzilla/asm.gkpStore.BUILDING \
         /assembly/godzilla/asm.gkpStore.ACCEPTED

    Option stopOnReadQuality=false skips these checks.
    ```

    The missing reads could be too short (decrease [minReadLength](#minreadlength) to include
    them), or have invalid bases or quality values. A summary of the files loaded and errors detected
    is in the `asm.gkpStore.BUILDING.err` file, with full gory details in the
    `asm.gkpStore.BUILDING/errorLog`.

    To proceed, set `stopOnReadQuality=false` or rename the directory as shown.

    Note that U bases are silently translated to T bases, to allow assembly of RNA sequences.

stopOnLowCoverage <integer=10>
:   Stop the assembly if read coverage is too low to be useful. Coverage is
    checked whene when input sequences are
    initially loaded into the sequence store, when corrected reads are generated,
    and when read ends are trimmed off.

stopAfter <string=undefined>
:   If set, Canu will stop processing after a specific stage in the pipeline finishes. Valid values are:

    |  |  |
    | --- | --- |
    | **stopAfter=** | **Canu will stop after ….** |
    | sequenceStore | reads are loaded into the assembler read database. |
    | meryl-configure | kmer counting jobs are configured. |
    | meryl-count | kmers are counted, but not processed into one database. |
    | meryl-merge | kmers are merged into one database. |
    | meryl-process | frequent kmers are generated. |
    | meryl-subtract | haplotype specific kmers are generated. |
    | meryl | all kmer work is complete. |
    | haplotype-configure | haplotype read separation jobs are configured. |
    | haplotype | haplotype-specific reads are generated. |
    | overlapConfigure | overlap jobs are configured. |
    | overlap | overlaps are generated, before they are loaded into the database. |
    | overlapStoreConfigure | the jobs for creating the overlap database are configured. |
    | overlapStore | overlaps are loaded into the overlap database. |
    | correction | corrected reads are generated. |
    | trimming | trimmed reads are generated. |
    | unitig | unitigs and contigs are created. |
    | consensusConfigure | consensus jobs are configured. |
    | consensus | consensus sequences are loaded into the databases. |

    *readCorrection* and *readTrimming* are deprecated synonyms for *correction* and *trimming*, respectively.

## General Options[¶](#general-options "Permalink to this headline")

shell <string=”/bin/sh”>
:   A path to a Bourne shell, to be used for executing scripts. By default, ‘/bin/sh’, which is typically
    the same as ‘bash’. C shells (csh, tcsh) are not supported.

java <string=”java”>
:   A path to a Java application launcher of at least version 1.8.

minimap <string=”minimap2”>
:   A path to the minimap2 versatile pairwise aligner.

gnuplot <string=”gnuplot”>
:   A path to the gnuplot graphing utility. Plotting is disabled if this is unset
    (gnuplot= or gnuplot=undef), or if gnuplot fails to execute, or if gnuplot
    cannot generate plots. The latter two conditions generate warnings in the
    diagnostic output of Canu.

gnuplotImageFormat <string=”png”>
:   The type of image to generate in gnuplot. By default, canu will use png,
    svg or gif, in that order.

preExec <string=undef>
:   A single command that will be run before Canu starts in a grid-enabled configuration.
    Can be used to set up the environment, e.g., with ‘module’.

## File Staging[¶](#file-staging "Permalink to this headline")

The correction stage of Canu requires random access to all the reads. Performance is greatly
improved if the gkpStore database of reads is copied locally to each node that computes corrected
read consensus sequences. This ‘staging’ is enabled by supplying a path name to fast local storage
with the [stageDirectory](#stagedirectory) option, and, optionally, requesting access to that resource from the grid
with the [gridEngineStageOption](#gridenginestageoption) option.

stageDirectory <string=undefined>
:   A path to a directory local to each compute node. The directory should use an environment
    variable specific to the grid engine to ensure that it is unique to each task.

    For example, in Sun Grid Engine, /scratch/$JOB\_ID-$SGE\_TASK\_ID will use both the numeric
    job ID and the numeric task ID. In SLURM, /scratch/$SLRUM\_JOBID accomplishes the same.

    If specified on the command line, be sure to escape the dollar sign, otherwise the shell will try
    to expand it before Canu sees the option: stageDirectory=/scratch/$JOB\_ID-$SGE\_TASK\_ID.

    If specified in a specFile, do not escape the dollar signs.

gridEngineStageOption <string=undefined>
:   This string is passed to the job submission command, and is expected to request
    local disk space on each node. It is highly grid specific. The string DISK\_SPACE
    will be replaced with the amount of disk space needed, in gigabytes.

    On SLURM, an example is –gres=lscratch:DISK\_SPACE

## Cleanup Options[¶](#cleanup-options "Permalink to this headline")

saveOverlaps <boolean=false>
:   If ‘true’, retain all overlap stores. If ‘false’, delete the correction
    and trimming overlap stores when they are no longer useful. Overlaps used
    for contig construction are never deleted.

purgeOverlaps <string=normal>
:   Controls when to remove intermediate overlap results.

    ‘never’ removes no intermediate overlap results. This is only useful if
    you have a desire to exhaust your disk space.

    ‘false’ is the same as ‘never’.

    ‘normal’ removes intermediate overlap results after they are loaded into an
    overlap store.

    ‘true’ is the same as ‘normal’.

    ‘aggressive’ removes intermediate overlap results as soon as possible. In
    the event of a corrupt or lost file, this can result in a