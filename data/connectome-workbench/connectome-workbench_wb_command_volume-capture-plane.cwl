cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -volume-capture-plane
label: connectome-workbench_wb_command_volume-capture-plane
doc: "Renders an image of an arbitrary plane through the volume file, with a simple linear grayscale palette.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: volume
    type: File
    doc: "the volume file to interpolate from"
    inputBinding:
      position: 1
  - id: subvolume
    type: string
    doc: "the name or number of the subvolume to use"
    inputBinding:
      position: 2
  - id: interp
    type: string
    doc: "interpolation type: CUBIC, ENCLOSING_VOXEL or TRILINEAR"
    inputBinding:
      position: 3
  - id: h_dim
    type: int
    doc: "width of output image, in pixels"
    inputBinding:
      position: 4
  - id: v_dim
    type: int
    doc: "height of output image, in pixels"
    inputBinding:
      position: 5
  - id: scale_min
    type: float
    doc: "value to render as black"
    inputBinding:
      position: 6
  - id: scale_max
    type: float
    doc: "value to render as white"
    inputBinding:
      position: 7
  - id: bottom_left_x
    type: float
    doc: "x-coordinate of the bottom left of the output image"
    inputBinding:
      position: 8
  - id: bottom_left_y
    type: float
    doc: "y-coordinate of the bottom left of the output image"
    inputBinding:
      position: 9
  - id: bottom_left_z
    type: float
    doc: "z-coordinate of the bottom left of the output image"
    inputBinding:
      position: 10
  - id: bottom_right_x
    type: float
    doc: "x-coordinate of the bottom right of the output image"
    inputBinding:
      position: 11
  - id: bottom_right_y
    type: float
    doc: "y-coordinate of the bottom right of the output image"
    inputBinding:
      position: 12
  - id: bottom_right_z
    type: float
    doc: "z-coordinate of the bottom right of the output image"
    inputBinding:
      position: 13
  - id: top_left_x
    type: float
    doc: "x-coordinate of the top left of the output image"
    inputBinding:
      position: 14
  - id: top_left_y
    type: float
    doc: "y-coordinate of the top left of the output image"
    inputBinding:
      position: 15
  - id: top_left_z
    type: float
    doc: "z-coordinate of the top left of the output image"
    inputBinding:
      position: 16
  - id: image
    type: string
    doc: "output - the output image"
    inputBinding:
      position: 17
outputs:
  - id: output_image
    type: File
    doc: "the output image"
    outputBinding:
      glob: $(inputs.image)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
