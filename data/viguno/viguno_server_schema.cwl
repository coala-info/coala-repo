cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - viguno
  - server
  - schema
label: viguno_server_schema
doc: "Dump the schema\n\nTool homepage: https://github.com/bihealth/viguno"
inputs:
  - id: output_file
    type:
      - 'null'
      - string
    doc: Path to the output file. Use stdout if missing
    inputBinding:
      position: 101
      prefix: --output-file
  - id: quiet
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Decrease logging verbosity
    inputBinding:
      position: 101
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Increase logging verbosity
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: schema_file
    type:
      - 'null'
      - File
    doc: Schema file written when output_file is given
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viguno:0.4.0--h13c227e_0
stdout: viguno_server_schema.out
