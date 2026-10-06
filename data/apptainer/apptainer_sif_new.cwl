cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - apptainer
  - sif
  - new
label: apptainer_sif_new
doc: "Create a new, empty SIF image.\n\nTool homepage: https://github.com/apptainer/apptainer"
inputs:
  - id: sif_path
    type: string
    doc: Name of the new SIF image
    default: image.sif
    inputBinding:
      position: 1
outputs:
  - id: sif_image
    type: File
    doc: The new, empty SIF image
    outputBinding:
      glob: $(inputs.sif_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/apptainer:latest
