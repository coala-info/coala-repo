cwlVersion: v1.2
class: CommandLineTool
baseCommand: glob2
label: glob2
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime environment.\n\nTool homepage:
  https://github.com/miracle2k/python-glob2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/glob2:0.4.1--py35_0
stdout: glob2.out
