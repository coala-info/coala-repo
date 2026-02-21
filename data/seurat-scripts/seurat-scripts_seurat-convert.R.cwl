cwlVersion: v1.2
class: CommandLineTool
baseCommand: seurat-convert.R
label: seurat-scripts_seurat-convert.R
doc: "A script to convert Seurat objects between different formats. Note: The provided
  help text contained only system error logs regarding a failed container build ('no
  space left on device') and did not list command-line arguments.\n\nTool homepage:
  https://github.com/ebi-gene-expression-group/r-seurat-scripts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
stdout: seurat-scripts_seurat-convert.R.out
