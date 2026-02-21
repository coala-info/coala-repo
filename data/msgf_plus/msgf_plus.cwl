cwlVersion: v1.2
class: CommandLineTool
baseCommand: msgf_plus
label: msgf_plus
doc: "MS-GF+ (Mass Spectrometer-Generating Function Plus) peptide identification tool.
  Note: The provided help text contains only container runtime error messages and
  no usage information.\n\nTool homepage: https://msgfplus.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msgf_plus:2024.03.26--hdfd78af_0
stdout: msgf_plus.out
