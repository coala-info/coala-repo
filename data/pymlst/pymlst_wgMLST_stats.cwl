cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wgMLST
  - stats
label: pymlst_wgMLST_stats
doc: "Extracts stats from a wgMLST DATABASE.\n\nTool homepage: https://github.com/bvalot/pyMLST"
inputs:
  - id: database
    type: File
    doc: "Path to the wgMLST database (SQLite file)"
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: "Database statistics"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pymlst:2.2.2--pyhdfd78af_0
stdout: pymlst_wgMLST_stats.out
