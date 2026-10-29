cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_mask_create
label: relion_relion_mask_create
doc: "Create a 3D mask from a map by thresholding, extension and soft edges (or de novo).\n\nTool homepage:\
  \ https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: Input map to use for thresholding to generate initial binary mask
    inputBinding:
      position: 101
      prefix: --i
  - id: output
    type:
      - 'null'
      - string
    doc: 'Output mask (RELION default: mask.mrc)'
    inputBinding:
      position: 101
      prefix: --o
    default: mask.mrc
  - id: and_map
    type:
      - 'null'
      - File
    doc: Pixels in the initial mask will be one if the input AND this map are above the --ini_threshold
      value
    inputBinding:
      position: 101
      prefix: --and
  - id: or_map
    type:
      - 'null'
      - File
    doc: Pixels in the initial mask will be one if the input OR this map are above the --ini_threshold
      value
    inputBinding:
      position: 101
      prefix: --or
  - id: and_not_map
    type:
      - 'null'
      - File
    doc: Pixels in the initial mask will be one if the input is above the --ini_threshold AND this map
      is below it
    inputBinding:
      position: 101
      prefix: --and_not
  - id: or_not_map
    type:
      - 'null'
      - File
    doc: Pixels in the initial mask will be one if the input is above the --ini_threshold OR this map
      is below it
    inputBinding:
      position: 101
      prefix: --or_not
  - id: ini_threshold
    type:
      - 'null'
      - float
    doc: 'Initial threshold for binarization (RELION default: 0.01)'
    inputBinding:
      position: 101
      prefix: --ini_threshold
  - id: extend_inimask
    type:
      - 'null'
      - float
    doc: 'Extend initial binary mask this number of pixels (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --extend_inimask
  - id: width_soft_edge
    type:
      - 'null'
      - float
    doc: 'Width (in pixels) of the additional soft edge on the binary mask (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --width_soft_edge
  - id: invert
    type:
      - 'null'
      - boolean
    doc: Invert the final mask
    inputBinding:
      position: 101
      prefix: --invert
  - id: helix
    type:
      - 'null'
      - boolean
    doc: Generate a mask for 3D helix
    inputBinding:
      position: 101
      prefix: --helix
  - id: lowpass
    type:
      - 'null'
      - float
    doc: 'Lowpass filter (in Angstroms) for the input map, prior to binarization (default is none) (RELION
      default: -1)'
    inputBinding:
      position: 101
      prefix: --lowpass
  - id: angpix
    type:
      - 'null'
      - float
    doc: 'Pixel size (in Angstroms) for the lowpass filter (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --angpix
  - id: z_percentage
    type:
      - 'null'
      - float
    doc: 'This box length along the center of Z axis contains good information of the helix (RELION default:
      0.3)'
    inputBinding:
      position: 101
      prefix: --z_percentage
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --j
  - id: denovo
    type:
      - 'null'
      - boolean
    doc: Create a mask de novo
    inputBinding:
      position: 101
      prefix: --denovo
  - id: box_size
    type:
      - 'null'
      - int
    doc: 'The box size of the mask in pixels (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --box_size
  - id: inner_radius
    type:
      - 'null'
      - float
    doc: 'Inner radius of the masked region in pixels (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --inner_radius
  - id: outer_radius
    type:
      - 'null'
      - float
    doc: 'Outer radius of the mask region in pixels (RELION default: 99999)'
    inputBinding:
      position: 101
      prefix: --outer_radius
  - id: center_x
    type:
      - 'null'
      - float
    doc: 'X coordinate of the center of the mask in pixels (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --center_x
  - id: center_y
    type:
      - 'null'
      - float
    doc: 'Y coordinate of the center of the mask in pixels (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --center_y
  - id: center_z
    type:
      - 'null'
      - float
    doc: 'Z coordinate of the center of the mask in pixels (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --center_z
  - id: staged_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Extra files that the input STAR file names (images, micrographs, maps, coordinate files). They
      are staged in the working directory so that the relative names in the STAR file resolve.
outputs:
  - id: mask
    type: File
    doc: Created mask
    outputBinding:
      glob: $(inputs.output)
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_mask_create.out
