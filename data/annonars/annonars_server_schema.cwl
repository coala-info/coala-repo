cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- annonars
- server
- schema
label: annonars_server_schema
doc: 'Dump the schema of the annonars REST API server (OpenAPI YAML).


  Tool homepage: https://github.com/bihealth/annona-rs'
inputs:
- id: output_file
  type:
  - 'null'
  - string
  default: annonars_schema.yaml
  doc: Path to the output file. Use stdout if missing
  inputBinding:
    position: 1
    prefix: --output-file
- id: verbose
  type:
  - 'null'
  - boolean
  doc: Increase logging verbosity
  inputBinding:
    position: 1
    prefix: --verbose
- id: quiet
  type:
  - 'null'
  - boolean
  doc: Decrease logging verbosity
  inputBinding:
    position: 1
    prefix: --quiet
outputs:
- id: schema
  type: File
  doc: REST API schema (OpenAPI YAML)
  outputBinding:
    glob: $(inputs.output_file)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/annonars:0.44.1--h13c227e_0
