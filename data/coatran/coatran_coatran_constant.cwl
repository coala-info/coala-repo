cwlVersion: v1.2
class: CommandLineTool
baseCommand: coatran_constant
label: coatran_coatran_constant
doc: "CoaTran (constant effective population size)\n\nTool homepage: https://github.com/niemasd/CoaTran"
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
  - id: eff_pop_size
    type: float
    doc: Constant effective population size
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coatran:0.0.4--h503566f_1
stdout: coatran_coatran_constant.out
