cwlVersion: v1.2
class: CommandLineTool
baseCommand: carnac-lr_CARNAC_to_fasta.py
label: carnac-lr_CARNAC_to_fasta.py
doc: "A script to convert CARNAC-LR output to FASTA format. (Note: The provided help
  text contains only system error logs regarding a failed container build and does
  not list command-line arguments.)\n\nTool homepage: https://github.com/kamimrcht/CARNAC-LR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/carnac-lr:1.0.0--h503566f_5
stdout: carnac-lr_CARNAC_to_fasta.py.out
