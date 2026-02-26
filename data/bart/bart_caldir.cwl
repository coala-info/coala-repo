cwlVersion: v1.2
class: CommandLineTool
baseCommand: caldir
label: bart_caldir
doc: "Estimates coil sensitivities from the k-space center using a direct method (McKenzie
  et al.). The size of the fully-sampled calibration region is automatically determined
  but limited by {cal_size} (e.g. in the readout direction).\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: cal_size
    type: string
    doc: The size of the fully-sampled calibration region is automatically 
      determined but limited by {cal_size} (e.g. in the readout direction).
    inputBinding:
      position: 1
  - id: input
    type: File
    doc: Input file
    inputBinding:
      position: 2
outputs:
  - id: output
    type: File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
