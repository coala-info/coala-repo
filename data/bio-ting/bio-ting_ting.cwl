cwlVersion: v1.2
class: CommandLineTool
baseCommand: bio-ting
label: bio-ting_ting
doc: "Taxonomic Identification of Next-generation sequencing data (Note: The provided
  text is an error log and does not contain usage instructions or argument definitions).\n
  \nTool homepage: https://github.com/FelixMoelder/ting"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio-ting:1.1.0--py_0
stdout: bio-ting_ting.out
