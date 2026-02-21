cwlVersion: v1.2
class: CommandLineTool
baseCommand: motifraptor
label: motifraptor
doc: "The provided text does not contain help information or usage instructions for
  motifraptor. It contains a fatal error message regarding container image conversion
  and disk space.\n\nTool homepage: https://github.com/pinellolab/MotifRaptor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/motifraptor:0.3.0--py36h40b2fa4_5
stdout: motifraptor.out
