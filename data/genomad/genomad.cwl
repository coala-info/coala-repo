cwlVersion: v1.2
class: CommandLineTool
baseCommand: genomad
label: genomad
doc: "The provided text does not contain help information or usage instructions. It
  contains system log messages and a fatal error regarding a container execution failure
  (no space left on device).\n\nTool homepage: https://portal.nersc.gov/genomad/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomad:1.11.2--pyhdfd78af_0
stdout: genomad.out
