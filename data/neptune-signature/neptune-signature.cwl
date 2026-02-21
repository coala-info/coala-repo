cwlVersion: v1.2
class: CommandLineTool
baseCommand: neptune-signature
label: neptune-signature
doc: "The provided text does not contain help information or a description of the
  tool. It contains system log messages and a fatal error regarding container image
  creation (no space left on device).\n\nTool homepage: https://github.com/phac-nml/neptune"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neptune-signature:2.0.0--pyhdfd78af_0
stdout: neptune-signature.out
