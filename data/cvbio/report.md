# cvbio CWL Generation Report

## cvbio_Disambiguate

### Tool Description
Disambiguate reads that were mapped to multiple references.

### Metadata
- **Docker Image**: quay.io/biocontainers/cvbio:3.0.0--0
- **Homepage**: https://github.com/clintval/cvbio
- **Package**: https://anaconda.org/channels/bioconda/packages/cvbio/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cvbio/overview
- **Total Downloads**: 24.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/clintval/cvbio
- **Stars**: N/A
### Original Help Text
```text
OpenJDK 64-Bit Server VM warning: Option AggressiveOpts was deprecated in version 11.0 and will likely be removed in a future release.
[31mUSAGE:[0m [1m[31mcvbio[0m [31m[cvbio arguments] [command name] [command arguments][0m
[31mVersion: 3.0.0[0m
[37m------------------------------------------------------------------------------------------------------------------------
[0m[31m
[1m[31mcvbio[0m [31mArguments:[0m
[0m[37m------------------------------------------------------------------------------------------------------------------------
[0m[32m-h [[true|false]], --help[[=true|false]][0m
                              [36mDisplay the help message. [32m[Default: false].[0m [32m[0m
[0m[32m--async-io[[=true|false]][0m     [36mUse asynchronous I/O where possible, e.g. for SAM and BAM files. [32m[Default:
                              false].[0m [32m[0m
[0m[32m--version[[=true|false]][0m      [36mDisplay the version number for this tool. [32m[Default: false].[0m [32m[0m
[0m[32m--compression=Int[0m             [36mDefault GZIP compression level, BAM compression level. [32m[Default: 5].[0m [32m[0m
[0m[32m--tmp-dir=DirPath[0m             [36mDirectory to use for temporary files. [32m[Default: /tmp].[0m [32m[0m
[0m[32m--log-level=LogLevel[0m          [36mMinimum severity log-level to emit. [32m[Default: Info].[0m [32mOptions: Debug, Info,
                              Warning, Error, Fatal.[0m
[0m[32m--sam-validation-stringency=ValidationStringency[0m
                              [36mValidation stringency for SAM/BAM reading. [32m[Optional].[0m [32mOptions: STRICT,
                              LENIENT, SILENT.[0m
[0m
[1m[31mDisambiguate[0m
[37m------------------------------------------------------------------------------------------------------------------------
[0m[36mDisambiguate reads that were mapped to multiple references.

Disambiguation of aligned reads is performed per-template and all information across primary, secondary, and
supplementary alignments is used as evidence. Alignment disambiguation is commonly used when analyzing sequencing data
from transduction, transfection, transgenic, or xenographic (including patient derived xenograft) experiments. This
tool works by comparing various alignment scores between a template that has been aligned to many references in order
to determine which reference is the most likely source.

All templates which are positively assigned to a single source reference are written to a reference-specific output BAM
file. Any templates with ambiguous reference assignment are written to an ambiguous input-specific output BAM file.
Only BAMs produced from the Burrows-Wheeler Aligner (bwa) or STAR are currently supported.

Input BAMs of arbitrary sort order are accepted, however, an internal sort to queryname will be performed unless the
BAM is already in queryname sort order. All output BAM files will be written in the same sort order as the input BAM
files. Although paired-end reads will give the most discriminatory power for disambiguation of short- read sequencing
data, this tool accepts paired, single-end (fragment), and mixed pairing input data.

Example
-------

To disambiguate templates that are aligned to human (A) and mouse (B):

  ? java -jar cvbio.jar Disambiguate -i sample.A.bam sample.B.bam -p sample/sample -n hg38 mm10
  
  ? tree sample/
    sample/
    ??? ambiguous-alignments/
    ?  ??? sample.A.ambiguous.bai
    ?  ??? sample.A.ambiguous.bam
    ?  ??? sample.B.ambiguous.bai
    ?  ??? sample.B.ambiguous.bam
    ??? sample.hg38.bai
    ??? sample.hg38.bam
    ??? sample.mm10.bai
    ??? sample.mm10.bam

Glossary
--------

  * MAPQ: A metric that tells you how confident you can be that a read comes from a reported mapping position.
  * AS: A metric that tells you how similar the read is to the reference sequence.
  * NM: A metric that measures the number of mismatches to the reference sequence (Hamming distance).

Prior Art
---------

  * Disambiguate (https://github.com/AstraZeneca-NGS/disambiguate) from AstraZeneca's NGS team
[0m[31m
[1m[31mDisambiguate[0m [31mArguments:[0m
[0m[37m------------------------------------------------------------------------------------------------------------------------
[0m[33m-i PathToBam+, --input=PathToBam+[0m
                              [36mThe BAMs to disambiguate. [32m[0m
[0m[33m-p PathPrefix, --prefix=PathPrefix[0m
                              [36mThe output file prefix (e.g. dir/sample_name). [32m[0m
[0m[32m-h [[true|false]], --help[[=true|false]][0m
                              [36mDisplay the help message. [32m[Default: false].[0m [32m[0m
[0m[32m--version[[=true|false]][0m      [36mDisplay the version number for this tool. [32m[Default: false].[0m [32m[0m
[0m[32m-s DisambiguationStrategy, --strategy=DisambiguationStrategy[0m
                              [36mThe disambiguation strategy to use. [32m[Default: Classic].[0m [32mOptions:
                              Classic.[0m
[0m[32m-n String*, --reference-names=String*[0m
                              [36mThe reference names. Default to the first Assembly Name in the BAM header.
                              [32m[Optional].[0m [32m[0m
[0m
[1m[31mException: MissingArgumentException
Error: Argument 'input' must be specified at least once.[0m
```


