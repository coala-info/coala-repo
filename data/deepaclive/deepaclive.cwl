cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepaclive
label: deepaclive
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding container image building (no space
  left on device).\n\nTool homepage: https://gitlab.com/dacs-hpi/deepac-live"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepaclive:0.3.2--py_0
stdout: deepaclive.out
