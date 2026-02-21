cwlVersion: v1.2
class: CommandLineTool
baseCommand: pathtools
label: pathtools
doc: "The provided text does not contain help information or a description of the
  tool's functionality, as it appears to be a system error log indicating the executable
  was not found.\n\nTool homepage: https://github.com/gorakhargosh/pathtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pathtools:0.1.2--py35_0
stdout: pathtools.out
