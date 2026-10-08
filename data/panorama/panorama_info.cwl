cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - panorama
  - info
label: panorama_info
doc: "Extract status, content, parameters, and metadata information from pangenome\
  \ HDF5 files and export as interactive HTML reports.\n\nTool homepage: https://github.com/labgem/panorama"
inputs:
  - id: content
    type:
      - 'null'
      - boolean
    doc: Extract and export content information including gene family statistics,
      core/accessory genome metrics, and module information
    inputBinding:
      position: 101
      prefix: --content
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
      - string
    doc: Log output file name
    inputBinding:
      position: 101
      prefix: --log
  - id: pangenomes
    type: File
    doc: Path to a TSV file listing pangenome .h5 files with their names and paths
    inputBinding:
      position: 101
      prefix: --pangenomes
  - id: pangenome_files
    type:
      type: array
      items: File
    doc: Pangenome .h5 files named in the pangenomes list. They are staged in the
      working directory, so the list must name them by file name (second column).
  - id: status
    type:
      - 'null'
      - boolean
    doc: Extract and export status information showing completion status of different
      analysis steps for each pangenome
    inputBinding:
      position: 101
      prefix: --status
  - id: verbose
    type:
      - 'null'
      - int
    doc: Indicate verbose level (0 for warning and errors only, 1 for info, 2 for
      debug)
    inputBinding:
      position: 101
      prefix: --verbose
  - id: output_path
    type: string
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: Directory
    doc: Output directory where HTML reports will be saved
    outputBinding:
      glob: $(inputs.output_path)
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file (with log)
    outputBinding:
      glob: $(inputs.log)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.pangenome_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panorama:1.0.0--pyhdfd78af_0
