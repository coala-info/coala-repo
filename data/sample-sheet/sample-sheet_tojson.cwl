cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sample-sheet
  - tojson
label: sample-sheet_tojson
doc: "Convert a sample sheet to JSON format.\n\nTool homepage: https://github.com/clintval/sample-sheet"
inputs:
  - id: path
    type: File
    doc: Path to the sample sheet file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sample-sheet:0.13.0--pyhdfd78af_0
stdout: sample-sheet_tojson.out
