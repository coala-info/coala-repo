cwlVersion: v1.2
class: CommandLineTool
baseCommand: mzmine
label: mzmine
doc: "MZmine is a modular software for analyzing mass spectrometry data.\n\nTool homepage:
  http://mzmine.github.io/"
inputs:
  - id: batch
    type:
      - 'null'
      - File
    doc: Path to a batch processing configuration file
    inputBinding:
      position: 101
      prefix: --batch
  - id: config_file
    type:
      - 'null'
      - File
    doc: Path to a configuration file
    inputBinding:
      position: 101
      prefix: --config
  - id: export_format
    type:
      - 'null'
      - string
    doc: Format for exporting results (e.g., CSV, mzTab)
    inputBinding:
      position: 101
      prefix: --export-format
  - id: import_data
    type:
      - 'null'
      - File
    doc: Path to a data file to import
    inputBinding:
      position: 101
      prefix: --import-data
  - id: no_gui
    type:
      - 'null'
      - boolean
    doc: Run MZmine without the graphical user interface
    inputBinding:
      position: 101
      prefix: --no-gui
  - id: plugin_path
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Path to a directory containing MZmine plugins
    inputBinding:
      position: 101
      prefix: --plugin-path
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: Path to a temporary directory
    inputBinding:
      position: 101
      prefix: --temp-dir
outputs:
  - id: log_file
    type:
      - 'null'
      - File
    doc: Path to a log file
    outputBinding:
      glob: $(inputs.log_file)
  - id: export_results
    type:
      - 'null'
      - File
    doc: Path to export results to
    outputBinding:
      glob: $(inputs.export_results)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mzmine:4.7.29--hdfd78af_0
