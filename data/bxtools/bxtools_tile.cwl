cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bxtools
  - tile
label: bxtools_tile
doc: "Gather BX counts on tiled ranges\n\nTool homepage: https://github.com/walaj/bxtools"
inputs:
  - id: input_file
    type: File
    doc: Input BAM/SAM/CRAM file
    inputBinding:
      position: 1
  - id: bed_regions
    type:
      - 'null'
      - File
    doc: Rather than tile genome, input BED with regions
    inputBinding:
      position: 102
      prefix: --bed
  - id: overlap
    type:
      - 'null'
      - int
    doc: Overlap of the tiles
    inputBinding:
      position: 102
      prefix: --overlap
  - id: tag
    type:
      - 'null'
      - string
    doc: Tag other than BX to evaluate (e.g. MI)
    inputBinding:
      position: 102
      prefix: --tag
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Set verbose output
    inputBinding:
      position: 102
      prefix: --verbose
  - id: width
    type:
      - 'null'
      - int
    doc: Width of the tile
    inputBinding:
      position: 102
      prefix: --width
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bxtools:0.1.0--h13024bc_6
stdout: bxtools_tile.out
