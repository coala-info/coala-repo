cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ppanggolin
  - metadata
label: ppanggolin_metadata
doc: "PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM
  team, and distributed under the CeCILL Free Software License Agreement.\n\nTool
  homepage: https://github.com/labgem/PPanGGOLiN"
inputs:
  - id: assign
    type: string
    doc: Select to which pangenome element metadata will be assigned
    inputBinding:
      position: 101
      prefix: --assign
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
  - id: metadata
    type: File
    doc: Metadata in TSV file. See our github for more detail about format
    inputBinding:
      position: 101
      prefix: --metadata
  - id: omit
    type:
      - 'null'
      - boolean
    doc: Allow to pass if a key in metadata is not find in pangenome
    inputBinding:
      position: 101
      prefix: --omit
  - id: pangenome
    type: File
    doc: The pangenome .h5 file
    inputBinding:
      position: 101
      prefix: --pangenome
  - id: source
    type: string
    doc: Name of the metadata source
    inputBinding:
      position: 101
      prefix: --source
  - id: verbose
    type:
      - 'null'
      - int
    doc: Indicate verbose level (0 for warning and errors only, 1 for info, 2 
      for debug)
    default: 0
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
stdout: ppanggolin_metadata.out
