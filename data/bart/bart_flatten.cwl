cwlVersion: v1.2
class: CommandLineTool
baseCommand: flatten
label: bart_flatten
doc: "Flattens a nested structure.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: input
    type: File
    doc: The input file or directory to flatten.
    inputBinding:
      position: 1
outputs:
  - id: output
    type: File
    doc: The output file or directory for the flattened structure.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
