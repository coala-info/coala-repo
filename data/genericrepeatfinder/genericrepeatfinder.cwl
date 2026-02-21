cwlVersion: v1.2
class: CommandLineTool
baseCommand: genericrepeatfinder
label: genericrepeatfinder
doc: "A tool for finding repeats in genomic sequences (Note: The provided help text
  contains only system error messages and no usage information).\n\nTool homepage:
  https://github.com/bioinfolabmu/GenericRepeatFinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genericrepeatfinder:1.0.2--h9948957_1
stdout: genericrepeatfinder.out
