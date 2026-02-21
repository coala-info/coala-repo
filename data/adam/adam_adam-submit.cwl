cwlVersion: v1.2
class: CommandLineTool
baseCommand: adam-submit
label: adam_adam-submit
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains error logs related to a failed container build process.\n\n
  Tool homepage: https://github.com/bigdatagenomics/adam"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/adam:1.0.1--hdfd78af_0
stdout: adam_adam-submit.out