## cvbio_FetchEnsemblGtf

### Tool Description
Fetch a GTF file from the Ensembl web server.

### Metadata
- **Docker Image**: quay.io/biocontainers/cvbio:3.0.0--0
- **Homepage**: https://github.com/clintval/cvbio
- **Package**: https://anaconda.org/channels/bioconda/packages/cvbio/overview
- **Validation**: PASS

### Original Help Text
```text
OpenJDK 64-Bit Server VM warning: Option AggressiveOpts was deprecated in version 11.0 and will likely be removed in a future release.
[31mUSAGE:[0m [1m[31mcvbio[0m [31m[cvbio arguments] [command name] [command arguments][0m
[31mVersion: 3.0.0[0m
[37m------------------------------------------------------------------------------------------------------------------------
[0m[31m
[1m[31mcvbio[0m [31mArguments:[0m
[0m[37m------------------------------------------------------------------------------------------------------------------------
[0m[32m-h [[true|false]], --help[[=true|false]][0m
                              [36mDisplay the help message. [32m[Default: false].[0m [32m[0m
[0m[32m--async-io[[=true|false]][0m     [36mUse asynchronous I/O where possible, e.g. for SAM and BAM files. [32m[Default:
                              false].[0m [32m[0m
[0m[32m--version[[=true|false]][0m      [36mDisplay the version number for this tool. [32m[Default: false].[0m [32m[0m
[0m[32m--compression=Int[0m             [36mDefault GZIP compression level, BAM compression level. [32m[Default: 5].[0m [32m[0m
[0m[32m--tmp-dir=DirPath[0m             [36mDirectory to use for temporary files. [32m[Default: /tmp].[0m [32m[0m
[0m[32m--log-level=LogLevel[0m          [36mMinimum severity log-level to emit. [32m[Default: Info].[0m [32mOptions: Debug, Info,
                              Warning, Error, Fatal.[0m
[0m[32m--sam-validation-stringency=ValidationStringency[0m
                              [36mValidation stringency for SAM/BAM reading. [32m[Optional].[0m [32mOptions: STRICT,
                              LENIENT, SILENT.[0m
[0m
[1m[31mFetchEnsemblGtf[0m
[37m------------------------------------------------------------------------------------------------------------------------
[0m[36mFetch a GTF file from the Ensembl web server.
[0m[31m
[1m[31mFetchEnsemblGtf[0m [31mArguments:[0m
[0m[37m------------------------------------------------------------------------------------------------------------------------
[0m[33m-o Path, --output=Path[0m        [36mThe output file path. [32m[0m
[0m[32m-h [[true|false]], --help[[=true|false]][0m
                              [36mDisplay the help message. [32m[Default: false].[0m [32m[0m
[0m[32m--version[[=true|false]][0m      [36mDisplay the version number for this tool. [32m[Default: false].[0m [32m[0m
[0m[32m-r Int, --release=Int[0m         [36mThe Ensembl release. [32m[Default: 96].[0m [32m[0m
[0m[32m-b Int, --build=Int[0m           [36mThe genome build. [32m[Default: 38].[0m [32m[0m
[0m[32m-s String, --species=String[0m   [36mThe species. [32m[Default: Homo sapiens].[0m [32m[0m
[0m
[1m[31mException: UserException
Error: Argument 'output' is required.[0m
```


