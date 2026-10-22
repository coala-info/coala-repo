cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - spapros
label: spapros_selection
doc: "Create a selection of probesets for an h5ad file.\n\nTool homepage: https://github.com/theislab/spapros"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Enable verbose output (print debug statements)."
    inputBinding:
      position: 1
      prefix: --verbose
  - id: log_file
    type:
      - 'null'
      - string
    doc: "Save a verbose log to a file."
    inputBinding:
      position: 1
      prefix: --log-file
  - id: data
    type: File
    doc: "Path to the h5ad file"
    inputBinding:
      position: 20
  - id: output
    type: string
    doc: "Output path of the selection results (use a trailing slash, e.g. results/) [default: ./results/]"
    inputBinding:
      position: 30
      prefix: --output
outputs:
  - id: results
    type: Directory
    doc: Output directory with the selection results
    outputBinding:
      glob: $(inputs.output)
  - id: log_output
    type:
      - 'null'
      - File
    doc: Log file written with --log-file
    outputBinding:
      glob: $(inputs.log_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spapros:0.1.6--pyhdfd78af_0
arguments:
  - position: 10
    valueFrom: selection
