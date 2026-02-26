cwlVersion: v1.2
class: CommandLineTool
baseCommand: gofasta sam
label: gofasta_sam
doc: "Do things with sam files\n\nTool homepage: https://github.com/cov-ert/gofasta"
inputs:
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference fasta file used to generate the sam file
    inputBinding:
      position: 101
      prefix: --reference
  - id: samfile
    type:
      - 'null'
      - File
    doc: Samfile to read. If none is specified, will read from stdin
    default: stdin
    inputBinding:
      position: 101
      prefix: --samfile
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gofasta:1.2.3--h9ee0642_0
stdout: gofasta_sam.out
