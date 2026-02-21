cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - domino
  - slicer
label: domino_slicer
doc: "The provided text does not contain help information or documentation for the
  tool. It consists of system log messages and a fatal error regarding container image
  creation (no space left on device).\n\nTool homepage: https://github.com/Shamir-Lab/DOMINO"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/domino:1.0.0--pyhdfd78af_0
stdout: domino_slicer.out
