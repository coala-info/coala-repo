cwlVersion: v1.2
class: CommandLineTool
baseCommand: pourrna_treekin
label: pourrna_treekin
doc: "The provided text does not contain help information; it is a container execution
  error log indicating a failure to fetch or build the OCI image for the pourrna tool.\n
  \nTool homepage: https://github.com/ViennaRNA/pourRNA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pourrna:1.2.0--h4ac6f70_4
stdout: pourrna_treekin.out
