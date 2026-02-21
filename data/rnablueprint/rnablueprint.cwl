cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnablueprint
label: rnablueprint
doc: "The provided text does not contain help information for rnablueprint; it is
  a log of a failed container build/fetch process.\n\nTool homepage: https://github.com/ViennaRNA/RNAblueprint"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnablueprint:1.3.3--py311pl5321h6accb3f_0
stdout: rnablueprint.out
