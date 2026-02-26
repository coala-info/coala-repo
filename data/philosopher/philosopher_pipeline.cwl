cwlVersion: v1.2
class: CommandLineTool
baseCommand: philosopher_pipeline
label: philosopher_pipeline
doc: "Executes a pipeline.\n\nTool homepage: https://github.com/Nesvilab/philosopher"
inputs:
  - id: input_file
    type: File
    doc: The input file for the pipeline.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
stdout: philosopher_pipeline.out
