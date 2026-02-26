cwlVersion: v1.2
class: CommandLineTool
baseCommand: ppanggolin metrics
label: ppanggolin_metrics
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
  - id: disable_prog_bar
    type:
      - 'null'
      - boolean
    doc: disables the progress bars
    inputBinding:
      position: 101
      prefix: --disable_prog_bar
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force writing in output directory and in pangenome output file.
    inputBinding:
      position: 101
      prefix: --force
  - id: genome_fluidity
    type:
      - 'null'
      - boolean
    doc: Compute the pangenome genomic fluidity.
    inputBinding:
      position: 101
      prefix: --genome_fluidity
  - id: log
    type:
      - 'null'
      - File
    doc: log output file
    inputBinding:
      position: 101
      prefix: --log
  - id: no_print_info
    type:
      - 'null'
      - boolean
    doc: Suppress printing the metrics result. Metrics are saved in the 
      pangenome and viewable using 'ppanggolin info'.
    inputBinding:
      position: 101
      prefix: --no_print_info
  - id: pangenome
    type: File
    doc: Path to the pangenome .h5 file
    inputBinding:
      position: 101
      prefix: --pangenome
  - id: recompute_metrics
    type:
      - 'null'
      - boolean
    doc: Force re-computation of metrics if already computed.
    inputBinding:
      position: 101
      prefix: --recompute_metrics
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
stdout: ppanggolin_metrics.out
