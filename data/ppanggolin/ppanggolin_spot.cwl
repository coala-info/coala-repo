cwlVersion: v1.2
class: CommandLineTool
baseCommand: ppanggolin spot
label: ppanggolin_spot
doc: "PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM
  team, and distributed under the CeCILL Free Software License Agreement.\n\nFor genomic
  islands and spots of insertion detection, please cite:\nBazin A et al. (2020) panRGP:
  a pangenome-based method to predict genomic islands and explore their diversity.\n\
  Bioinformatics, Volume 36, Issue Supplement_2, Pages i651–i658, https://doi.org/10.1093/bioinformatics/btaa792\n\
  \nTool homepage: https://github.com/labgem/PPanGGOLiN"
inputs:
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
  - id: exact_match_size
    type:
      - 'null'
      - int
    doc: 'Number of perfectly matching flanking single copy markers required to associate
      RGPs during hotspot computation (Ex: If set to 1, two RGPs are in the same hotspot
      if both their 1st flanking genes are the same)'
    inputBinding:
      position: 101
      prefix: --exact_match_size
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force writing in output directory and in pangenome output file.
    inputBinding:
      position: 101
      prefix: --force
  - id: graph_formats
    type:
      - 'null'
      - type: array
        items: string
    doc: Format of the output graph.
    inputBinding:
      position: 101
      prefix: --graph_formats
  - id: log
    type:
      - 'null'
      - File
    doc: log output file
    inputBinding:
      position: 101
      prefix: --log
  - id: overlapping_match
    type:
      - 'null'
      - int
    doc: The number of 'missing' persistent genes allowed when comparing 
      flanking genes during hotspot computations
    inputBinding:
      position: 101
      prefix: --overlapping_match
  - id: pangenome
    type: File
    doc: The pangenome .h5 file
    inputBinding:
      position: 101
      prefix: --pangenome
  - id: set_size
    type:
      - 'null'
      - int
    doc: Number of single copy markers to use as flanking genes for a RGP during
      hotspot computation
    inputBinding:
      position: 101
      prefix: --set_size
  - id: spot_graph
    type:
      - 'null'
      - boolean
    doc: Writes a graph of pairs of blocks of single copy markers flanking RGPs,
      supposedly belonging to the same hotspot
    inputBinding:
      position: 101
      prefix: --spot_graph
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
