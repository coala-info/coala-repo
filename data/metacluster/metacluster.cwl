cwlVersion: v1.2
class: CommandLineTool
baseCommand: metacluster
label: metacluster
doc: "A tool for metagenomic clustering. (Note: The provided text contains system
  error messages regarding container image extraction and does not contain usage instructions
  or argument definitions.)\n\nTool homepage: https://github.com/thieu1995/MetaCluster"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metacluster:5.1--h9948957_7
stdout: metacluster.out
