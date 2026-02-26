cwlVersion: v1.2
class: CommandLineTool
baseCommand: gxwf-lint
label: gxformat2_gxwf-lint
doc: "Lint a workflow file.\n\nTool homepage: https://github.com/jmchilton/gxformat2"
inputs:
  - id: path
    type: File
    doc: workflow path
    inputBinding:
      position: 1
  - id: training_topic
    type:
      - 'null'
      - string
    doc: If this is a training workflow, specify a training topic.
    inputBinding:
      position: 102
      prefix: --training-topic
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gxformat2:0.22.0--pyhdfd78af_0
stdout: gxformat2_gxwf-lint.out
