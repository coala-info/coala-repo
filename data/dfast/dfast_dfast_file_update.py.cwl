cwlVersion: v1.2
class: CommandLineTool
baseCommand: dfast_dfast_file_update.py
label: dfast_dfast_file_update.py
doc: "Update dfast files (Note: The provided help text contains only system error
  messages regarding container execution and does not list command-line arguments).\n
  \nTool homepage: https://dfast.nig.ac.jp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dfast:1.3.7--h5ca1c30_0
stdout: dfast_dfast_file_update.py.out
