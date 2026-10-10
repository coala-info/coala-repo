cwlVersion: v1.2
class: CommandLineTool
baseCommand: mindagap.py
label: mindagap_mindagap.py
doc: "Takes a single panorama image and fills the empty grid lines with neighbour-weighted
  values. The result is written beside the input as <name>_gridfilled<ext>.\n\nTool
  homepage: https://github.com/ViriatoII/MindaGap"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.input.basename)
        entry: $(inputs.input)
        writable: true
inputs:
  - id: input
    type: File
    doc: Input tif/png file with grid lines to fill
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: box_size_gaussian_kernel
    type:
      - 'null'
      - int
    doc: Box size for gaussian kernel (bigger better for big gaps but less 
      accurate). Must be an odd number. Default 5.
    inputBinding:
      position: 2
  - id: rounds_gaussian_blur
    type:
      - 'null'
      - int
    doc: Number of rounds to apply gaussianBlur (more is better). Default 40.
    inputBinding:
      position: 3
  - id: edges
    type:
      - 'null'
      - boolean
    doc: Also smooth edges near grid lines (EXPERIMENTAL). Passed to the tool as
      "--edges True".
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
arguments:
  - position: 104
    prefix: --edges
    valueFrom: "$(inputs.edges ? 'True' : null)"
outputs:
  - id: gridfilled
    type: File
    doc: Image with the grid lines filled
    outputBinding:
      glob: '*_gridfilled*'
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mindagap:0.0.2--pyhdfd78af_1
stdout: mindagap_mindagap.py.out
