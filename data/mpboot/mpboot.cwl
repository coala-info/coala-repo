cwlVersion: v1.2
class: CommandLineTool
baseCommand: mpboot
label: mpboot
doc: "A tool for maximum parsimony bootstrapping. Note: The provided help text contains
  only system error messages regarding container execution and does not list specific
  command-line arguments.\n\nTool homepage: https://github.com/diepthihoang/mpboot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mpboot:1.2--h503566f_0
stdout: mpboot.out
