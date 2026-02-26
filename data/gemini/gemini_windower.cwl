cwlVersion: v1.2
class: CommandLineTool
baseCommand: gemini windower
label: gemini_windower
doc: "Window a database for analysis.\n\nTool homepage: https://github.com/arq5x/gemini"
inputs:
  - id: db
    type: string
    doc: The name of the database to be updated.
    inputBinding:
      position: 1
  - id: analysis_type
    type:
      - 'null'
      - string
    doc: The type of windowed analysis requested.
    inputBinding:
      position: 102
      prefix: -t
  - id: operation
    type:
      - 'null'
      - string
    doc: The operation that should be applied to the -t values.
    inputBinding:
      position: 102
      prefix: -o
  - id: step_size
    type:
      - 'null'
      - string
    doc: The step size for the windows in bp.
    inputBinding:
      position: 102
      prefix: -s
  - id: window_size
    type:
      - 'null'
      - string
    doc: The name of the column to be added to the variant table.
    inputBinding:
      position: 102
      prefix: -w
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
stdout: gemini_windower.out
