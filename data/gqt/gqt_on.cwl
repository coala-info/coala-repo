cwlVersion: v1.2
class: CommandLineTool
baseCommand: gqt
label: gqt_on
doc: "gqt, v1.1.3\n\nTool homepage: https://github.com/ryanlayer/gqt"
inputs:
  - id: command
    type: string
    doc: Command to execute (convert, query, pca-shared, calpha, gst, fst)
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options for the command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gqt:1.1.3--h0263287_3
stdout: gqt_on.out
