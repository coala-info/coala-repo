cwlVersion: v1.2
class: CommandLineTool
baseCommand: cellrank-krylov
label: cellrank-krylov
doc: "The provided text does not contain help information for the tool; it is a log
  of a failed container build process due to insufficient disk space.\n\nTool homepage:
  https://github.com/theislab/cellrank"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cellrank-krylov:1.5.1--pyh1e54042_0
stdout: cellrank-krylov.out
