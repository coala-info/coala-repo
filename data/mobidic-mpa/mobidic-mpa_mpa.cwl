cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mpa
label: mobidic-mpa_mpa
doc: "Mobidic Multi-Purpose Analyzer (Note: The provided text contains container runtime
  errors and does not list specific tool arguments. No arguments could be parsed from
  the input.)\n\nTool homepage: https://neuro-2.iurc.montp.inserm.fr/mpaweb/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mobidic-mpa:1.3.0--pyh5e36f6f_0
stdout: mobidic-mpa_mpa.out
