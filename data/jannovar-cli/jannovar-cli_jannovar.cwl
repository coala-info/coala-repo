cwlVersion: v1.2
class: CommandLineTool
baseCommand: jannovar
label: jannovar-cli_jannovar
doc: "Jannovar is a tool for functional annotation of VCF files.\n\nTool homepage:
  https://github.com/charite/jannovar"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jannovar-cli:0.36--hdfd78af_0
stdout: jannovar-cli_jannovar.out
