cwlVersion: v1.2
class: CommandLineTool
baseCommand: duplicate_finder.py
label: mindagap_duplicate_finder.py
doc: "Takes a single XYZ_coordinates.txt file and searches for duplicates along grid
  happening at every 2144 pixels\n\nTool homepage: https://github.com/ViriatoII/MindaGap"
inputs:
  - id: input
    type: File
    doc: Input gene xyz coordinates file
    inputBinding:
      position: 1
  - id: xtilesize
    type: int
    doc: Tile size (distance between gridlines) on X axis
    inputBinding:
      position: 2
  - id: ytilesize
    type: int
    doc: Tile size (distance between gridlines) on Y axis
    inputBinding:
      position: 3
  - id: windowsize
    type: int
    doc: Window arround gridlines to search for duplicates
    inputBinding:
      position: 4
  - id: maxfreq
    type: int
    doc: Maximum transcript count to calculate X/Y shifts (better to discard 
      very common genes)
    inputBinding:
      position: 5
  - id: minmode
    type: int
    doc: Minumum occurances of ~XYZ_shift to consider it valid
    inputBinding:
      position: 6
  - id: plot
    type:
      - 'null'
      - string
    doc: Illustrative lineplot of duplicated pairs with annotated XYZ shift per 
      tileOvlap
    inputBinding:
      position: 107
      prefix: --plot
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mindagap:0.0.2--pyhdfd78af_1
stdout: mindagap_duplicate_finder.py.out
