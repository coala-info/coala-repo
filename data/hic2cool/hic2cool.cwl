cwlVersion: v1.2
class: CommandLineTool
baseCommand: hic2cool
label: hic2cool
doc: "A tool for converting .hic files to .cool format. (Note: The provided help text
  contains only system error messages regarding container execution and does not list
  specific command-line arguments.)\n\nTool homepage: https://github.com/4dn-dcic/hic2cool"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hic2cool:1.0.1--pyh7cba7a3_0
stdout: hic2cool.out
