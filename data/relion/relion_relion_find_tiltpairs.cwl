cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_find_tiltpairs
label: relion_relion_find_tiltpairs
doc: "Find tilt pairs between untilted and tilted micrograph coordinates.\n\nTool homepage: https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
      - entry: $(inputs.untilted)
        writable: true
      - entry: $(inputs.tilted)
        writable: true
inputs:
  - id: untilted
    type: File
    doc: STAR file with the untilted xy-coordinates
    inputBinding:
      position: 101
      prefix: --u
  - id: tilted
    type: File
    doc: STAR file with the untilted xy-coordinates
    inputBinding:
      position: 101
      prefix: --t
  - id: size
    type: int
    doc: Largest dimension of the micrograph (in pixels), e.g. 4096
    inputBinding:
      position: 101
      prefix: --size
  - id: acc
    type: float
    doc: Allowed accuracy (in pixels), e.g. half the particle diameter
    inputBinding:
      position: 101
      prefix: --acc
  - id: dim
    type:
      - 'null'
      - int
    doc: 'Dimension of boxed particles (for EMAN .box files in pixels) (RELION default: 200)'
    inputBinding:
      position: 101
      prefix: --dim
  - id: tilt
    type:
      - 'null'
      - float
    doc: 'Fix tilt angle (in degrees) (RELION default: 99999.)'
    inputBinding:
      position: 101
      prefix: --tilt
  - id: rot
    type:
      - 'null'
      - float
    doc: 'Fix direction of the tilt axis (in degrees), 0 = along y, 90 = along x (RELION default: 99999.)'
    inputBinding:
      position: 101
      prefix: --rot
  - id: dont_opt
    type:
      - 'null'
      - boolean
    doc: Skip optimization of the transformation matrix
    inputBinding:
      position: 101
      prefix: --dont_opt
  - id: tilt0
    type:
      - 'null'
      - float
    doc: 'Minimum tilt angle (in degrees) (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --tilt0
  - id: tiltF
    type:
      - 'null'
      - float
    doc: 'Maximum tilt angle (in degrees) (RELION default: 99999.)'
    inputBinding:
      position: 101
      prefix: --tiltF
  - id: tiltStep
    type:
      - 'null'
      - float
    doc: 'Tilt angle step size (in degrees) (RELION default: 1.)'
    inputBinding:
      position: 101
      prefix: --tiltStep
  - id: rot0
    type:
      - 'null'
      - float
    doc: 'Minimum rot angle (in degrees) (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --rot0
  - id: rotF
    type:
      - 'null'
      - float
    doc: 'Maximum rot angle (in degrees) (RELION default: 99999.)'
    inputBinding:
      position: 101
      prefix: --rotF
  - id: rotStep
    type:
      - 'null'
      - float
    doc: 'Rot angle step size (in degrees) (RELION default: 1.)'
    inputBinding:
      position: 101
      prefix: --rotStep
  - id: x0
    type:
      - 'null'
      - float
    doc: 'Minimum X offset (pixels) (RELION default: -99999)'
    inputBinding:
      position: 101
      prefix: --x0
  - id: xF
    type:
      - 'null'
      - float
    doc: 'Maximum X offset (pixels) (RELION default: 99999)'
    inputBinding:
      position: 101
      prefix: --xF
  - id: xStep
    type:
      - 'null'
      - float
    doc: 'X offset step size (pixels) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --xStep
  - id: y0
    type:
      - 'null'
      - float
    doc: 'Minimum Y offset (pixels) (RELION default: -99999)'
    inputBinding:
      position: 101
      prefix: --y0
  - id: yF
    type:
      - 'null'
      - float
    doc: 'Maximum Y offset (pixels) (RELION default: 99999)'
    inputBinding:
      position: 101
      prefix: --yF
  - id: yStep
    type:
      - 'null'
      - float
    doc: 'Y offset step size (pixels) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --yStep
  - id: staged_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Extra files that the input STAR file names (images, micrographs, maps, coordinate files). They
      are staged in the working directory so that the relative names in the STAR file resolve.
outputs:
  - id: untilted_pairs
    type: File
    doc: STAR file with the matched untilted coordinates, written as <untilted name>_pairs.star
    outputBinding:
      glob: $(inputs.untilted.nameroot)_pairs.star
  - id: tilted_pairs
    type: File
    doc: STAR file with the matched tilted coordinates, written as <tilted name>_pairs.star
    outputBinding:
      glob: $(inputs.tilted.nameroot)_pairs.star
  - id: distances
    type: File
    doc: Distances between the matched particles
    outputBinding:
      glob: dist.txt
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_find_tiltpairs.out
