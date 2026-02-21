cwlVersion: v1.2
class: CommandLineTool
baseCommand: kipoi_veff
label: kipoi_veff
doc: "The provided text does not contain help information or usage instructions; it
  contains system log messages and a fatal error regarding disk space during a container
  image build.\n\nTool homepage: https://github.com/kipoi/kipoi-veff"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kipoi:0.8.6--pyh5e36f6f_0
stdout: kipoi_veff.out
