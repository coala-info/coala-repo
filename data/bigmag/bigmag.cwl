cwlVersion: v1.2
class: CommandLineTool
baseCommand: app.py
label: bigmag
doc: "BIgMAG\n\nTool homepage: https://github.com/jeffe107/BIgMAG"
inputs:
  - id: file
    type: File
    doc: File with concatenated dataframes.
    inputBinding:
      position: 1
  - id: host
    type:
      - 'null'
      - string
    doc: Host to run the app.
    inputBinding:
      position: 102
      prefix: --host
  - id: port
    type:
      - 'null'
      - int
    doc: Port to run the app.
    inputBinding:
      position: 102
      prefix: --port
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bigmag:1.1.0--pyhdfd78af_0
stdout: bigmag.out
