cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigsi-v0.3.1 bloom
label: bigsi_bloom
doc: "Creates a bloom filter from a sequence file or cortex graph.\n\nTool homepage:
  https://github.com/Phelimb/BIGSI"
inputs:
  - id: ctx
    type: File
    doc: Sequence file or cortex graph (fastq, fasta, bam, ctx)
    inputBinding:
      position: 1
  - id: config
    type:
      - 'null'
      - string
    doc: Configuration file
    inputBinding:
      position: 102
      prefix: --config
outputs:
  - id: outfile
    type: File
    doc: Output file for the bloom filter
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bigsi:0.3.1--py_0