## cvbio_IgvBoss

### Tool Description
Take control of your IGV session from end-to-end.

If no inputs are provided, then no new sessions will be created. Adding multiple IGV-valid locus identifiers will
result in a split-window view. You must have already configured your IGV application to allow HTTPS connections over a
port. Enable remote control through the Advanced Tab of the Preferences Window in IGV.

IGV Startup
-----------

IGV will be initialized using the ordered logic:

  1. Let this tool connect to an already-running IGV session
  2. Supply an IGV JAR file path and let this tool run the JAR
  3. If you're on MacOS and have the Mac Application installed, IgvBoss will run it
  4. Finally, IgvBoss will attempt to find the 'igv' executable on the system path and run it

IgvBoss will always attempt to connect to a running IGV application before attempting to start a new instance of IGV.
Provide a path to an IGV JAR file if no IGV applications are currently running. If no IGV JAR file path is set, and
there are no running instances of IGV, then IgvBoss will attempt to fnd a locally installed version of IGV and run it.
If you are executing IgvBoss on a MacOS system, then IgvBoss will first look for an installed IGV Mac application. If
one cannot be found, or you're on a different operating system, then IgvBoss will search for an 'igv' executable on the
system path to execute.

IGV Shutdown
------------

You can shutdown IGV when IgvBoss exits with the '--close-on-exit' option. This will work regardless of how IgvBoss
initially connected to IGV. This feature is handy for tearing down the application after your investigation is
concluded.

References and Prior Art
------------------------

  * https://github.com/igvteam/igv/blob/master/src/main/resources/org/broad/igv/prefs/preferences.tab
  * https://software.broadinstitute.org/software/igv/PortCommands
  * https://github.com/stevekm/IGV-snapshot-automator

### Metadata
- **Docker Image**: quay.io/biocontainers/cvbio:3.0.0--0
- **Homepage**: https://github.com/clintval/cvbio
- **Package**: https://anaconda.org/channels/bioconda/packages/cvbio/overview
- **Validation**: PASS

