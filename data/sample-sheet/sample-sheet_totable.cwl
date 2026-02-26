cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sample-sheet
  - totable
label: sample-sheet_totable
doc: "Pretty print a sample sheet to terminal\n\nTool homepage: https://github.com/clintval/sample-sheet"
inputs:
  - id: path
    type: string
    doc: Path to the sample sheet
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sample-sheet:0.13.0--pyhdfd78af_0
stdout: sample-sheet_totable.out
