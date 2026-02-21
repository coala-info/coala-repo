cwlVersion: v1.2
class: CommandLineTool
baseCommand: logol-bin_logolTest.sh
label: logol-bin_logolTest.sh
doc: "Test script for Logol-bin. Note: The provided help text contains only system
  error messages regarding container image conversion and disk space issues, and does
  not list specific command-line arguments.\n\nTool homepage: https://github.com/genouest/logol"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/logol-bin:v1.7.9-1-deb_cv1
stdout: logol-bin_logolTest.sh.out
