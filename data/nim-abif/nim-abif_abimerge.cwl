cwlVersion: v1.2
class: CommandLineTool
baseCommand: abimerge
label: nim-abif_abimerge
doc: "A tool for merging ABIF files. (Note: The provided help text contains system
  error messages regarding container execution and does not list specific command-line
  arguments.)\n\nTool homepage: https://github.com/quadram-institute-bioscience/nim-abif"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nim-abif:0.2.0--h7b50bb2_0
stdout: nim-abif_abimerge.out
