#!/usr/bin/env cwltool

cwlVersion: v1.2
class: CommandLineTool

label: LongReadSum, a tool for long-read sequencing data Quality Control

doc: |
  LongReadSum supports FASTA, FASTQ, BAM, FAST5, and sequencing_summary.txt file formats for quick generation of QC data in HTML and text format.
  Documentation on how to install and run LongReadSum can be found here:
  https://github.com/WGLab/LongReadSum

requirements:
  InlineJavascriptRequirement: {}
 
hints:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/longreadsum:1.3.1--py310h65e1ce4_3
  SoftwareRequirement:
    packages:
      longreadsum:
        version: ["1.3.1"]
        specs: ["identifiers.org/RRID:SCR_026408"]
  
baseCommand: longreadsum

arguments:
  - prefix: -P
    valueFrom: |
      ${
        if (inputs.pattern_folder != null && inputs.pattern_input != null) {
          return [inputs.pattern_folder.path + '/' + inputs.pattern_input];
        } else {
          return null
        }
      }

inputs:
  input_type:
    type: 
      - type: enum
        symbols: [ fa, fq, f5, f5s, seqtxt, bam, rrms ]
    label: input file type
    doc: |
      Acceptable input types:
        fa      FASTA file input
        fq      FASTQ file input
        f5      FAST5 file input
        f5s     FAST5 file input with signal statistics output
        seqtxt  sequencing_summary.txt input
        bam     BAM file input
        rrms    RRMS BAM file input
      Could be streamable depending on input type.
    inputBinding:
      position: -1
  single_read_input: # optimally figure out a way to forcefully take one of the three inputs  
    type: File?
    label: single input file
    doc: The path to a single input file.
    inputBinding:
      prefix: --input
  multiple_reads_input:
    type: File[]?
    label: multiple input files
    doc: The paths to multiple input files, given in an array.
    inputBinding:
      prefix: --inputs
      itemSeparator: ","
      separate: False
  pattern_folder:
    type: Directory?
    label: pattern directory
    doc: The parent directory containing input, will be appended to the pattern input.
  pattern_input:
    type: string?
    label: pattern input
    doc: Use pattern matching (*) to specify multiple input files. Pattern does not have to be enclosed in extra double quotes.
    inputBinding:
      prefix: -P # --pattern is not working
  log_file:
    type: string?
    label: log file
    doc: Log file path, defaults to ./log_output.log
    inputBinding:
      prefix: --log
  log_level:
    type: int?
    label: level of logging
    doc: "Logging level (1: DEBUG, 2: INFO, 3: WARNING, 4: ERROR, 5: CRITICAL), defaults to 2"
    inputBinding:
      prefix: -G  # prefix in documentation "--log-level" seems broken
  outputfolder:
    type: string
    label: output folder
    doc: Sets the output directory, defaults to "longreadsum_output".
    inputBinding:
      prefix: --outputfolder
  threads:
    type: int?
    label: Number of CPU threads
    doc: |
      Specifies the number of CPU threads to use for parallel processing.
      Higher values can speed up execution but require more computational resources.
    inputBinding:
      prefix: --threads
  outprefix:
    type: string?
    label: output prefix
    doc: Output html file prefix, default is "QC_".
    inputBinding:
      prefix: --outprefix
  seed:
    type: int?
    label: random seed
    doc: |
      Sets the random seed for reproducability. 
      Using the same seed number for random seed.
      Default is set to 1.
    inputBinding:
      prefix: --seed
  # BAM specific parameters - all of these flags are yet to be tested and the prefixes very well might be broken, as two other flags are
  mod:
    type: boolean?
    label: base modification analysis
    doc: Run base modification analysis on the BAM file, default is false.
    inputBinding:
      prefix: --mod
  modprob:
    type: float?
    label: base modification threshold
    doc: Base modification filtering threshold. Above/below this value, the base is considered modified/unmodified. Default is 0.8.
    inputBinding:
      prefix: --modprob
  reference:
    type: File?
    format: edam:format_1929
    streamable: true
    label: reference genome
    doc: The reference genome FASTA file to use for identifying CpG sites (optional).
    inputBinding:
      prefix: --ref
  csv:
    type: File?
    format: edam:format_3752
    streamable: true
    label: CSV file containing read IDs to extract from the BAM file
    doc: |
      The CSV file should contain a read_id column with the read IDs in the BAM file, 
      and a decision column with the accepted/rejected status of the read.
      Accepted reads will have stop_receiving in the decision column, 
      while rejected reads will have unblock
    inputBinding:
      prefix: --csv
  genebed:
    type: File?
    format: edam:format_3586
    label: gene BED12 file
    doc: Gene BED12 file required for calculating TIN scores.
    inputBinding:
      prefix: --genebed
  sample_size:
    type: int?
    label: TIN sample size
    doc: Sample size for TIN calculation, default is 100.
    inputBinding:
      prefix: --sample-size
  min_coverage:
    type: int?
    label: TIN minimum coverage
    doc: Minimum coverage for TIN calculation, default is 10.
    inputBinding:
      prefix: --min-coverage
  # POD 5 specific parameters
  basecalls:
    type: File?
    label: BAM file
    doc: The basecalled BAM file to use for signal extraction.
    inputBinding:
      prefix: --basecalls    
  read_ids:
    type: File[]?
    label: read IDs
    doc: A comma-separated list of read IDs to extract from the file.
    inputBinding:
      prefix: --read_ids
  read_count:
    type: int?
    label: number of reads
    doc: Set the number of reads to randomly sample from the file, default is 3.
    inputBinding:
      prefix: --read-count

outputs:
  longreadsum_outdir:
    type: Directory
    label: output directory
    doc: LongReadSum output directory.
    outputBinding:
      glob: "$(inputs.outputfolder)"
  summary_file:
    type: File?
    format: edam:format_2330
    streamable: true
    label: summary file
    doc: |
      A summary text file outlining the total number of reads and bases, the longest read length, the N50, mean and median read lengths, GC percentage,
      the N05 to N95 read lengths as well as information on the GC content.
    outputBinding:
      glob: "$(inputs.outputfolder)/*_summary.txt"
  details_file: 
    type: File?
    format: edam:format_2330
    streamable: true
    label: detailed information of files
    doc: A text file with information on the read length, GC percentage, and average baseq quality of each sample.
    outputBinding:
      glob: "$(inputs.outputfolder)/*_details.txt"
  report_file:
    type: File
    format: edam:format_2332
    streamable: true
    label: report file
    doc: |
      An html report file outlining the total number of reads and bases, the longest read length, the N50, mean and median read lengths, GC percentage,
      as well ass read length statistics, read length, base quality and read base quality histograms, and a base count bar chart.
    outputBinding:
      glob: "$(inputs.outputfolder)/$(inputs.outprefix)*.html"
  log_file_out:
    type: File
    label: log file
    doc: A log file storing runtime logs and execution details for debugging and record-keeping.
    outputBinding:
      glob: "$(inputs.log_file ? inputs.log_file : 'log_output.log')"

$namespaces:
  s: https://schema.org/   
  edam: http://edamontology.org/ 
s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse
  - class: s:Person
    s:identifier: https://orcid.org/0009-0005-0017-0928
    s:email: mailto:martijn.melissen@wur.nl
    s:name: Martijn Melissen
s:citation: https://m-unlock.nl
s:codeRepository: https://git.wur.nl/ssb/automated-data-analysis
s:dateCreated: "2025-02-11"
s:dateModified: "2025-03-06"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"