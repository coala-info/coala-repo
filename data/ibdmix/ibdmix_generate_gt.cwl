cwlVersion: v1.2
class: CommandLineTool
baseCommand: ibdmix_generate_gt
label: ibdmix_generate_gt
doc: "The provided text does not contain help information or usage instructions. It
  contains system logs and a fatal error indicating a failure to build the container
  image due to insufficient disk space.\n\nTool homepage: https://github.com/PrincetonUniversity/IBDmix"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ibdmix:1.0.1--h4ac6f70_2
stdout: ibdmix_generate_gt.out
