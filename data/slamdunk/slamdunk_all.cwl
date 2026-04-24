cwlVersion: v1.2
class: CommandLineTool
baseCommand: slamdunk all
label: slamdunk_all
doc: "Run SLAM-seq analysis\n\nTool homepage: http://t-neumann.github.io/slamdunk"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: Single csv/tsv file (recommended) containing all sample files and 
      sample info or a list of all sample BAM/FASTA(gz)/FASTQ(gz) files
    inputBinding:
      position: 1
  - id: bed_file
    type: File
    doc: BED file with 3'UTR coordinates
    inputBinding:
      position: 102
      prefix: --bed
  - id: conversion_threshold
    type:
      - 'null'
      - int
    doc: Number of T>C conversions required to count read as T>C read
    inputBinding:
      position: 102
      prefix: --conversion-threshold
  - id: endtoend
    type:
      - 'null'
      - boolean
    doc: Use a end to end alignment algorithm for mapping.
    inputBinding:
      position: 102
      prefix: --endtoend
  - id: filter_bed_file
    type:
      - 'null'
      - File
    doc: BED file with 3'UTR coordinates to filter multimappers (activates -m)
    inputBinding:
      position: 102
      prefix: --filterbed
  - id: max_nm
    type:
      - 'null'
      - int
    doc: Maximum NM for alignments
    inputBinding:
      position: 102
      prefix: --max-nm
  - id: max_polya
    type:
      - 'null'
      - int
    doc: Max number of As at the 3' end of a read
    inputBinding:
      position: 102
      prefix: --max-polya
  - id: max_read_length
    type:
      - 'null'
      - int
    doc: Max read length in BAM file
    inputBinding:
      position: 102
      prefix: --max-read-length
  - id: min_base_qual
    type:
      - 'null'
      - int
    doc: Min base quality for T -> C conversions
    inputBinding:
      position: 102
      prefix: --min-base-qual
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: Minimimum coverage to call variant
    inputBinding:
      position: 102
      prefix: --min-coverage
  - id: min_identity
    type:
      - 'null'
      - float
    doc: Minimum alignment identity
    inputBinding:
      position: 102
      prefix: --min-identity
  - id: min_mq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality
    inputBinding:
      position: 102
      prefix: --min-mq
  - id: multimap
    type:
      - 'null'
      - boolean
    doc: Use reference to resolve multimappers (requires -n > 1).
    inputBinding:
      position: 102
      prefix: --multimap
  - id: quantseq
    type:
      - 'null'
      - boolean
    doc: Run plain Quantseq alignment without SLAM-seq scoring
    inputBinding:
      position: 102
      prefix: --quantseq
  - id: reference_file
    type: File
    doc: Reference fasta file
    inputBinding:
      position: 102
      prefix: --reference
  - id: sample_index
    type:
      - 'null'
      - int
    doc: Run analysis only for sample <i>. Use for distributing slamdunk 
      analysis on a cluster (index is 1-based).
    inputBinding:
      position: 102
      prefix: --sample-index
  - id: sample_name
    type:
      - 'null'
      - string
    doc: Use this sample name for all supplied samples
    inputBinding:
      position: 102
      prefix: --sampleName
  - id: sample_time
    type:
      - 'null'
      - string
    doc: Use this sample time for all supplied samples
    inputBinding:
      position: 102
      prefix: --sampleTime
  - id: sample_type
    type:
      - 'null'
      - string
    doc: Use this sample type for all supplied samples
    inputBinding:
      position: 102
      prefix: --sampleType
  - id: skip_sam
    type:
      - 'null'
      - boolean
    doc: Output BAM while mapping. Slower but, uses less hard disk.
    inputBinding:
      position: 102
      prefix: --skip-sam
  - id: threads
    type:
      - 'null'
      - int
    doc: Thread number
    inputBinding:
      position: 102
      prefix: --threads
  - id: topn
    type:
      - 'null'
      - int
    doc: Max. number of alignments to report per read
    inputBinding:
      position: 102
      prefix: --topn
  - id: trim_5p
    type:
      - 'null'
      - int
    doc: Number of bp removed from 5' end of all reads
    inputBinding:
      position: 102
      prefix: --trim-5p
  - id: var_fraction
    type:
      - 'null'
      - float
    doc: Minimimum variant fraction to call variant
    inputBinding:
      position: 102
      prefix: --var-fraction
  - id: vcf_file
    type:
      - 'null'
      - File
    doc: Skip SNP step and provide custom variant file.
    inputBinding:
      position: 102
      prefix: --vcf
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory for slamdunk run.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slamdunk:0.4.3--py_0
