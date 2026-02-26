cwlVersion: v1.2
class: CommandLineTool
baseCommand: avro
label: avro
doc: "Avro command-line interface. This script is used to generate Java classes from
  Avro schema files.\n\nTool homepage: https://github.com/apache/avro"
inputs:
  - id: schema_file
    type: File
    doc: Path to the Avro schema file
    inputBinding:
      position: 1
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory to write generated Java classes to
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: template_dir
    type:
      - 'null'
      - Directory
    doc: Directory containing custom FreeMarker templates
    inputBinding:
      position: 102
      prefix: --template-dir
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/avro:1.8.0--py35_0
stdout: avro.out
