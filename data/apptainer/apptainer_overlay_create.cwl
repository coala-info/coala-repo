cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - apptainer
  - overlay
  - create
label: apptainer_overlay_create
doc: "The overlay create command allows creating EXT3 writable overlay image either as
  a single EXT3 image or by adding it automatically to an existing SIF image.\n\nTool
  homepage: https://github.com/apptainer/apptainer"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '${ return inputs.sif_image ? [{"entry": inputs.sif_image, "writable": true}] : []; }'
inputs:
  - id: sif_image
    type:
      - 'null'
      - File
    doc: Existing SIF image to add the overlay to (changed in place; a copy is returned).
      Give this or overlay_name.
    inputBinding:
      position: 10
  - id: overlay_name
    type:
      - 'null'
      - string
    doc: Name of a new single EXT3 overlay image. Used when sif_image is not given.
    inputBinding:
      position: 10
      valueFrom: '$(inputs.sif_image ? null : self)'
  - id: create_dir
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --create-dir
    doc: directory to create as part of the overlay layout
    inputBinding:
      position: 1
  - id: fakeroot
    type:
      - 'null'
      - boolean
    doc: make overlay layout usable by actions run with --fakeroot
    inputBinding:
      position: 1
      prefix: --fakeroot
  - id: size
    type:
      - 'null'
      - int
    doc: size of the EXT3 writable overlay in MiB (default 64, minimum 64)
    inputBinding:
      position: 1
      prefix: --size
  - id: sparse
    type:
      - 'null'
      - boolean
    doc: create a sparse overlay
    inputBinding:
      position: 1
      prefix: --sparse
outputs:
  - id: overlay_image
    type: File
    doc: The overlay image, or the SIF image with the overlay added
    outputBinding:
      glob: '$(inputs.sif_image ? inputs.sif_image.basename : inputs.overlay_name)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/apptainer:latest