### Original Help Text
```text
OpenJDK 64-Bit Server VM warning: Option AggressiveOpts was deprecated in version 11.0 and will likely be removed in a future release.
[31mUSAGE:[0m [1m[31mcvbio[0m [31m[cvbio arguments] [command name] [command arguments][0m
[31mVersion: 3.0.0[0m
[37m------------------------------------------------------------------------------------------------------------------------
[0m[31m
[1m[31mcvbio[0m [31mArguments:[0m
[0m[37m------------------------------------------------------------------------------------------------------------------------
[0m[32m-h [[true|false]], --help[[=true|false]][0m
                              [36mDisplay the help message. [32m[Default: false].[0m [32m[0m
[0m[32m--async-io[[=true|false]][0m     [36mUse asynchronous I/O where possible, e.g. for SAM and BAM files. [32m[Default:
                              false].[0m [32m[0m
[0m[32m--version[[=true|false]][0m      [36mDisplay the version number for this tool. [32m[Default: false].[0m [32m[0m
[0m[32m--compression=Int[0m             [36mDefault GZIP compression level, BAM compression level. [32m[Default: 5].[0m [32m[0m
[0m[32m--tmp-dir=DirPath[0m             [36mDirectory to use for temporary files. [32m[Default: /tmp].[0m [32m[0m
[0m[32m--log-level=LogLevel[0m          [36mMinimum severity log-level to emit. [32m[Default: Info].[0m [32mOptions: Debug, Info,
                              Warning, Error, Fatal.[0m
[0m[32m--sam-validation-stringency=ValidationStringency[0m
                              [36mValidation stringency for SAM/BAM reading. [32m[Optional].[0m [32mOptions: STRICT,
                              LENIENT, SILENT.[0m
[0m
[1m[31mIgvBoss[0m
[37m------------------------------------------------------------------------------------------------------------------------
[0m[36mTake control of your IGV session from end-to-end.

If no inputs are provided, then no new sessions will be created. Adding multiple IGV-valid locus identifiers will
result in a split-window view. You must have already configured your IGV application to allow HTTPS connections over a
port. Enable remote control through the Advanced Tab of the Preferences Window in IGV.

IGV Startup
-----------

IGV will be initialized using the ordered logic:

  1. Let this tool connect to an already-running IGV session
  2. Supply an IGV JAR file path and let this tool run the JAR
  3. If you're on MacOS and have the Mac Application installed, IgvBoss will run it
  4. Finally, IgvBoss will attempt to find the 'igv' executable on the system path and run it

IgvBoss will always attempt to connect to a running IGV application before attempting to start a new instance of IGV.
Provide a path to an IGV JAR file if no IGV applications are currently running. If no IGV JAR file path is set, and
there are no running instances of IGV, then IgvBoss will attempt to fnd a locally installed version of IGV and run it.
If you are executing IgvBoss on a MacOS system, then IgvBoss will first look for an installed IGV Mac application. If
one cannot be found, or you're on a different operating system, then IgvBoss will search for an 'igv' executable on the
system path to execute.

IGV Shutdown
------------

You can shutdown IGV when IgvBoss exits with the '--close-on-exit' option. This will work regardless of how IgvBoss
initially connected to IGV. This feature is handy for tearing down the application after your investigation is
concluded.

References and Prior Art
------------------------

  * https://github.com/igvteam/igv/blob/master/src/main/resources/org/broad/igv/prefs/preferences.tab
  * https://software.broadinstitute.org/software/igv/PortCommands
  * https://github.com/stevekm/IGV-snapshot-automator
[0m[31m
[1m[31mIgvBoss[0m [31mArguments:[0m
[0m[37m------------------------------------------------------------------------------------------------------------------------
[0m[32m-h [[true|false]], --help[[=true|false]][0m
                              [36mDisplay the help message. [32m[Default: false].[0m [32m[0m
[0m[32m-i FilePath*, --input=FilePath*[0m
                              [36mInput files to display. [32m[Optional].[0m [32m[0m
[0m[32m--version[[=true|false]][0m      [36mDisplay the version number for this tool. [32m[Default: false].[0m [32m[0m
[0m[32m-g String, --genome=String[0m    [36mThe genome to use (path, string, id). [32m[Optional].[0m [32m[0m
[0m[32m-l String*, --loci=String*[0m    [36mThe loci to visit. (e.g. "all", "chr1:23-99", "TP53"). [32m[Optional].[0m [32m[0m
[0m[32m-j FilePath, --jar=FilePath[0m   [36mThe IGV Jar file, if we are to initialize IGV. [32m[Optional].[0m [32m[0m
[0m[32m-m Int, --memory=Int[0m          [36mThe heap size (Gb) given to the JVM, if we initialize. [32m[Default: 5].[0m [32m[0m
[0m[32m-H String, --host=String[0m      [36mThe host the IGV server is running on. [32m[Default: 127.0.0.1].[0m [32m[0m
[0m[32m-p Int, --port=Int[0m            [36mThe port to the IGV server. [32m[Default: 60151].[0m [32m[0m
[0m[32m--downsample[[=true|false]][0m   [36mDownsample reads or not. [32m[Optional].[0m [32m[0m
[0m[32m--base-quality-minimum=Int[0m    [36mMinimum base quality to shade. [32m[Optional].[0m [32m[0m
[0m[32m--base-quality-maximum=Int[0m    [36mMaximum base quality to shade. [32m[Optional].[0m [32m[0m
[0m[32m-x [[true|false]], --close-on-exit[[=true|false]][0m
                              [36mClose the IGV application after execution. [32m[Default: false].[0m [32m[0m
[0m
[1m[31melp does not match one of T|True|F|False|Yes|Y|No|N[0m
```


