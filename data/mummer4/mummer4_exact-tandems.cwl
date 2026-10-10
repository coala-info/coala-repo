cwlVersion: v1.2
class: CommandLineTool
baseCommand: exact-tandems
label: mummer4_exact-tandems
doc: "Find exact tandem repeats of at least the minimum length in a file.\n\nTool homepage: https://mummer4.github.io/"
inputs:
  - id: file
    type: File
    doc: Input sequence file (FASTA)
    inputBinding:
      position: 1
  - id: min_match_len
    type: int
    doc: Minimum match length
    inputBinding:
      position: 2
outputs:
  - id: tandems
    type: stdout
    doc: Tandem repeats (standard output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer4:4.0.1--pl5321h9948957_0
stdout: mummer4_exact-tandems.out
