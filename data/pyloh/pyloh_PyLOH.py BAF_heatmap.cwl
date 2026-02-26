cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyloh_PyLOH.py
  - BAF_heatmap
label: pyloh_PyLOH.py BAF_heatmap
doc: "Generates a BAF heatmap from preprocessed files.\n\nTool homepage: https://github.com/uci-cbcl/PyLOH"
inputs:
  - id: filename_base
    type: string
    doc: Base name of preprocessed files created.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyloh:1.4.3--py27_0
stdout: pyloh_PyLOH.py BAF_heatmap.out
