cwlVersion: v1.2
class: CommandLineTool
baseCommand: punlearn
label: heasoft_punlearn
doc: "Resets the parameter file for a specific HEASoft task to its system defaults.\n
  \nTool homepage: https://heasarc.gsfc.nasa.gov/lheasoft/"
inputs:
  - id: task_name
    type: string
    doc: The name of the HEASoft task whose parameters should be reset.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/heasoft:6.35.2--hedafe93_1
stdout: heasoft_punlearn.out
