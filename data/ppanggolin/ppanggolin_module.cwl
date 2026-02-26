cwlVersion: v1.2
class: CommandLineTool
baseCommand: ppanggolin module
label: ppanggolin_module
doc: "PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM
  team, and distributed under the CeCILL Free Software License Agreement.\n\nTool
  homepage: https://github.com/labgem/PPanGGOLiN"
inputs:
  - id: config
    type:
      - 'null'
      - File
    doc: Specify command arguments through a YAML configuration file.
    inputBinding:
      position: 101
      prefix: --config
  - id: cpu
    type:
      - 'null'
      - int
    doc: Number of available cpus
    inputBinding:
      position: 101
      prefix: --cpu
  - id: disable_prog_bar
    type:
      - 'null'
      - boolean
    doc: disables the progress bars
    inputBinding:
      position: 101
      prefix: --disable_prog_bar
  - id: dup_margin
    type:
      - 'null'
      - float
    doc: minimum ratio of genomes in which the family must have multiple genes 
      for it to be considered 'duplicated'
    inputBinding:
      position: 101
      prefix: --dup_margin
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force writing in output directory and in pangenome output file.
    inputBinding:
      position: 101
      prefix: --force
  - id: jaccard
    type:
      - 'null'
      - float
    doc: minimum jaccard similarity used to filter edges between gene families. 
      Increasing it will improve precision but lower sensitivity a lot.
    inputBinding:
      position: 101
      prefix: --jaccard
  - id: log
    type:
      - 'null'
      - File
    doc: log output file
    inputBinding:
      position: 101
      prefix: --log
  - id: min_presence
    type:
      - 'null'
      - int
    doc: Minimum number of times the module needs to be present in the pangenome
      to be reported. Increasing it will improve precision but lower 
      sensitivity.
    inputBinding:
      position: 101
      prefix: --min_presence
  - id: pangenome
    type: File
    doc: The pangenome .h5 file
    inputBinding:
      position: 101
      prefix: --pangenome
  - id: size
    type:
      - 'null'
      - int
    doc: Minimal number of gene family in a module
    inputBinding:
      position: 101
      prefix: --size
  - id: transitive
    type:
      - 'null'
      - int
    doc: Size of the transitive closure used to build the graph. This indicates 
      the number of non related genes allowed in-between two related genes. 
      Increasing it will improve precision but lower sensitivity a little.
    inputBinding:
      position: 101
      prefix: --transitive
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
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
stdout: ppanggolin_module.out
