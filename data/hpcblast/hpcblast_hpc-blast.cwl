cwlVersion: v1.2
class: CommandLineTool
baseCommand: hpc-blast
label: hpcblast_hpc-blast
doc: "HPC-BLAST (High-Performance Computing BLAST) is a tool for rapid sequence database
  searching. Note: The provided help text contains only system error logs and does
  not list specific command-line arguments.\n\nTool homepage: https://github.com/yodeng/hpc-blast"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hpcblast:1.0.2--pyhdfd78af_0
stdout: hpcblast_hpc-blast.out
