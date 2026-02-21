cwlVersion: v1.2
class: CommandLineTool
baseCommand: difcover_from_ratio_per_window__to__DNAcopy_output.sh
label: difcover_from_ratio_per_window__to__DNAcopy_output.sh
doc: "A script to convert ratio per window data to DNAcopy output format. Note: The
  provided help text contains only system error logs regarding container execution
  and does not list specific command-line arguments.\n\nTool homepage: https://github.com/timnat/DifCover"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/difcover:3.0.1--h9948957_2
stdout: difcover_from_ratio_per_window__to__DNAcopy_output.sh.out
