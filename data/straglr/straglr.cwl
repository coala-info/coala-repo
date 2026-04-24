cwlVersion: v1.2
class: CommandLineTool
baseCommand: straglr.py
label: straglr
doc: "A tool for Short Tandem Repeat (STR) detection and genotyping using long-read
  sequencing data (PacBio or Oxford Nanopore).\n\nTool homepage: https://github.com/bcgsc/straglr"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file (sorted and indexed)
    inputBinding:
      position: 1
  - id: reference
    type: File
    doc: Reference genome fasta file
    inputBinding:
      position: 2
  - id: exclude
    type:
      - 'null'
      - File
    doc: BED file containing regions to exclude
    inputBinding:
      position: 103
      prefix: --exclude
  - id: loci
    type:
      - 'null'
      - File
    doc: BED file containing target loci to genotype
    inputBinding:
      position: 103
      prefix: --loci
  - id: max_str_len
    type:
      - 'null'
      - int
    doc: Maximum STR unit length
    inputBinding:
      position: 103
      prefix: --max_str_len
  - id: min_ins_size
    type:
      - 'null'
      - int
    doc: Minimum insertion size to consider
    inputBinding:
      position: 103
      prefix: --min_ins_size
  - id: min_support
    type:
      - 'null'
      - int
    doc: Minimum number of supporting reads
    inputBinding:
      position: 103
      prefix: --min_support
  - id: nprocs
    type:
      - 'null'
      - int
    doc: Number of processors to use
    inputBinding:
      position: 103
      prefix: --nprocs
outputs:
  - id: output_prefix
    type: File
    doc: Prefix for output files
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/straglr:1.5.6--pyhdfd78af_0
