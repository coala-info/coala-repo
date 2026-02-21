cwlVersion: v1.2
class: CommandLineTool
baseCommand: opfi
label: opfi
doc: "The provided text does not contain help information or usage instructions for
  the tool 'opfi'. It contains system log messages and a fatal error regarding container
  image building (no space left on device).\n\nTool homepage: https://github.com/wilkelab/Opfi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/opfi:0.1.2--pyhdfd78af_0
stdout: opfi.out
