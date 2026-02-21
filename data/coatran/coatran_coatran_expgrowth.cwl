cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - coatran
  - coatran_expgrowth
label: coatran_coatran_expgrowth
doc: "Comparative Transcriptomics Analysis (coatran) - exponential growth module.
  Note: The provided help text contains only system error logs regarding container
  image creation and does not list specific command-line arguments.\n\nTool homepage:
  https://github.com/niemasd/CoaTran"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coatran:0.0.4--h503566f_1
stdout: coatran_coatran_expgrowth.out
