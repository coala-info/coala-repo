cwlVersion: v1.2
class: CommandLineTool
baseCommand: bats
label: bats
doc: "Bash Automated Testing System\n\nTool homepage: https://github.com/sstephenson/bats"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bats:0.4.0--0
stdout: bats.out
