cwlVersion: v1.2
class: CommandLineTool
baseCommand: gatktool
label: gatktool
doc: "The provided text does not contain help information or usage instructions. It
  contains system log messages and a fatal error regarding container image acquisition
  (no space left on device).\n\nTool homepage: https://broadinstitute.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gatktool:0.0.1--py_0
stdout: gatktool.out
