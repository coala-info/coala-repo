cwlVersion: v1.2
class: CommandLineTool
baseCommand: difcover_run_difcover.sh
label: difcover_run_difcover.sh
doc: "A tool for identifying genomic differences (DifCover). Note: The provided help
  text contains only system error logs and does not list command-line arguments.\n
  \nTool homepage: https://github.com/timnat/DifCover"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/difcover:3.0.1--h9948957_2
stdout: difcover_run_difcover.sh.out
