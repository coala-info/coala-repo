cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - augur
  - measurements
  - concat
label: augur_measurements_concat
doc: "Concatenate multiple measurements JSONs into a single JSON file.\n\nTool homepage:\
  \ https://github.com/nextstrain/augur"
inputs:
  - id: jsons
    type:
      type: array
      items: File
    doc: 'Measurement JSON files to concatenate. (default: None)'
    inputBinding:
      position: 1
      prefix: --jsons
  - id: output_json
    type: string
    doc: 'Output JSON file (default: None)'
    inputBinding:
      position: 1
      prefix: --output-json
  - id: default_collection
    type:
      - 'null'
      - string
    doc: 'The key of the default collection to display. If not provided, the first
      collection of the first JSON file will be displayed (default: None)'
    inputBinding:
      position: 1
      prefix: --default-collection
  - id: minify_json
    type:
      - 'null'
      - boolean
    doc: 'Concatenate JSONs without indentation or line returns. (default: False)'
    inputBinding:
      position: 1
      prefix: --minify-json
outputs:
  - id: output_json_file
    type: File
    doc: Concatenated measurements JSON.
    outputBinding:
      glob: $(inputs.output_json)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
