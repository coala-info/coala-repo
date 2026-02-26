cwlVersion: v1.2
class: CommandLineTool
baseCommand: ebisearch_get_entries
label: ebisearch_get_entries
doc: "Get entries from EBI Search\n\nTool homepage: https://github.com/ebi-wp/EBISearch-webservice-clients"
inputs:
  - id: domain
    type: string
    doc: The domain to search within
    inputBinding:
      position: 1
  - id: fields
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma-separated list of fields to retrieve
    inputBinding:
      position: 102
      prefix: --fields
  - id: order
    type:
      - 'null'
      - string
    doc: Sort order (asc or desc)
    inputBinding:
      position: 102
      prefix: --order
  - id: query
    type:
      - 'null'
      - string
    doc: Search query
    inputBinding:
      position: 102
      prefix: --query
  - id: size
    type:
      - 'null'
      - int
    doc: Number of results to retrieve
    inputBinding:
      position: 102
      prefix: --size
  - id: sort
    type:
      - 'null'
      - string
    doc: Field to sort by
    inputBinding:
      position: 102
      prefix: --sort
  - id: start
    type:
      - 'null'
      - int
    doc: Start index for results (0-based)
    inputBinding:
      position: 102
      prefix: --start
  - id: view_url
    type:
      - 'null'
      - string
    doc: URL for viewing entries
    inputBinding:
      position: 102
      prefix: --viewurl
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ebisearch:0.0.3--py27_1
stdout: ebisearch_get_entries.out
