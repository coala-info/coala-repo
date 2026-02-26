cwlVersion: v1.2
class: CommandLineTool
baseCommand: ggd search
label: ggd_search
doc: "Search for available ggd data packages. Results are filtered by match score
  from high to low. (Only 5 results will be reported unless the -dn flag is changed)\n\
  \nTool homepage: https://github.com/gogetdata/ggd-cli"
inputs:
  - id: search_term
    type:
      type: array
      items: string
    doc: "**Required** The term(s) to search for. Multiple terms can be used. Example:
      'ggd search reference genome'"
    inputBinding:
      position: 1
  - id: channel
    type:
      - 'null'
      - string
    doc: (Optional) The ggd channel to search. (Default = genomics)
    default: genomics
    inputBinding:
      position: 102
      prefix: --channel
  - id: display_number
    type:
      - 'null'
      - int
    doc: (Optional) The number of search results to display. (Default = 5)
    default: 5
    inputBinding:
      position: 102
      prefix: --display-number
  - id: genome_build
    type:
      - 'null'
      - string
    doc: (Optional) Filter results by the genome build of the desired recipe
    inputBinding:
      position: 102
      prefix: --genome-build
  - id: match_score
    type:
      - 'null'
      - int
    doc: (Optional) A score between 0 and 100 to use to filter the results by. 
      (Default = 90). The lower the number the more results will be output
    default: 90
    inputBinding:
      position: 102
      prefix: --match-score
  - id: search_type
    type:
      - 'null'
      - string
    doc: (Optional) How to search for data packages with the search terms 
      provided. Options = 'combined-only', 'non-combined-only', and 'both'. 
      'combined-only' will use the provided search terms as a single search 
      term. 'non-combined-only' will use the provided search term to search for 
      data package that match each search term separately. 'both' will use the 
      search terms combined and each search term separately to search for data 
      packages. Default = 'both'
    default: both
    inputBinding:
      position: 102
      prefix: --search-type
  - id: species
    type:
      - 'null'
      - string
    doc: (Optional) Filter results by the species for the desired recipe
    inputBinding:
      position: 102
      prefix: --species
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ggd:1.1.3--pyh3252c3a_0
stdout: ggd_search.out
