cwlVersion: v1.2
class: CommandLineTool
baseCommand: freyja aggregate
label: freyja_aggregate
doc: "Aggregates all demix data in RESULTS directory\n\nTool homepage: https://github.com/andersen-lab/Freyja"
inputs:
  - id: results
    type: Directory
    doc: Directory containing demix data
    inputBinding:
      position: 1
  - id: ext
    type:
      - 'null'
      - string
    doc: file extension option, e.g. X.ext
    inputBinding:
      position: 102
      prefix: --ext
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: name for aggregated results
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/freyja:2.0.3--pyhdfd78af_0
