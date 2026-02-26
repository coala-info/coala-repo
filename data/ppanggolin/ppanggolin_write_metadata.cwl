cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ppanggolin
  - write_metadata
label: ppanggolin_write_metadata
doc: "Write metadata for pangenome elements.\n\nTool homepage: https://github.com/labgem/PPanGGOLiN"
inputs:
  - id: compress
    type:
      - 'null'
      - boolean
    doc: Compress the files in .gz
    inputBinding:
      position: 101
      prefix: --compress
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
  - id: metadata_sources
    type:
      - 'null'
      - type: array
        items: string
    doc: Which source of metadata should be written. By default all metadata 
      sources are included.
    inputBinding:
      position: 101
      prefix: --metadata_sources
  - id: pangenome
    type: File
    doc: The pangenome .h5 file
    inputBinding:
      position: 101
      prefix: --pangenome
  - id: pangenome_elements
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify pangenome elements for which to write metadata. default is all 
      element with metadata.
    inputBinding:
      position: 101
      prefix: --pangenome_elements
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
    type: Directory
    doc: Output directory where the file(s) will be written
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
