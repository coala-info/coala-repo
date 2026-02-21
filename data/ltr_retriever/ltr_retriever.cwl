cwlVersion: v1.2
class: CommandLineTool
baseCommand: ltr_retriever
label: ltr_retriever
doc: "The provided text does not contain help information or usage instructions for
  ltr_retriever. It contains system log messages and a fatal error regarding container
  image conversion and disk space.\n\nTool homepage: https://github.com/oushujun/LTR_retriever"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ltr_harvest_parallel:1.2--hdfd78af_2
stdout: ltr_retriever.out
