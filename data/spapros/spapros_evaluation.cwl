cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - spapros
label: spapros_evaluation
doc: "Evaluate probesets for an h5ad file: runs the Spapros evaluation metrics for the probesets in a probeset file.\n\nTool homepage: https://github.com/theislab/spapros"
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
    doc: "Path to the h5ad dataset file"
    inputBinding:
      position: 20
  - id: probeset
    type: File
    doc: "Path to the probeset file (csv, one column per probeset id)"
    inputBinding:
      position: 21
  - id: marker_file
    type: File
    doc: "Path to the marker file"
    inputBinding:
      position: 22
  - id: probeset_ids
    type:
      - 'null'
      - type: array
        items: string
    doc: "Several probeset ids (default: all probesets in the probeset file)"
    inputBinding:
      position: 40
  - id: parameters
    type:
      - 'null'
      - File
    doc: "Path to a yaml file containing parameters"
    inputBinding:
      position: 30
      prefix: --parameters
  - id: output
    type: string
    doc: "Output path (use a trailing slash, e.g. results/) [default: ./results/]"
    inputBinding:
      position: 31
      prefix: --output
outputs:
  - id: results
    type: Directory
    doc: Output directory with the evaluation results
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
    valueFrom: evaluation
