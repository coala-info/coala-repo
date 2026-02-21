cwlVersion: v1.2
class: CommandLineTool
baseCommand: funannotate
label: funannotate
doc: "Funannotate is a pipeline for genome annotation. (Note: The provided help text
  contains only system error logs regarding a container build failure and does not
  list specific command-line arguments.)\n\nTool homepage: https://github.com/nextgenusfs/funannotate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/funannotate:1.8.17--pyhdfd78af_5
stdout: funannotate.out
