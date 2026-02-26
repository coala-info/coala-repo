cwlVersion: v1.2
class: CommandLineTool
baseCommand: coatran_expgrowth
label: coatran_coatran_expgrowth
doc: "CoaTran (exponential effective population size growth)\n\nTool homepage: https://github.com/niemasd/CoaTran"
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
  - id: init_eff_pop_size
    type: float
    doc: Initial effective population size
    inputBinding:
      position: 3
  - id: eff_pop_growth
    type: float
    doc: Effective population growth rate
    inputBinding:
      position: 4
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coatran:0.0.4--h503566f_1
stdout: coatran_coatran_expgrowth.out
