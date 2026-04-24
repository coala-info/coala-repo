cwlVersion: v1.2
class: CommandLineTool
baseCommand: panorama_info
label: panorama_info
doc: "Extract status, content, parameters, and metadata information from pangenome
  HDF5 files and export as interactive HTML reports.\n\nTool homepage: https://github.com/labgem/panorama"
inputs:
  - id: content
    type:
      - 'null'
      - boolean
    doc: Extract and export content information including gene family 
      statistics, core/accessory genome metrics, and module information
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
      - File
    doc: log output file
    inputBinding:
      position: 101
      prefix: --log
  - id: pangenomes
    type: File
    doc: Path to a TSV file listing pangenome .h5 files with their names and 
      paths
    inputBinding:
      position: 101
      prefix: --pangenomes
  - id: status
    type:
      - 'null'
      - boolean
    doc: Extract and export status information showing completion status of 
      different analysis steps for each pangenome
    inputBinding:
      position: 101
      prefix: --status
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
    doc: Output directory where HTML reports will be saved
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panorama:1.0.0--pyhdfd78af_0
