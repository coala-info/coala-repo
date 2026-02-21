cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxor
label: taxor
doc: "A tool for taxonomic profiling and sequence search (Note: The provided text
  is an error log and does not contain help information or argument definitions).\n
  \nTool homepage: https://github.com/JensUweUlrich/Taxor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxor:0.2.1--h4e8ebbd_0
stdout: taxor.out
