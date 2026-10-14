cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - philosopher
  - pipeline
label: philosopher_pipeline
doc: "Automatic execution of consecutive analysis steps\n\nTool homepage: https://github.com/Nesvilab/philosopher"
inputs:
  - id: config
    type:
      - 'null'
      - File
    doc: "configuration file for the pipeline execution"
    inputBinding:
      position: 1
      prefix: --config
  - id: print
    type:
      - 'null'
      - boolean
    doc: "print the pipeline configuration file"
    inputBinding:
      position: 2
      prefix: --print
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
stdout: philosopher_pipeline.out
