cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - apptainer
  - sif
  - dump
label: apptainer_sif_dump
doc: "Dump a data object from a SIF image.\n\nTool homepage: https://github.com/apptainer/apptainer"
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
    doc: Raw content of the data object
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/apptainer:latest
stdout: $(inputs.sif_path.nameroot).object$(inputs.object_id).dump
