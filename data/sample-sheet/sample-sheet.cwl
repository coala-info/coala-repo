cwlVersion: v1.2
class: CommandLineTool
baseCommand: sample-sheet
label: sample-sheet
doc: "The provided text does not contain help information or usage instructions for
  the tool. It is a log of a failed container image build/fetch process.\n\nTool homepage:
  https://github.com/clintval/sample-sheet"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sample-sheet:0.13.0--pyhdfd78af_0
stdout: sample-sheet.out
