cwlVersion: v1.2
class: CommandLineTool
baseCommand: ena-dl
label: ena-dl
doc: "A tool for downloading data from the European Nucleotide Archive (ENA). Note:
  The provided help text contains only system error messages and does not list specific
  command-line arguments.\n\nTool homepage: https://github.com/rpetit3/ena-dl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ena-dl:1.0.0--0
stdout: ena-dl.out
