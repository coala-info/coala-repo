cwlVersion: v1.2
class: CommandLineTool
baseCommand: hpcblast
label: hpcblast
doc: "High-Performance Computing BLAST (HPC-BLAST). Note: The provided text contains
  system error logs and does not list specific command-line arguments.\n\nTool homepage:
  https://github.com/yodeng/hpc-blast"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hpcblast:1.0.2--pyhdfd78af_0
stdout: hpcblast.out
