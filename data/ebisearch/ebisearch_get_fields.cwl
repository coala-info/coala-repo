cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ebisearch
  - get_fields
label: ebisearch_get_fields
doc: "Return the list of fields of a type for a specific domain in EBI\n\nTool homepage: https://github.com/ebi-wp/EBISearch-webservice-clients"
inputs:
  - id: domain
    type: string
    doc: Domain id in EBI (accessible with get_domains)
    inputBinding:
      position: 101
      prefix: --domain
  - id: field_type
    type:
      type: enum
      symbols:
        - searchable
        - retrievable
        - sortable
        - facet
        - topterms
    doc: Type of field
    inputBinding:
      position: 101
      prefix: --field_type
  - id: file_path
    type:
      - 'null'
      - string
    doc: (Optional) File to export the domain information
    inputBinding:
      position: 102
      prefix: --file
outputs:
  - id: file
    type:
      - 'null'
      - File
    doc: Exported field list
    outputBinding:
      glob: $(inputs.file_path)
  - id: stdout
    type: stdout
    doc: Field list printed to standard output
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ebisearch:0.0.3--py27_1
stdout: ebisearch_get_fields.out
