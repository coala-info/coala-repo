cwlVersion: v1.2
class: CommandLineTool
baseCommand: tbox-scan
label: tbox-scan
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container execution environment.\n\nTool homepage:
  https://tbdb.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tbox-scan:1.0.2--hdfd78af_2
stdout: tbox-scan.out
