cwlVersion: v1.2
class: CommandLineTool
baseCommand: lcr_genie
label: lcr_genie
doc: "A tool for identifying Low Complexity Regions (LCRs) in genomic sequences.\n
  \nTool homepage: https://github.com/conda-forge/lcr_genie-feedstock"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lcr_genie:1.0.2
stdout: lcr_genie.out
