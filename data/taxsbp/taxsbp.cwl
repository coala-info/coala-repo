cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxsbp
label: taxsbp
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container build process.\n\nTool homepage: https://github.com/pirovc/taxsbp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxsbp:1.1.1--py_0
stdout: taxsbp.out
