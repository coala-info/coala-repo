cwlVersion: v1.2
class: CommandLineTool
baseCommand: metavelvet_velveth
label: metavelvet_velveth
doc: "Prepare a dataset for the MetaVelvet assembler by hashing k-mers.\n\nTool homepage:
  https://github.com/hacchy/MetaVelvet"
inputs:
  - id: hash_length
    type: int
    doc: K-mer length (must be an odd number)
    inputBinding:
      position: 1
  - id: input_files
    type:
      type: array
      items: File
    doc: Input read files
    inputBinding:
      position: 2
  - id: bam
    type:
      - 'null'
      - boolean
    doc: Input files are in BAM format
    inputBinding:
      position: 103
      prefix: -bam
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: Input files are in FASTA format
    inputBinding:
      position: 103
      prefix: -fasta
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: Input files are in FASTQ format
    inputBinding:
      position: 103
      prefix: -fastq
  - id: fastq_gz
    type:
      - 'null'
      - boolean
    doc: Input files are in compressed FASTQ format
    inputBinding:
      position: 103
      prefix: -fastq.gz
  - id: long
    type:
      - 'null'
      - boolean
    doc: Long reads (e.g. Sanger, 454)
    inputBinding:
      position: 103
      prefix: -long
  - id: no_hash
    type:
      - 'null'
      - boolean
    doc: Do not compute the hash table, just prepare the Sequences file
    inputBinding:
      position: 103
      prefix: -noHash
  - id: reuse_sequences
    type:
      - 'null'
      - boolean
    doc: Reuse the Sequences file already in the directory
    inputBinding:
      position: 103
      prefix: -reuse_Sequences
  - id: sam
    type:
      - 'null'
      - boolean
    doc: Input files are in SAM format
    inputBinding:
      position: 103
      prefix: -sam
  - id: short
    type:
      - 'null'
      - boolean
    doc: Short single-end reads
    inputBinding:
      position: 103
      prefix: -short
  - id: short_paired
    type:
      - 'null'
      - boolean
    doc: Short paired-end reads
    inputBinding:
      position: 103
      prefix: -shortPaired
  - id: strand_specific
    type:
      - 'null'
      - boolean
    doc: For strand-specific transcriptome sequencing data
    inputBinding:
      position: 103
      prefix: -strand_specific
outputs:
  - id: output_directory
    type: Directory
    doc: Directory for output files
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metavelvet:1.2.02--1
