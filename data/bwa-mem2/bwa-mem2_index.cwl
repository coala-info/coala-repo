cwlVersion: v1.2
class: CommandLineTool
baseCommand: bwa-mem2 index
label: bwa-mem2_index
doc: "Build index for BWA-MEM2\n\nTool homepage: https://github.com/bwa-mem2/bwa-mem2"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for index files
    inputBinding:
      position: 102
      prefix: -p
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwa-mem2:2.3--he70b90d_0
stdout: bwa-mem2_index.out
