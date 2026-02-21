cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - coatran
  - constant
label: coatran_coatran_constant
doc: "COdon-Aware TRANslation (coatran) constant subcommand. Note: The provided help
  text contains only system error logs and no usage information.\n\nTool homepage:
  https://github.com/niemasd/CoaTran"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coatran:0.0.4--h503566f_1
stdout: coatran_coatran_constant.out
