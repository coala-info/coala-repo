cwlVersion: v1.2
class: CommandLineTool
baseCommand: seurat-find-transfer-anchors.R
label: seurat-scripts_seurat-find-transfer-anchors.R
doc: "The provided text is a system error log indicating a failure to build or run
  the container image (no space left on device) and does not contain the help text
  for the tool. As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/ebi-gene-expression-group/r-seurat-scripts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
stdout: seurat-scripts_seurat-find-transfer-anchors.R.out
