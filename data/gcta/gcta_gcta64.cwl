cwlVersion: v1.2
class: CommandLineTool
baseCommand: gcta64
label: gcta_gcta64
doc: "Genome-wide Complex Trait Analysis (GCTA)\n\nTool homepage: https://cnsgenomics.com/software/gcta/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gcta:1.94.1--h9ee0642_0
stdout: gcta_gcta64.out
