cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - apptainer
  - sif
  - setprim
label: apptainer_sif_setprim
doc: "Set the primary system partition in a SIF image.\n\nTool homepage: https://github.com/apptainer/apptainer"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.sif_path)
        writable: true
inputs:
  - id: object_id
    type: int
    doc: ID of the data object (see sif list)
    inputBinding:
      position: 1
  - id: sif_path
    type: File
    doc: SIF image to change (changed in place; a copy is returned)
    inputBinding:
      position: 2
outputs:
  - id: sif_image
    type: File
    doc: The changed SIF image
    outputBinding:
      glob: $(inputs.sif_path.basename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/apptainer:latest
