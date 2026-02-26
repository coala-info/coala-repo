cwlVersion: v1.2
class: CommandLineTool
baseCommand: soapsplice
label: soapsplice
doc: SOAPsplice is a tool for genome-wide ab initio detection of splice 
  junctions from RNA-Seq data, supporting both fastq and fasta formats.
inputs:
  - id: index_prefix
    type: File
    doc: Reference genome index prefix
    inputBinding:
      position: 101
      prefix: -d
  - id: max_gap
    type:
      - 'null'
      - int
    doc: Maximum gap allowed in one segment
    default: 2
    inputBinding:
      position: 101
      prefix: -g
  - id: max_intron_length
    type:
      - 'null'
      - int
    doc: Maximum intron length
    default: 50000
    inputBinding:
      position: 101
      prefix: -I
  - id: max_mismatch
    type:
      - 'null'
      - int
    doc: Maximum mismatch allowed in one segment
    default: 2
    inputBinding:
      position: 101
      prefix: -m
  - id: min_intron_length
    type:
      - 'null'
      - int
    doc: Minimum intron length
    default: 50
    inputBinding:
      position: 101
      prefix: -J
  - id: min_segment_length
    type:
      - 'null'
      - int
    doc: Minimum segment length
    default: 8
    inputBinding:
      position: 101
      prefix: -l
  - id: output_format
    type:
      - 'null'
      - int
    doc: 'Output format (1: SAM, 2: SOAP)'
    default: 1
    inputBinding:
      position: 101
      prefix: -f
  - id: quality_system
    type:
      - 'null'
      - int
    doc: 'Quality system (1: Illumina 1.3+, 2: Sanger/Illumina 1.8+)'
    default: 1
    inputBinding:
      position: 101
      prefix: -q
  - id: query_1
    type: File
    doc: Query file 1 (Fastq/Fasta)
    inputBinding:
      position: 101
      prefix: '-1'
  - id: query_2
    type:
      - 'null'
      - File
    doc: Query file 2 (Fastq/Fasta) for paired-end reads
    inputBinding:
      position: 101
      prefix: '-2'
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 1
    inputBinding:
      position: 101
      prefix: -p
outputs:
  - id: output_file
    type: File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/soapsplice:1.10--2
