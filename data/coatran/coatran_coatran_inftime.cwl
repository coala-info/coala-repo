cwlVersion: v1.2
class: CommandLineTool
baseCommand: coatran_inftime
label: coatran_coatran_inftime
doc: "CoaTran v0.0.4 (time of infection)\n\nTool homepage: https://github.com/niemasd/CoaTran"
inputs:
  - id: trans_network
    type: File
    doc: Transmission network file
    inputBinding:
      position: 1
  - id: sample_times
    type: File
    doc: Sample times file
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coatran:0.0.4--h503566f_1
stdout: coatran_coatran_inftime.out
