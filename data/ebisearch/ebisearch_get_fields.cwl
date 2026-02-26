cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ebisearch
  - get_fields
label: ebisearch_get_fields
doc: "Get specific fields from EBI Search\n\nTool homepage: https://github.com/ebi-wp/EBISearch-webservice-clients"
inputs:
  - id: domain
    type: string
    doc: The domain to query
    inputBinding:
      position: 1
  - id: field_type
    type: string
    doc: The type of field to extract ('searchable', 'retrievable', 'sortable', 
      'facet', or 'topterms')
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ebisearch:0.0.3--py27_1
stdout: ebisearch_get_fields.out
