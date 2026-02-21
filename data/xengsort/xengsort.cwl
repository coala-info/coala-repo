cwlVersion: v1.2
class: CommandLineTool
baseCommand: xengsort
label: xengsort
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be an error log from a container build process.\n\nTool homepage:
  https://gitlab.com/genomeinformatics/xengsort"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xengsort:2.1.0--pyhdfd78af_1
stdout: xengsort.out
