cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ppanggolin
  - graph
label: ppanggolin_graph
doc: 'PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM
  team, and distributed under the CeCILL Free Software License Agreement.


  Tool homepage: https://github.com/labgem/PPanGGOLiN'
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
  - id: log
    type:
      - 'null'
      - File
    doc: log output file
    inputBinding:
      position: 101
      prefix: --log
  - id: pangenome
    type: File
    doc: The pangenome .h5 file The file is staged writable because ppanggolin opens
      it for writing.
    inputBinding:
      position: 101
      prefix: --pangenome
      valueFrom: $(self.basename)
  - id: remove_high_copy_number
    type:
      - 'null'
      - float
    doc: 'Positive Number: Remove families having a number of copy of gene in a single
      genome above or equal to this threshold in at least one genome (0 or negative
      values are ignored).'
    inputBinding:
      position: 101
      prefix: --remove_high_copy_number
  - id: verbose
    type:
      - 'null'
      - int
    doc: Indicate verbose level (0 for warning and errors only, 1 for info, 2 for
      debug)
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: pangenome_out
    type: File
    doc: The pangenome HDF5 file after the step.
    outputBinding:
      glob: $(inputs.pangenome.basename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
stdout: ppanggolin_graph.out
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.pangenome)
        writable: true
