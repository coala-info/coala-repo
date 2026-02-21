cwlVersion: v1.2
class: CommandLineTool
baseCommand: semidbm
label: semidbm
doc: "The provided text is a container build error log and does not contain help documentation
  or usage instructions for the semidbm tool. As a result, no arguments could be extracted.\n
  \nTool homepage: https://github.com/jamesls/semidbm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/semidbm:0.5.1--py36_1
stdout: semidbm.out
