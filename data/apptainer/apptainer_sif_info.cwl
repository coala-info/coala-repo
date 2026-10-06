cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - apptainer
  - sif
  - info
label: apptainer_sif_info
doc: "Display info about a data object from a SIF image.\n\nTool homepage: https://github.com/apptainer/apptainer"
inputs:
  - id: object_id
    type: int
    doc: ID of the data object (see sif list)
    inputBinding:
      position: 1
  - id: sif_path
    type: File
    doc: SIF image to read
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Data object info
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/apptainer:latest
stdout: apptainer_sif_info.out
