cwlVersion: v1.2
class: CommandLineTool
baseCommand: bpipe register
label: bpipe_register
doc: "Register a pipeline with Bpipe\n\nTool homepage: http://docs.bpipe.org/"
inputs:
  - id: pipeline
    type: string
    doc: The pipeline to register
    inputBinding:
      position: 1
  - id: inputs
    type:
      type: array
      items: string
    doc: Input files for the pipeline
    inputBinding:
      position: 2
  - id: execute
    type:
      - 'null'
      - boolean
    doc: Execute the pipeline after registering
    inputBinding:
      position: 103
      prefix: -e
  - id: format
    type:
      - 'null'
      - string
    doc: The format of the pipeline
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
stdout: bpipe_register.out
