cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxburst
label: taxburst
doc: "Visualize taxonomic assignments from sourmash csv_summary files.\n\nTool homepage:
  https://github.com/taxburst/taxburst"
inputs:
  - id: tax_csv
    type: File
    doc: input tax CSV, in sourmash csv_summary format
    inputBinding:
      position: 1
  - id: check_tree
    type:
      - 'null'
      - boolean
    doc: check that tree makes sense
    inputBinding:
      position: 102
      prefix: --check-tree
  - id: fail_on_error
    type:
      - 'null'
      - boolean
    doc: fail if tree doesn't pass checks; implies --check-tree
    inputBinding:
      position: 102
      prefix: --fail-on-error
  - id: input_format
    type:
      - 'null'
      - string
    doc: 'Input format for the tax CSV file. Supported formats are: csv_summary, tax_annotate,
      SingleM, krona, json.'
    inputBinding:
      position: 102
      prefix: --input-format
outputs:
  - id: output_html
    type:
      - 'null'
      - File
    doc: output HTML file to this location.
    outputBinding:
      glob: $(inputs.output_html)
  - id: save_json
    type:
      - 'null'
      - File
    doc: output a JSON file of the taxonomy
    outputBinding:
      glob: $(inputs.save_json)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxburst:0.3.2--pyhdfd78af_0
