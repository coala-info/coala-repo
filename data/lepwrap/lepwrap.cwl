cwlVersion: v1.2
class: CommandLineTool
baseCommand: lepwrap
label: lepwrap
doc: "The provided text does not contain help information or usage instructions for
  lepwrap; it contains system logs and a fatal error regarding container image creation
  (no space left on device).\n\nTool homepage: https://github.com/pdimens/LepWrap/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lepwrap:5.0--hdfd78af_0
stdout: lepwrap.out
