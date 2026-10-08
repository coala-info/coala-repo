cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ebisearch
  - get_entries
label: ebisearch_get_entries
doc: "Return content of entries on a specific domain in EBI\n\nTool homepage: https://github.com/ebi-wp/EBISearch-webservice-clients"
inputs:
  - id: domain
    type: string
    doc: Domain id in EBI (accessible with get_domains)
    inputBinding:
      position: 101
      prefix: --domain
  - id: entry_id
    type:
      type: array
      items: string
      inputBinding:
        prefix: --entry_id
    doc: (Multiple) Entry identifier to retrieve
    inputBinding:
      position: 101
  - id: field
    type:
      type: array
      items: string
      inputBinding:
        prefix: --field
    doc: (Multiple) Field to export (accessible with get_fields with retrievable
      as type)
    inputBinding:
      position: 101
  - id: field_url
    type:
      - 'null'
      - boolean
    doc: Include the field links
    inputBinding:
      position: 101
      prefix: --field_url
  - id: view_url
    type:
      - 'null'
      - boolean
    doc: Include other view links
    inputBinding:
      position: 101
      prefix: --view_url
  - id: file_path
    type:
      - 'null'
      - string
    doc: (Optional) File to export the entry content
    inputBinding:
      position: 102
      prefix: --file
outputs:
  - id: file
    type:
      - 'null'
      - File
    doc: Exported entry content
    outputBinding:
      glob: $(inputs.file_path)
  - id: stdout
    type: stdout
    doc: Entry content printed to standard output
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ebisearch:0.0.3--py27_1
stdout: ebisearch_get_entries.out
