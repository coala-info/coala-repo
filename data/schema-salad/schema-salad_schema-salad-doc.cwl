cwlVersion: v1.2
class: CommandLineTool
baseCommand: schema-salad-doc
label: schema-salad_schema-salad-doc
doc: "Generates documentation from schema-salad schemas.\n\nTool homepage: https://github.com/common-workflow-language/schema_salad"
inputs:
  - id: schema
    type: string
    doc: The schema file to process.
    inputBinding:
      position: 1
  - id: brand
    type:
      - 'null'
      - string
    doc: The brand name to display.
    inputBinding:
      position: 102
      prefix: --brand
  - id: brandlink
    type:
      - 'null'
      - string
    doc: The URL for the brand link.
    inputBinding:
      position: 102
      prefix: --brandlink
  - id: only
    type:
      - 'null'
      - string
    doc: Only include elements matching this pattern.
    inputBinding:
      position: 102
      prefix: --only
  - id: primtype
    type:
      - 'null'
      - string
    doc: Specify a primary type for documentation generation.
    inputBinding:
      position: 102
      prefix: --primtype
  - id: redirect
    type:
      - 'null'
      - string
    doc: Redirect output for a specific element.
    inputBinding:
      position: 102
      prefix: --redirect
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/schema-salad:v3.0.20181206233650-2-deb-py3_cv1
stdout: schema-salad_schema-salad-doc.out
