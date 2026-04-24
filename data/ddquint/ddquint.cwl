cwlVersion: v1.2
class: CommandLineTool
baseCommand: ddquint
label: ddquint
doc: "ddQuint: Digital Droplet PCR Multiplex Analysis\n\nTool homepage: https://github.com/globuzzz2000/ddQuint"
inputs:
  - id: batch
    type:
      - 'null'
      - boolean
    doc: Process multiple directories (allows selection of multiple folders)
    inputBinding:
      position: 101
      prefix: --batch
  - id: config
    type:
      - 'null'
      - string
    doc: Configuration file or command (display, template, or path to config 
      file)
    inputBinding:
      position: 101
      prefix: --config
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable debug mode with detailed logging
    inputBinding:
      position: 101
      prefix: --debug
  - id: directory
    type:
      - 'null'
      - Directory
    doc: Directory containing CSV files to process
    inputBinding:
      position: 101
      prefix: --dir
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory for results (defaults to input directory)
    inputBinding:
      position: 101
      prefix: --output
  - id: parameters
    type:
      - 'null'
      - boolean
    doc: Open parameter editor GUI for EXPECTED_CENTROIDS and HDBSCAN settings
    inputBinding:
      position: 101
      prefix: --parameters
  - id: qx_template
    type:
      - 'null'
      - string
    doc: Create a plate template from a sample list (CSV/Excel). Optionally 
      provide a path or use 'prompt' for a GUI selector.
    inputBinding:
      position: 101
      prefix: --QXtemplate
  - id: template
    type:
      - 'null'
      - string
    doc: Template file path for well names, or 'prompt' to select via GUI
    inputBinding:
      position: 101
      prefix: --template
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ddquint:0.1.0--pyhdfd78af_0
stdout: ddquint.out
