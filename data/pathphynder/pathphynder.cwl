cwlVersion: v1.2
class: CommandLineTool
baseCommand: pathphynder
label: pathphynder
doc: "The provided text is a system error log (out of disk space) and does not contain
  the help documentation or usage instructions for the tool. Consequently, no arguments
  could be extracted.\n\nTool homepage: https://github.com/ruidlpm/pathPhynder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pathphynder:1.2.4--py313hdfd78af_0
stdout: pathphynder.out
