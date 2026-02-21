cwlVersion: v1.2
class: CommandLineTool
baseCommand: binette
label: binette
doc: "Binette is a tool for metagenomic binning refinement (Note: The provided text
  is an error log and does not contain usage information or argument definitions).\n
  \nTool homepage: https://github.com/genotoul-bioinfo/binette"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/binette:1.2.1--pyh7e72e81_0
stdout: binette.out
