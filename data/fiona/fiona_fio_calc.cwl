cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fio
  - calc
label: fiona_fio_calc
doc: "Create a new property on GeoJSON features using the specified expression. The expression is evaluated for each feature and its return value is added to the properties as the specified property name.\n\nTool homepage: https://github.com/Toblerity/Fiona"
inputs:
  - id: features
    type: File
    doc: GeoJSON features read from stdin
  - id: property_name
    type: string
    doc: Name of the new property
    inputBinding:
      position: 1
  - id: expression
    type: string
    doc: Python expression evaluated for each feature (the feature is f)
    inputBinding:
      position: 2
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: "Overwrite properties, default: False"
    inputBinding:
      position: 102
      prefix: --overwrite
  - id: rs
    type:
      - 'null'
      - boolean
    doc: Use RS (0x1E) as a prefix for individual texts in a sequence (default is False).
    inputBinding:
      position: 102
      prefix: --rs
  - id: no_rs
    type:
      - 'null'
      - boolean
    doc: Do not use RS (0x1E) as a prefix for individual texts in a sequence.
    inputBinding:
      position: 102
      prefix: --no-rs
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fiona:1.8.6
stdin: $(inputs.features.path)
stdout: fiona_fio_calc.out
