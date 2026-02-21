cwlVersion: v1.2
class: CommandLineTool
baseCommand: spyder
label: spyder
doc: "The provided text does not contain help information or usage instructions for
  the tool; it is a log of a failed container build process.\n\nTool homepage: https://github.com/spyder-ide/spyder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spyder:3.3.1--py35_1
stdout: spyder.out
