cwlVersion: v1.2
class: CommandLineTool
baseCommand: ToulligQC
label: toulligqc
doc: "ToulligQC is a tool for quality control of Oxford Nanopore sequencing data.\n\
  \nTool homepage: https://github.com/GenomicParisCentre/toulligQC"
inputs:
  - id: bam
    type:
      - 'null'
      - File
    doc: uBAM file (necessary if no sequencing summary file), can also be in SAM
      format
    inputBinding:
      position: 101
      prefix: --bam
  - id: barcodes
    type:
      - 'null'
      - string
    doc: Comma-separated barcode list (e.g., BC05,RB09,NB01,barcode10) or a 
      range separated with ":" (e.g., barcode01:barcode19)
    inputBinding:
      position: 101
      prefix: --barcodes
  - id: barcoding
    type:
      - 'null'
      - boolean
    doc: Option for barcode usage
    inputBinding:
      position: 101
      prefix: --barcoding
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Batch size
    inputBinding:
      position: 101
      prefix: --batch-size
  - id: fast5_source
    type:
      - 'null'
      - File
    doc: Fast5 file source (necessary if no telemetry file), can also be in a 
      tar.gz/tar.bz2 archive or a directory
    inputBinding:
      position: 101
      prefix: --fast5-source
  - id: fastq
    type:
      - 'null'
      - File
    doc: FASTQ file (necessary if no sequencing summary file), can also be in a 
      tar.gz archive
    inputBinding:
      position: 101
      prefix: --fastq
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwriting of existing files
    inputBinding:
      position: 101
      prefix: --force
  - id: pod5_source
    type:
      - 'null'
      - File
    doc: pod5 file source (necessary if no telemetry file), can also be in a 
      tar.gz/tar.bz2 archive or a directory
    inputBinding:
      position: 101
      prefix: --pod5-source
  - id: qscore_threshold
    type:
      - 'null'
      - float
    doc: Qscore threshold
    inputBinding:
      position: 101
      prefix: --qscore-threshold
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet mode
    inputBinding:
      position: 101
      prefix: --quiet
  - id: report_name
    type:
      - 'null'
      - string
    doc: Report name
    inputBinding:
      position: 101
      prefix: --report-name
  - id: samplesheet
    type:
      - 'null'
      - File
    doc: a samplesheet (.csv file) to fill out sample names in MinKNOW
    inputBinding:
      position: 101
      prefix: --samplesheet
  - id: sequencing_summary_1dsqr_source
    type:
      - 'null'
      - File
    doc: Basecaller 1dsq summary source
    inputBinding:
      position: 101
      prefix: --sequencing-summary-1dsqr-source
  - id: sequencing_summary_source
    type:
      - 'null'
      - File
    doc: Basecaller sequencing summary source, can be compressed with gzip (.gz)
      or bzip2 (.bz2)
    inputBinding:
      position: 101
      prefix: --sequencing-summary-source
  - id: telemetry_source
    type:
      - 'null'
      - File
    doc: Basecaller telemetry file source, can be compressed with gzip (.gz) or 
      bzip2 (.bz2)
    inputBinding:
      position: 101
      prefix: --telemetry-source
  - id: thread
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --thread
  - id: use_aliases_for_barcodes
    type:
      - 'null'
      - boolean
    doc: Use the "alias" column for barcodes names in the sample sheet file 
      instead of the "barcode" column
    inputBinding:
      position: 101
      prefix: --use-aliases-for-barcodes
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_directory)
  - id: html_report_path
    type:
      - 'null'
      - File
    doc: Output HTML report
    outputBinding:
      glob: $(inputs.html_report_path)
  - id: data_report_path
    type:
      - 'null'
      - File
    doc: Output data report
    outputBinding:
      glob: $(inputs.data_report_path)
  - id: images_directory
    type:
      - 'null'
      - Directory
    doc: Images directory
    outputBinding:
      glob: $(inputs.images_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/toulligqc:2.8.3--pyhdfd78af_0
