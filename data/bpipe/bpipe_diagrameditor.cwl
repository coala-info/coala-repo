cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bpipe
  - diagram
label: bpipe_diagrameditor
doc: "Generate a diagram of a Bpipe pipeline\n\nTool homepage: http://docs.bpipe.org/"
inputs:
  - id: pipeline
    type: string
    doc: The Bpipe pipeline script
    inputBinding:
      position: 1
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files for the pipeline
    inputBinding:
      position: 2
  - id: enable_edges
    type:
      - 'null'
      - boolean
    doc: Enable edges in the diagram
    inputBinding:
      position: 103
      prefix: -e
  - id: format
    type:
      - 'null'
      - string
    doc: Output format for the diagram
    inputBinding:
      position: 103
      prefix: -f
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bpipe:0.9.13--hdfd78af_0
stdout: bpipe_diagrameditor.out
