cwlVersion: v1.2
class: CommandLineTool
baseCommand: seq2c_seq2cov.pl
label: seq2c_seq2cov.pl
doc: "Note: The provided text is an error log regarding a container build failure
  (no space left on device) and does not contain help or usage information for the
  tool.\n\nTool homepage: https://github.com/AstraZeneca-NGS/Seq2C"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seq2c:2019.05.30--pl526_0
stdout: seq2c_seq2cov.pl.out
