cwlVersion: v1.2
class: CommandLineTool
baseCommand: logol
label: logol
doc: "Logol is a tool for pattern matching on DNA/RNA or protein sequences (Note:
  The provided help text contains only system error messages and no usage information).\n
  \nTool homepage: https://github.com/genouest/logol"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/logol:v1.7.9-1-deb_cv1
stdout: logol.out
