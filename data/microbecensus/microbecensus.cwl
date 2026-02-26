cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_microbe_census.py
label: microbecensus
doc: "MicrobeCensus: Estimate average genome size (AGS) from metagenomic shotgun data.\n\
  \nTool homepage: https://github.com/snayfach/MicrobeCensus"
inputs:
  - id: seqfiles
    type:
      type: array
      items: File
    doc: Input metagenomic sequencing files (FASTQ/FASTA, can be gzipped)
    inputBinding:
      position: 1
  - id: number_reads
    type:
      - 'null'
      - int
    doc: Number of reads to sample from the input files
    default: 100000000
    inputBinding:
      position: 102
      prefix: -n
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 1
    inputBinding:
      position: 102
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: out_file
    type: File
    doc: Output file containing the estimated average genome size and other 
      metrics
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/microbecensus:1.1.1--0
