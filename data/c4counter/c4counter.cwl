cwlVersion: v1.2
class: CommandLineTool
baseCommand: c4counter
label: c4counter
doc: "Count occurrences in reference FASTA files\n\nTool homepage: https://github.com/irunonayran/c4counter.git"
inputs:
  - id: references_fasta
    type:
      type: array
      items: File
    doc: Reference FASTA files
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/c4counter:0.0.2--pyhdfd78af_0
stdout: c4counter.out
