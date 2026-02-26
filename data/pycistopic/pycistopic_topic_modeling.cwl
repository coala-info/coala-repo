cwlVersion: v1.2
class: CommandLineTool
baseCommand: pycistopic topic_modeling
label: pycistopic_topic_modeling
doc: "Topic modeling for pycisTopic\n\nTool homepage: https://github.com/aertslab/pycistopic"
inputs:
  - id: model_type
    type: string
    doc: Type of topic modeling to perform (lda or mallet)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pycistopic:2.0a--pyhdfd78af_0
stdout: pycistopic_topic_modeling.out
