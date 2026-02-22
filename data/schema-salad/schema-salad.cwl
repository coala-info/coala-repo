cwlVersion: v1.2
class: CommandLineTool
baseCommand: schema-salad
label: schema-salad
doc: "Schema Annotations for Linked Avro Data (Salad)\n\nTool homepage: https://github.com/common-workflow-language/schema_salad"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/schema-salad:v3.0.20181206233650-2-deb-py3_cv1
stdout: schema-salad.out
