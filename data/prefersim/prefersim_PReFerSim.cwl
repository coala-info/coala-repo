cwlVersion: v1.2
class: CommandLineTool
baseCommand: fwd_seldist_gsl_2012_4epoch.debug
label: prefersim_PReFerSim
doc: "General usage of the program\n\nTool homepage: https://github.com/LohmuellerLab/PReFerSim"
inputs:
  - id: parameter_file
    type: File
    doc: Parameter file
    inputBinding:
      position: 1
  - id: replicate_number
    type: int
    doc: Replicate number
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prefersim:1.0--h940b034_4
stdout: prefersim_PReFerSim.out
