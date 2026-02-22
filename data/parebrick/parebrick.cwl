cwlVersion: v1.2
class: CommandLineTool
baseCommand: parebrick
label: parebrick
doc: "A tool for identifying and analyzing parallel rearrangements in bacterial genomes.\n\
  \nTool homepage: https://github.com/ctlab/parallel-rearrangements"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parebrick:0.5.7--pyhdfd78af_0
stdout: parebrick.out
