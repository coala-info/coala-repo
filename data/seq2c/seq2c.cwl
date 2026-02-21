cwlVersion: v1.2
class: CommandLineTool
baseCommand: seq2c
label: seq2c
doc: "The provided text is an error log from a failed container build/execution and
  does not contain help information or usage instructions for the seq2c tool. As a
  result, no arguments could be extracted.\n\nTool homepage: https://github.com/AstraZeneca-NGS/Seq2C"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seq2c:2019.05.30--pl526_0
stdout: seq2c.out
