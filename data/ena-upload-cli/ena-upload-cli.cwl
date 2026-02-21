cwlVersion: v1.2
class: CommandLineTool
baseCommand: ena-upload-cli
label: ena-upload-cli
doc: "A command-line interface tool for uploading data to the European Nucleotide
  Archive (ENA).\n\nTool homepage: https://github.com/usegalaxy-eu/ena-upload-cli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ena-upload-cli:0.9.0--pyhdfd78af_0
stdout: ena-upload-cli.out
