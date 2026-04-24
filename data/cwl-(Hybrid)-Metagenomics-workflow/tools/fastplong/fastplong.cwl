#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

label: Fastplong
doc: Ultrafast preprocessing and quality control for long reads (Nanopore, PacBio, Cyclone, etc.).

requirements:
 - class: InlineJavascriptRequirement

hints:
  SoftwareRequirement:
    packages:
      fastp :
        version: ["0.3.0"]
        specs: ["https://anaconda.org/bioconda/fastplong"]
  DockerRequirement:
    dockerPull: quay.io/biocontainers/fastplong:0.3.0--h224cc79_0


arguments:
  - prefix: "--out"
    valueFrom: $(inputs.output_filename_prefix)_fastplong.fastq.gz
  - prefix: "--html"
    valueFrom: $(inputs.output_filename_prefix)_fastplong-report.html
  - prefix: "--json"
    valueFrom: $(inputs.output_filename_prefix)_fastplong-report.json
  
  - ${ inputs.failed_out ? "--failed-out" : null }
  - ${ inputs.failed_out ? inputs.identifier + "_fastplong_failed.fastq.gz" : null }

baseCommand: [fastplong]

inputs:
  output_filename_prefix:
    type: string?
    doc: Name of the output file. .fastq.gz will be appended to the reads. Default "fastplong_out"
    label: Output filename (base)
  input_file:
    type: File
    inputBinding:
      prefix: "--in"
    label: Input file
    doc: "Read input file name (string [=])"
  failed_out:
    type: boolean?
    label: failed_out
    inputBinding:
      prefix: "--failed-out"
    doc: "Output failed reads to a separate file. Disabled by default."
  compression:
    type: int?
    inputBinding:
      prefix: "--compression"
    label: Compression
    doc: "Compression level for gzip output (1 ~ 9). 1 is fastest, 9 is smallest, Default 4"
  reads_to_process:
    type: int?
    inputBinding:
      prefix: "--reads_to_process"
    label: Reads_to_process
    doc: "Specify how many reads/pairs to be processed. Default 0 means process all reads. Default 0"
  verbose:
    type: boolean?
    inputBinding:
      prefix: "--verbose"
    label: Verbose
    doc: "Output verbose log information (i.e. when every 1M reads are processed)."
  disable_adapter_trimming:
    type: boolean?
    inputBinding:
      prefix: "--disable_adapter_trimming"
    label: Disable adapter trimming
    doc: "Adapter trimming is enabled by default. If this option is specified, adapter trimming is disabled. Default false"
  start_adapter:
    type: string?
    inputBinding:
      prefix: "--start_adapter"
    label: start_adapter
    doc: "The adapter sequence at read start (5'). Default auto-detect"
  end_adapter:
    type: string?
    inputBinding:
      prefix: "--end_adapter"
    label: End adapter
    doc: "The adapter sequence at read end (3'). Default auto-detect"
  adapter_fasta:
    type: File?
    inputBinding:
      prefix: "--adapter_fasta"
    label: Adapter fasta
    doc: "Specify a FASTA file to trim both read by all the sequences in this FASTA file (string [=])"
  distance_threshold:
    type: float?
    inputBinding:
      prefix: "--distance_threshold"
    label: Distance threshold
    doc: "Threshold of sequence-adapter-distance/adapter-length (0.0 ~ 1.0), greater value means more adapters detected. Default 0.25"
  trimming_extension:
    type: int?
    inputBinding:
      prefix: "--trimming_extension"
    label: Trimming extension
    doc: "When an adapter is detected, extend the trimming to make cleaner trimming, Default 10 means trimming 10 bases more"
  trim_front:
    type: int?
    inputBinding:
      prefix: "--trim_front"
    label: Trim_front
    doc: "Trimming how many bases in front for read. Default 0"
  trim_tail:
    type: int?
    inputBinding:
      prefix: "--trim_tail"
    label: trim_tail
    doc: "Trimming how many bases in tail for read, Default 0"
  trim_poly_x:
    type: boolean?
    inputBinding:
      prefix: "--trim_poly_x"
    label: Trim_poly_x
    doc: "Enable polyX trimming in 3' ends. Default false"
  poly_x_min_len:
    type: int?
    inputBinding:
      prefix: "--poly_x_min_len"
    label: Poly_x_min_len
    doc: "The minimum length to detect polyX in the read tail. Default 10"
  cut_front:
    type: boolean?
    inputBinding:
      prefix: "--cut_front"
    label: Cut front
    doc: "Move a sliding window from front (5') to tail, drop the bases in the window if its mean quality < threshold, stop otherwise. Default false"
  cut_tail:
    type: boolean?
    inputBinding:
      prefix: "--cut_tail"
    label: Cut tail
    doc: "Move a sliding window from tail (3') to front, drop the bases in the window if its mean quality < threshold, stop otherwise Default false."
  cut_window_size:
    type: int?
    inputBinding:
      prefix: "--cut_window_size"
    label: Cut window size
    doc: "The window size option shared by cut_front, cut_tail or cut_sliding. Range: 1~1000. Default 4"
  cut_mean_quality:
    type: int?
    inputBinding:
      prefix: "--cut_mean_quality"
    label: Cut mean quality
    doc: "The mean quality requirement option shared by cut_front, cut_tail or cut_sliding. Range: 1~36. Default 20"
  cut_front_window_size:
    type: int?
    inputBinding:
      prefix: "--cut_front_window_size"
    label: Cut_front_window_size
    doc: "The window size option of cut_front, default to cut_window_size if not specified (int [=4])"
  cut_front_mean_quality:
    type: int?
    inputBinding:
      prefix: "--cut_front_mean_quality"
    label: Cut_front_mean_quality
    doc: "The mean quality requirement option for cut_front, default to cut_mean_quality if not specified (int [=20])"
  cut_tail_window_size:
    type: int?
    inputBinding:
      prefix: "--cut_tail_window_size"
    label: Cut_tail_window_size
    doc: "The window size option of cut_tail, default to cut_window_size if not specified (int [=4])"
  cut_tail_mean_quality:
    type: int?
    inputBinding:
      prefix: "--cut_tail_mean_quality"
    label: Cut_tail_mean_quality
    doc: "The mean quality requirement option for cut_tail, default to cut_mean_quality if not specified (int [=20])"
  disable_quality_filtering:
    type: boolean?
    inputBinding:
      prefix: "--disable_quality_filtering"
    label: Disable_quality_filtering
    doc: "Quality filtering is enabled by default. If this option is specified, quality filtering is disabled"
  qualified_quality_phred:
    type: int?
    inputBinding:
      prefix: "--qualified_quality_phred"
    label: Qualified_quality_phred
    doc: "The quality value that a base is qualified. Default 8 means phred quality >=Q8 is qualified."
  unqualified_percent_limit:
    type: int?
    inputBinding:
      prefix: "--unqualified_percent_limit"
    label: Unqualified_percent_limit
    doc: "How many percents of bases are allowed to be unqualified (0~100). Default 40 means 40%"
  n_base_limit:
    type: int?
    inputBinding:
      prefix: "--n_base_limit"
    label: N_base_limit
    doc: "If one read's number of N base is >n_base_limit, then this read is discarded. Default 5"
  mean_qual:
    type: int?
    inputBinding:
      prefix: "--mean_qual"
    label: Mean quality
    doc: "If one read's mean_qual quality score <mean_qual, then this read is discarded. Default 0 means no requirement"
  disable_length_filtering:
    type: boolean?
    inputBinding:
      prefix: "--disable_length_filtering"
    label: Disable_length_filtering
    doc: "Length filtering is enabled by default. If this option is specified, length filtering is disabled"
  length_required:
    type: int?
    inputBinding:
      prefix: "--length_required"
    label: Length required
    doc: "Reads shorter than length required will be discarded. Default 15"
  length_limit:
    type: int?
    inputBinding:
      prefix: "--length_limit"
    label: Length limit
    doc: "Reads longer than length_limit will be discarded. Default 0 means no limitation"
  low_complexity_filter:
    type: boolean?
    inputBinding:
      prefix: "--low_complexity_filter"
    label: Low complexity filter
    doc: "Enable low complexity filter. The complexity is defined as the percentage of base that is different from its next base (base[i] != base[i+1])."
  complexity_threshold:
    type: int?
    inputBinding:
      prefix: "--complexity_threshold"
    label: Complexity threshold
    doc: "The threshold for low complexity filter (0~100). Default is 30, which means 30% complexity is required"
  report_title:
    type: string?
    inputBinding:
      prefix: "--report_title"
    doc: "Should be quoted with ' or \", default is \"fastplong report\" (string [=fastplong report])"
  threads:
    type: int?
    inputBinding:
      prefix: "--thread"
    label: Threads
    doc: "Worker thread number. Default 3"
  split:
    type: int?
    inputBinding:
      prefix: "--split"
    label: Split
    doc: "Split output by limiting total split file number with this option (2~999), a sequential number prefix will be added to output name ( 0001.out.fq, 0002.out.fq...), disabled by default"
  split_by_lines:
    type: long?
    inputBinding:
      prefix: "--split_by_lines"
    label: Split by lines
    doc: "Split output by limiting lines of each file with this option(>=1000), a sequential number prefix will be added to output name ( 0001.out.fq, 0002.out.fq...), disabled by default"
  split_prefix_digits:
    type: int?
    inputBinding:
      prefix: "--split_prefix_digits"
    label: Split prefix digits
    doc: "The digits for the sequential number padding (1~10), default is 4, so the filename will be padded as 0001.xxx, 0 to disable padding"

outputs:
  out_reads:
    type: File
    outputBinding:
      glob: '*_fastplong.fastq.gz'
  html_report:
    type: File
    outputBinding:
      glob: '*_fastplong-report.html'
  json_report:
    type: File
    outputBinding:
      glob: '*_fastplong-report.json'

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse

s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateCreated: "2025-07-22"
s:dateModified: "2025-08-04"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/