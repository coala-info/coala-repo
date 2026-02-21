cwlVersion: v1.2
class: CommandLineTool
baseCommand: minirmd
label: minirmd
doc: "A tool for removing duplicate reads from DNA sequencing data. (Note: The provided
  text contains system error messages regarding container execution and does not list
  specific command-line arguments.)\n\nTool homepage: https://github.com/yuansliu/minirmd"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minirmd:1.1--h077b44d_5
stdout: minirmd.out