## cvbio_UpdateContigNames

### Tool Description
Update contig names in delimited data using a name mapping table.

### Metadata
- **Docker Image**: quay.io/biocontainers/cvbio:3.0.0--0
- **Homepage**: https://github.com/clintval/cvbio
- **Package**: https://anaconda.org/channels/bioconda/packages/cvbio/overview
- **Validation**: PASS

### Original Help Text
```text
OpenJDK 64-Bit Server VM warning: Option AggressiveOpts was deprecated in version 11.0 and will likely be removed in a future release.
[31mUSAGE:[0m [1m[31mcvbio[0m [31m[cvbio arguments] [command name] [command arguments][0m
[31mVersion: 3.0.0[0m
[37m------------------------------------------------------------------------------------------------------------------------
[0m[31m
[1m[31mcvbio[0m [31mArguments:[0m
[0m[37m------------------------------------------------------------------------------------------------------------------------
[0m[32m-h [[true|false]], --help[[=true|false]][0m
                              [36mDisplay the help message. [32m[Default: false].[0m [32m[0m
[0m[32m--async-io[[=true|false]][0m     [36mUse asynchronous I/O where possible, e.g. for SAM and BAM files. [32m[Default:
                              false].[0m [32m[0m
[0m[32m--version[[=true|false]][0m      [36mDisplay the version number for this tool. [32m[Default: false].[0m [32m[0m
[0m[32m--compression=Int[0m             [36mDefault GZIP compression level, BAM compression level. [32m[Default: 5].[0m [32m[0m
[0m[32m--tmp-dir=DirPath[0m             [36mDirectory to use for temporary files. [32m[Default: /tmp].[0m [32m[0m
[0m[32m--log-level=LogLevel[0m          [36mMinimum severity log-level to emit. [32m[Default: Info].[0m [32mOptions: Debug, Info,
                              Warning, Error, Fatal.[0m
[0m[32m--sam-validation-stringency=ValidationStringency[0m
                              [36mValidation stringency for SAM/BAM reading. [32m[Optional].[0m [32mOptions: STRICT,
                              LENIENT, SILENT.[0m
[0m
[1m[31mUpdateContigNames[0m
[37m------------------------------------------------------------------------------------------------------------------------
[0m[36mUpdate contig names in delimited data using a name mapping table.

A collection of mapping tables is maintained at the following location:

  * https://github.com/dpryan79/ChromosomeMappings
[0m[31m
[1m[31mUpdateContigNames[0m [31mArguments:[0m
[0m[37m------------------------------------------------------------------------------------------------------------------------
[0m[33m-i FilePath, --in=FilePath[0m    [36mThe input file. [32m[0m
[0m[33m-o FilePath, --out=FilePath[0m   [36mThe output file. [32m[0m
[0m[33m-m FilePath, --mapping=FilePath[0m
                              [36mA two-column tab-delimited mapping file. [32m[0m
[0m[32m-h [[true|false]], --help[[=true|false]][0m
                              [36mDisplay the help message. [32m[Default: false].[0m [32m[0m
[0m[32m--version[[=true|false]][0m      [36mDisplay the version number for this tool. [32m[Default: false].[0m [32m[0m
[0m[32m-c Int+, --columns=Int+[0m       [36mThe column names to convert, 0-indexed. [32m[Default: 0].[0m [32m[0m
[0m[32m-d Char, --delimiter=Char[0m     [36mThe input file data delimiter. [32m[Default: ].[0m [32m[0m
[0m[32m-C String+, --comment-chars=String+[0m
                              [36mDirectly write-out lines that start with these prefixes. [32m[Default: #].[0m [32m[0m
[0m[32m-s [[true|false]], --skip-missing[[=true|false]][0m
                              [36mSkip (ignore) records which do not have a mapping. [32m[Default: true].[0m [32m[0m
[0m
[1m[31mException: UserException
Error: Argument 'in' is required.[0m
```


## Metadata
- **Skill**: generated
