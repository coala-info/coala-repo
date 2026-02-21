cwlVersion: v1.2
class: CommandLineTool
baseCommand: seurat-normalise-data.R
label: seurat-scripts_seurat-normalise-data.R
doc: "Note: The provided text is a container execution error log and does not contain
  the help documentation for the tool.\n\nTool homepage: https://github.com/ebi-gene-expression-group/r-seurat-scripts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
stdout: seurat-scripts_seurat-normalise-data.R.out
