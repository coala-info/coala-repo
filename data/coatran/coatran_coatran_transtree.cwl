cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - coatran
  - transtree
label: coatran_coatran_transtree
doc: "A tool within the coatran package (description unavailable due to error in provided
  help text).\n\nTool homepage: https://github.com/niemasd/CoaTran"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coatran:0.0.4--h503566f_1
stdout: coatran_coatran_transtree.out
