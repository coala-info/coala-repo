cwlVersion: v1.2
class: CommandLineTool
baseCommand: bellerophon
label: bellerophon
doc: "Bellerophon is a program for detecting chimeric sequences in multiple sequence
  alignments of 16S rRNA.\n\nTool homepage: https://github.com/davebx/bellerophon/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bellerophon:1.0--pyh5e36f6f_0
stdout: bellerophon.out
