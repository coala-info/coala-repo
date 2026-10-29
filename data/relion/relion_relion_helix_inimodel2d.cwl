cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_helix_inimodel2d
label: relion_relion_helix_inimodel2d
doc: "Generate an initial 3D model of a helix from 2D class averages of helical segments.\n\nTool homepage:\
  \ https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: output
    type: string
    doc: Output rootname
    inputBinding:
      position: 101
      prefix: --o
  - id: input
    type: File
    doc: STAR file with the input images and orientation parameters
    inputBinding:
      position: 101
      prefix: --i
  - id: crossover_distance
    type: float
    doc: Distance in Angstroms between 2 cross-overs
    inputBinding:
      position: 101
      prefix: --crossover_distance
  - id: iter
    type:
      - 'null'
      - float
    doc: 'Maximum number of iterations to perform (RELION default: 10)'
    inputBinding:
      position: 101
      prefix: --iter
  - id: K
    type:
      - 'null'
      - int
    doc: 'Number of classes (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --K
  - id: angpix
    type:
      - 'null'
      - float
    doc: 'Pixel size in Angstroms (default take from STAR file) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --angpix
  - id: maxres
    type:
      - 'null'
      - float
    doc: 'Limit calculations to approximately this resolution in Angstroms (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --maxres
  - id: search_shift
    type:
      - 'null'
      - float
    doc: 'How many Angstroms to search translations perpendicular to helical axis? (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --search_shift
  - id: search_angle
    type:
      - 'null'
      - float
    doc: 'How many degrees to search in-plane rotations? (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --search_angle
  - id: step_angle
    type:
      - 'null'
      - float
    doc: 'The step size (in degrees) of the rotational searches (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --step_angle
  - id: iniref
    type:
      - 'null'
      - File
    doc: An initial model to starting optimisation path
    inputBinding:
      position: 101
      prefix: --iniref
  - id: sym
    type:
      - 'null'
      - int
    doc: 'Order of symmetry in the 2D xy-slice? (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --sym
  - id: smear
    type:
      - 'null'
      - int
    doc: 'Smear out each image along X to ensure continuity (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --smear
  - id: random_seed
    type:
      - 'null'
      - int
    doc: 'Random seed (default is with clock) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --random_seed
  - id: search_size
    type:
      - 'null'
      - int
    doc: 'Search this many pixels up/down of the target downscaled size to fit best crossover distance
      (RELION default: 5)'
    inputBinding:
      position: 101
      prefix: --search_size
  - id: mask_diameter
    type:
      - 'null'
      - float
    doc: 'The diameter (A) of a mask to be aplpied to the 2D reconstruction (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --mask_diameter
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of (openMP) threads (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --j
  - id: only_make_3d
    type:
      - 'null'
      - boolean
    doc: Take the iniref image, and create a 3D model from that without any alignment of the input images
    inputBinding:
      position: 101
      prefix: --only_make_3d
  - id: staged_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Extra files that the input STAR file names (images, micrographs, maps, coordinate files). They
      are staged in the working directory so that the relative names in the STAR file resolve.
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Output files written with the output rootname
    outputBinding:
      glob: $(inputs.output)*
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_helix_inimodel2d.out
