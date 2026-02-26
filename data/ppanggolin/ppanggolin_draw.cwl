cwlVersion: v1.2
class: CommandLineTool
baseCommand: ppanggolin draw
label: ppanggolin_draw
doc: "PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM
  team, and distributed under the CeCILL Free Software License Agreement.\n\nTool
  homepage: https://github.com/labgem/PPanGGOLiN"
inputs:
  - id: add_dendrogram
    type:
      - 'null'
      - boolean
    doc: Include a dendrogram for genomes in the tile plot based on the 
      presence/absence of gene families.
    inputBinding:
      position: 101
      prefix: --add_dendrogram
  - id: add_metadata
    type:
      - 'null'
      - boolean
    doc: Display gene metadata as hover text for each cell in the tile plot.
    inputBinding:
      position: 101
      prefix: --add_metadata
  - id: config
    type:
      - 'null'
      - File
    doc: Specify command arguments through a YAML configuration file.
    inputBinding:
      position: 101
      prefix: --config
  - id: disable_prog_bar
    type:
      - 'null'
      - boolean
    doc: disables the progress bars
    inputBinding:
      position: 101
      prefix: --disable_prog_bar
  - id: draw_spots
    type:
      - 'null'
      - boolean
    doc: draw plots for spots of the pangenome
    inputBinding:
      position: 101
      prefix: --draw_spots
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force writing in output directory and in pangenome output file.
    inputBinding:
      position: 101
      prefix: --force
  - id: log
    type:
      - 'null'
      - File
    doc: log output file
    inputBinding:
      position: 101
      prefix: --log
  - id: metadata_sources
    type:
      - 'null'
      - type: array
        items: string
    doc: Which source of metadata should be written in the tile plot. By default
      all metadata sources are included.
    inputBinding:
      position: 101
      prefix: --metadata_sources
  - id: nocloud
    type:
      - 'null'
      - boolean
    doc: Do not draw the cloud genes in the tile plot
    inputBinding:
      position: 101
      prefix: --nocloud
  - id: pangenome
    type: File
    doc: The pangenome.h5 file
    inputBinding:
      position: 101
      prefix: --pangenome
  - id: soft_core
    type:
      - 'null'
      - string
    doc: Soft core threshold to use
    inputBinding:
      position: 101
      prefix: --soft_core
  - id: spots
    type:
      - 'null'
      - type: array
        items: string
    doc: a comma-separated list of spots to draw (or 'all' to draw all spots, or
      'synteny' to draw spots with different RGP syntenies).
    inputBinding:
      position: 101
      prefix: --spots
  - id: tile_plot
    type:
      - 'null'
      - boolean
    doc: draw the tile plot of the pangenome
    inputBinding:
      position: 101
      prefix: --tile_plot
  - id: ucurve
    type:
      - 'null'
      - boolean
    doc: draw the U-curve of the pangenome
    inputBinding:
      position: 101
      prefix: --ucurve
  - id: verbose
    type:
      - 'null'
      - int
    doc: Indicate verbose level (0 for warning and errors only, 1 for info, 2 
      for debug)
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
