cwlVersion: v1.2
class: CommandLineTool
baseCommand: indelible
label: indelible
doc: "INDELible V1.03 by Will Fletcher: Simulation began at Wed Feb 25 00:46:21 2026\n\
  \nTool homepage: https://github.com/HurlesGroupSanger/indelible"
inputs:
  - id: control_file
    type: File
    doc: Control file for INDELible
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/indelible:v1.03-4-deb_cv1
stdout: indelible.out
