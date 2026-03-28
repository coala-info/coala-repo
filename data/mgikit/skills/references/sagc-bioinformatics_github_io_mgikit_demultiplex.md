[Skip to content](#main)
[Skip to footer](#footer)

[![MGIKIT logo](/mgikit/assets/SAGC-logo-hover.png)MGIKIT](/mgikit/)

* [Home](/mgikit/)
* [GitHub](https://github.com/sagc-bioinformatics/mgikit)

Main menu

[Main](/mgikit/)

* [Fastq Demultiplex](/mgikit/demultiplex)
* [Template detection](/mgikit/template)
* [Reports](/mgikit/report)
* [Reformat reads](/mgikit/reformat)
* [Contact us](/mgikit/contact_us)

# Guides: Instructions for MGIKIT demultiplexing

On this page

## Demultiplexing functionality

This command is used to demultiplex fastq files and assign the sequencing reads to their
associated samples. The tool requires the following mandatory input files to perform the
demultiplexing:

1. Fastq files (single/paired-end).
2. Sample sheet which contains sample indexes and their templates (will be explained in detail).

Simply, the tool reads the barcodes at the end of R2 (reveres) reads for paired-end reads input or the end of
R1 (forward) reads for single read input. Based on the barcode, it assigns the read to the relevant
sample allowing for mismatches less than a specific threshold. The tool outputs fastq files for each sample
as well as some summary reports that can be visualised through the MultiQC tool and mgikit plugin.

### Mandatory input files

* **`-h` or `--help`**: Print help
* **`-V` or `--version`**: Print version

**Fastq input file**

* **`-f or --read1`**: the path to the forward reads fastq file for both paired-end and single-end input data.
* **`-r or --read2`**: the path to the reverse reads fastq file.
* **`-i or --input`**: the path to the directory that contains the input fastq files.

**Note:** Either `-i` or `-f/-r`, `-f` should be provided for a run.

**Input sample sheet**

* **`-s or --sample-sheet`**: the path to the sample sheet file. It can be tab or comma separated. The tool detects the presense of any of them in the header.
  More details are available below on the sample sheet format and preparation.

### Other Parameters

* **`-o or --output`**: The path the output directory.
  The tool will create the directory if it does not exist
  or overwrite the content if the directory exists and the parameter `--force` is used. The tool will exit
  with an error if the directory exists, and `--force` is not used. If this parameter is not provided, the tools
  will create a directory (in the working directory) with a name based on the date and time
  of the run as follows `mgiKit_Y-m-dTHMS`. where `Y`, `m`, `d`, `H`, `M`, and `S` are the date and time format.
* **`--reports`**: The path of the output reports directory.

  By default, the tool writes the files of the run reports in the same output directory as the
  demultiplexed fastq files (`-o` or `--output` parameter). This parameter is used to write the reports in
  a different folder as specified with this parameter.
* **`-m or --mismatches`**: The default value is 1. The number of mismatches allowed when
  matching reads’ barcode with sample indexes.

  This number should be less than the minimal Hamming
  distance between any barcodes of two samples. In the case of dual index demultiplexing (i7 and i5), a
  read will be assigned to a sample if the sum of the mismatches between the read barcode and both
  indexes is less than or equal to the value of this parameter. In the case of a single index, the
  mismatches with the single index should be less or equal to this parameter.
* **`--disable-illumina`**: Output reads’ header in MGI format.
  This option is to disable the default behaviour of the tool that outputs read files using Illumine format (for read headers and file naming). More details are below.
* **`--keep-barcode`**: keep the barcode at the end of the demultiplexed read.
  By default, the tool trims the barcode sequence at the end of the read sequence. This can be disabled using this flag and the demultiplexed reads will contain the barcode at the tail of the read2 for paired-read sequencing or the tail of read1 for single-read sequencing.
* **`--template`**: The general template of the index locations in the read barcode. details are in the sample sheet preparation. if all samples in the sample sheet use the same template, the general template can be passed as a parameter instead of having it in the sample sheet for each sample. The general template will be used for all samples with the combination of `--i7-rc` and `--i5-rc`.
* **`--i7-rc`**: Use the reverse complementary form of i7 when matching with the barcode.
  This option should be used together with the general template and will be applied to all samples.
* **`--i5-rc`**: Use the reverse complementary form of i5 when matching with the barcode.
  This option should be used together with the general template and will be applied to all samples.
* **`--lane`**: Lane number such as `L01`.
  This parameter is used to provide the lane number when the parameter `-i` or `--input` is not
  provided. The lane number is used for QC reports and it is mandatory when Illumina format is
  requested for file naming.
* **`--instrument`**: The id of the sequncing machine.
  This parameter is used to provide the instrument id when the parameter `-i` or `--input`
  is not provided. The parameter is mandatory when Illumina format is requested for read header and
  file naming.
* **`--run`**: The run id. It is taken from Bioinf.csv as the date and time of starting the run.
  This parameter is used to provide the run id when the parameter `-i` or `--input` is not provided. The parameter is mandatory when Illumina format is requested for read header and file naming.
* **`--writing-buffer-size`**: The default value is `67108864`. The size of the buffer for each sample to be filled with data and then written once to the disk. Smaller buffers will need less memory but make the tool slower. Larger buffers need more memory.
* **`--comprehensive-scan`**: Enable comperhansive scan.

  This parameter is only needed when having a mixed library dataset (different locations for the indexes in the read barcode for some samples).
  The default behaviour of the tool is to stop comparing the barcodes with
  samples’ indexes when it finds a match. This flag will force the tool to keep comparing with all other
  samples to make sure that the read matches with only one sample. In a normal scenario, the read
  should match with only one sample, however, there is a chance that the read matches with multiple
  samples if the allowed number of mismatches is greater than the minimum hamming distance
  between the indexes, or the samples have different templates.
* **`--undetermined-label`**: The default value is `Undetermined`. The label of the file that contains the
  undermined reads which could not be assigned to any samples.
* **`--ambiguous-label`**: The default value is `Ambiguous`. The label of the file that contains the ambiguous reads.
  The ambiguous reads are the reads that can be assigned to multiple samples. This can happen when
  the number of allowed mismatches is high.
* **`--report-limit`**: The number of barcodes to be reported in the list of undetermined and ambiguous barcodes for short/multiqc report. [default: 20]
* **`--r1-file-suf`**: The suffix to read1 file name. When using the –input parameter, the tool looks for the file that ends with this suffix and use it as read1 file. There should be one file with this suffix in the input directory. [default: \_read\_1.fq.gz]
* **`--r2-file-suf`**: The suffix to read2 file name. When using the –input parameter, the tool looks for the file that ends with this suffix and use it as read2 file. There should be one file with this suffix in the input directory. [default: \_read\_2.fq.gz]
* **`--info-file`**: The name of the info file that contains the run information. Only needed when using the `--input` parameter. [default: BioInfo.csv]
* **`--report-level`**: The level of reporting. 0 no reports will be generated!, 1 data quality and demultiplexing reports. 2: all reports (reports on data quality, demultiplexing, undetermined and ambiguous barcodes).[default: 2]
* **`--compression-level`**: The level of compression (between 0 and 12). 0 is fast but no compression, 12 is slow but high compression. [default: 1]
* **`--force`**: this flag is to force the run and overwrite the existing output directory if exists.
* **`--ignore-undetermined`**: By default, the tool will stop if many reads were undetermined. using this parameter, will make the tool give a warning one this issue but keep demultiplexing.
* **`--per-index-error`**: By default, the allowed mismatches `-m or --mismatches` are considered for both indexes. This flag will allow the mismatches per each index.
* **`--memory`**: The requested maximum memory to be used (in giga byte). Check the documentation for memory optimisation options. Default is 0 then the tool will use the available memory on the machine.
* **`--not-mgi`**: This flag needs to be enabled if the input fastq files don’t have MGI format.
* **`--threads` or `-t`**: The number of threads to be utilised. By default, it uses all available cpus.
* **`--reader-threads`**: The requested threads to be used for input reading. Default is 0, which means auto configuration according to the value of the `--threads` parameter.
* **`--writer-threads`**: The requested threads to be used for processing and writing outputs. Default is 0, which means auto configuration according to the value of the `--threads` parameter.
* **`--mgi-full-header`**: when enabled, the tool will write sample barcodes and UMI to the read header when using MGI format, by default it will not.
* **`--validate`**: when enabled, the tool will validate the content of the input fastq files.

### Understanding input files

MGI sequencing machine output a directory for the run (flowcell\_id) with a subdirectory for each lane (L01, L02 ..) depending on the machine.
The input fastq files can be provided to the tool in two ways:

1. Using `-f` and `-r` parameters which will be referring to the path to `R1` and `R2` respectively for paired-end or `-f` for single end fastq.
2. Using `-i` or `--input` parameter which refers to the path to the lane subdirectory in the sequencing output directory (or the directory that contains the fastq files if the data is obtained from somewhere else). In this case, the tool will search for the file that ends with `_read_1.fq.gz` and `_read_2.fq.gz` as forward and reverse reads respectively and if no reverse read file is found, the tool considers the run as a single end run. These suffixes can be also customised using the parameters (`--r1-file-suf` and `--r2-file-suf`).

### Sample sheet format and preparation

For the tool to perform demultiplexing, it needs to know the indexes of each sample to match them with the barcodes at the end of the read sequence as well as where to look for each index in the barcode. We refer to the location of the indexes within the barcode by the barcode template. For example
This information can be provided to the tool in two different ways:

1. Sample sheet with all information about the indexes and their template.
   This is the general way of passing this information to the tool and it works for all scenarios.
2. Sample sheet with information about sample indexes and a general template passed via a separate parameter.
   This approach can be used if all samples have the same index template, which is the common scenario.

The sample sheet is a tab-delimited or comma-delimited file that contains sample information. The tool will check if tab exists in the header, if not found, will check for comma and uses the first delimiter found.

This file may contain all or some of these columns:

* **`sample_id`** (**Mandatory**): a unique identifier that will be used to refer to the specific sample.
* **`i7`** (**Mandatory**): The nucleotide sequence for the i7 index for the associated sample. This will be used to demultiplex the reads by comparing it to the index found in the read barcode.
* **`i5`** (**Optional**): The nucleotide sequence for the i5 index for the associated sample. this will be used to demultiplex the reads by comparing it to the index found in the read barcode when using dual indexes.
* **`template`** (**Optional**): This column should contain the template of the barcode for the specific sample. This allows doing demultiplexing for samples from different libraries where the templates are different. If all samples have the same template, this column can be ignored, and a general template should be passed in a separate parameter. See `--template` parameter. More details are below.
* **`i7_rc`** (**Optional**): Takes values from 0 or 1. If the value is 0, the i7 in the sample sheet will be used as is to compare with the read barcode. If the value is 1, the tool will compare the index found in the read barcode to the reverse complementary of i7 in the sample sheet. If the template was not provided in the sample sheet (general template is used), this parameter will be ignored, and the user has to provide this parameter (`--i7-rc`) separately.
* **`i5_rc`** (**Optional**): The same as i7\_rc but applies to the i5 index.
* **`job_number`** (**Optional**): It is an id to group the samples that are from the same project for the cases when a run contains samples from multiple projects. The demultiplexer will generate demultiplexing and quality reports for each project and the whole run. It can be ignored if the run has samples for the same project or if the project-based reports are not needed.

**Barcode template**

To understand how to use the demultiplexing tool, it is important to understand the structure of the input data and how to provide the correct parameters for the analysis.

The sequenced reads obtained by the MGI sequencing machine contain a string of nucleotides at the tail of read2 for paired-end sequencing or the tail of read1 for single-end sequencing. This substring is referred to as the read barcode which contains the indexes of the samples, single (i7) or dual (i7 and i5) indexes. It also includes the Unique Molecular Identifier (UMI) in some cases.

The demultiplexer tool looks at this read barcode and tries to match the indexes to a subsequence within the barcode to assign the read to a specific individual. In order to accomplish that, the tool needs to know where to look at the barcode to match with the index and from where to extract the UMI. This information is provided to the tool through the template parameter.
The template parameter is a combination of four possible components of (i7*, i5*, um*, –*) separated by a colon `:`. Where:

* `i7`: the region where to expect the index i7 within the barcode.
* `i5`: the region where to expect the index i5 within the barcode
* `um`: the region where to expect the UMI within the barcode
* `--`: a discarded region that is not used.
* `*` : should be replaced by a number representing the length of the relevant index or UMI.

*Examples of temp