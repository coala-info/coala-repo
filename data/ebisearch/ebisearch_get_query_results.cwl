cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ebisearch
  - get_query_results
label: ebisearch_get_query_results
doc: "Return the all the results for a query on a specific domain in EBI\n\nTool homepage:
  https://github.com/ebi-wp/EBISearch-webservice-clients"
inputs:
  - id: domain
    type:
      - 'null'
      - string
    doc: Domain id in EBI (accessible with get_domains) (accessible with 
      get_domains)
    inputBinding:
      position: 101
      prefix: --domain
  - id: facet_count
    type:
      - 'null'
      - int
    doc: (Optional) Number of facet values to retrieve
    inputBinding:
      position: 101
      prefix: --facet_count
  - id: facet_depth
    type:
      - 'null'
      - int
    doc: (Optional) Number of levels in the facet hierarchy to retrieve
    inputBinding:
      position: 101
      prefix: --facet_depth
  - id: facet_fields
    type:
      - 'null'
      - type: array
        items: string
    doc: (Optional, Multiple) Facet field identifiers associated with facets to 
      retrieve (facet_id accessible with get_fields with facet as type)
    inputBinding:
      position: 101
      prefix: --facet_fields
  - id: facets
    type:
      - 'null'
      - type: array
        items: string
    doc: (Optional, Multiple) Facet selections to apply on search results with 
      facet_id:facet_value (facet_id accessible with get_fields with facet as 
      type)
    inputBinding:
      position: 101
      prefix: --facets
  - id: field
    type:
      - 'null'
      - type: array
        items: string
    doc: (Multiple) Field to export (accessible with get_fields with retrievable
      as type)
    inputBinding:
      position: 101
      prefix: --field
  - id: field_url
    type:
      - 'null'
      - boolean
    doc: Include the field links
    inputBinding:
      position: 101
      prefix: --field_url
  - id: order
    type:
      - 'null'
      - string
    doc: (Optional) Order to sort the results (optional), should come along with
      "sortfield" and not allowed to use with "sort" parameters
    inputBinding:
      position: 101
      prefix: --order
  - id: query
    type:
      - 'null'
      - string
    doc: Query (searchable fields accessible with get_fields with searchable as 
      type)
    inputBinding:
      position: 101
      prefix: --query
  - id: sort
    type:
      - 'null'
      - type: array
        items: string
    doc: (Optional, Multiple) Sorting criteria with field_id:order (field_id 
      accessible with get_fields with retrievable as type), should not be used 
      in conjunction with any of "sortfield" and "order" parameters
    inputBinding:
      position: 101
      prefix: --sort
  - id: sort_field
    type:
      - 'null'
      - string
    doc: (Optional) Field to sort on (accessible via get_fields with sortable as
      option), should come along with "sortfield"
    inputBinding:
      position: 101
      prefix: --sort_field
  - id: view_url
    type:
      - 'null'
      - boolean
    doc: Include other view links
    inputBinding:
      position: 101
      prefix: --view_url
outputs:
  - id: file
    type:
      - 'null'
      - File
    doc: (Optional) File to export the entry content
    outputBinding:
      glob: $(inputs.file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ebisearch:0.0.3--py27_1
