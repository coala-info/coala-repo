cwlVersion: v1.2
class: CommandLineTool
baseCommand: mindagap.py
label: mindagap_mindagap.py
doc: "Takes a single panorama image and fills the empty grid lines with neighbour-weighted
  values\n\nTool homepage: https://github.com/ViriatoII/MindaGap"
inputs:
  - id: input
    type: File
    doc: Input tif/png file with grid lines to fill
    inputBinding:
      position: 1
  - id: box_size_gaussian_kernel
    type: int
    doc: Box size for gaussian kernel (bigger better for big gaps but less 
      accurate)
    inputBinding:
      position: 2
  - id: rounds_gaussian_blur
    type: int
    doc: Number of rounds to apply gaussianBlur (more is better)
    inputBinding:
      position: 3
  - id: edges
    type:
      - 'null'
      - boolean
    doc: Also smooth edges near grid lines
    inputBinding:
      position: 104
      prefix: --edges
  - id: no_version
    type:
      - 'null'
      - boolean
    doc: Print version number.
    default: false
    inputBinding:
      position: 104
      prefix: --no-version
  - id: xtilesize
    type:
      - 'null'
      - int
    doc: Tile size (distance between gridlines) on X axis
    inputBinding:
      position: 104
      prefix: --Xtilesize
  - id: ytilesize
    type:
      - 'null'
      - int
    doc: Tile size (distance between gridlines) on Y axis
    inputBinding:
      position: 104
      prefix: --Ytilesize
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mindagap:0.0.2--pyhdfd78af_1
stdout: mindagap_mindagap.py.out
