cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mtbls
  - public
  - search
label: metabolights-utils_mtbls_public_search
doc: "Search public MetaboLights studies with query keywords.\n\nTool homepage: https://github.com/EBI-Metabolights/metabolights-utils"
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
inputs:
  - id: search_rest_api_url
    type: 
      - 'null'
      - string
    doc: "MetaboLights search API URL."
    inputBinding:
      position: 1
      prefix: --search_rest_api_url
  - id: skip
    type: 
      - 'null'
      - int
    doc: "Skip n items from the matched items."
    inputBinding:
      position: 2
      prefix: --skip
  - id: limit
    type: 
      - 'null'
      - int
    doc: "Maximum number items in response (maximum 100)."
    inputBinding:
      position: 3
      prefix: --limit
  - id: query_join_operator
    type: 
      - 'null'
      - string
    doc: "Join operator for multiple keywords without +/| in the query: and (default) or or."
    inputBinding:
      position: 4
      prefix: --query_join_operator
  - id: body
    type: 
      - 'null'
      - string
    doc: "Advanced filter options in json format."
    inputBinding:
      position: 5
      prefix: --body
  - id: study_ids
    type: 
      - 'null'
      - boolean
    doc: "Shows only MetaboLights accession numbers."
    inputBinding:
      position: 6
      prefix: --study_ids
  - id: raw
    type: 
      - 'null'
      - boolean
    doc: "Shows raw result in json format."
    inputBinding:
      position: 7
      prefix: --raw
  - id: query
    type: 
      - 'null'
      - string
    doc: "Query terms that will be searched, e.g. cancer, (mus musculus)"
    inputBinding:
      position: 20
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabolights-utils:1.4.18--pyhdfd78af_0
stdout: mtbls_public_search.out
