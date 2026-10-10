cwlVersion: v1.2
class: CommandLineTool
baseCommand: duplicate_finder.py
label: mindagap_duplicate_finder.py
doc: "Takes a single XYZ_coordinates.txt file and searches for duplicates along grid
  happening at every 2144 pixels. The input table is written beside the input as
  <name>_markedDups.txt, with duplicates named Duplicated in the gene column. The
  five numeric arguments are positional: to set one, give all the ones before it.\n\nTool
  homepage: https://github.com/ViriatoII/MindaGap"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.input.basename)
        entry: $(inputs.input)
        writable: true
  - class: InlineJavascriptRequirement
inputs:
  - id: input
    type: File
    doc: Input gene xyz coordinates file (tab-separated x, y, z, gene, no header)
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: xtilesize
    type:
      - 'null'
      - int
    doc: Tile size (distance between gridlines) on X axis. Default 2144.
    inputBinding:
      position: 2
  - id: ytilesize
    type:
      - 'null'
      - int
    doc: Tile size (distance between gridlines) on Y axis. Default is the X tile
      size.
    inputBinding:
      position: 3
  - id: windowsize
    type:
      - 'null'
      - int
    doc: Window arround gridlines to search for duplicates. Default 30.
    inputBinding:
      position: 4
  - id: maxfreq
    type:
      - 'null'
      - int
    doc: Maximum transcript count to calculate X/Y shifts (better to discard 
      very common genes). Default 400.
    inputBinding:
      position: 5
  - id: minmode
    type:
      - 'null'
      - int
    doc: Minumum occurances of ~XYZ_shift to consider it valid. Default 10.
    inputBinding:
      position: 6
  - id: plot
    type:
      - 'null'
      - string
    doc: Illustrative lineplot of duplicated pairs with annotated XYZ shift per 
      tileOvlap. Any text turns the plot on; the plot is written to
      XYZshift_visualization.png.
    inputBinding:
      position: 107
      prefix: --plot
outputs:
  - id: marked_dups
    type: File
    doc: Input table with duplicates marked in the gene column
    outputBinding:
      glob: '*_markedDups.txt'
  - id: plot_png
    type:
      - 'null'
      - File
    doc: Plot of duplicated pairs
    outputBinding:
      glob: XYZshift_visualization.png
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mindagap:0.0.2--pyhdfd78af_1
stdout: mindagap_duplicate_finder.py.out
