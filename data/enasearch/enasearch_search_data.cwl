cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - enasearch
  - search_data
label: enasearch_search_data
doc: "Search data given a query.\n\n  This function\n\n  - Extracts the number of
  possible results for the query - Extracts the all\n  the results of the query (by
  potentially running several times the search\n  function)\n\n  The output can be
  redirected to a file and directly display to the\n  standard output given the display
  chosen.\n\nTool homepage: http://bebatut.fr/enasearch/"
inputs:
  - id: display
    type: string
    doc: Display option to specify the display format (accessible with 
      get_display_options)
    inputBinding:
      position: 101
      prefix: --display
  - id: download
    type:
      - 'null'
      - string
    doc: Download option to specify that records are to be saved in a file (used
      with file option, list accessible with get_download_options)
    inputBinding:
      position: 101
      prefix: --download
  - id: fields
    type:
      - 'null'
      - type: array
        items: string
    doc: Fields to return (accessible with get_returnable_fields, used only for 
      report as display value) [multiple or comma-separated]
    inputBinding:
      position: 101
      prefix: --fields
  - id: free_text_search
    type:
      - 'null'
      - boolean
    doc: Use free text search, otherwise the data warehouse is used
    inputBinding:
      position: 101
      prefix: --free_text_search
  - id: length
    type:
      - 'null'
      - int
    doc: Number of records to retrieve (used only for display different of fasta
      and fastq
    inputBinding:
      position: 101
      prefix: --length
  - id: offset
    type:
      - 'null'
      - int
    doc: First record to get (used only for display different of fasta and fastq
    inputBinding:
      position: 101
      prefix: --offset
  - id: query
    type: string
    doc: Query string, made up of filtering conditions, joined by logical ANDs, 
      ORs and NOTs and bound by double quotes; the filter fields for a query are
      accessible with get_filter_fields and the type of filters with 
      get_filter_types
    inputBinding:
      position: 101
      prefix: --query
  - id: result
    type: string
    doc: Id of a result (accessible with get_results)
    inputBinding:
      position: 101
      prefix: --result
  - id: sortfields
    type:
      - 'null'
      - type: array
        items: string
    doc: Fields to sort the results (accessible with get_sortable_fields, used 
      only for report as display value) [multiple or comma-separated]
    inputBinding:
      position: 101
      prefix: --sortfields
outputs:
  - id: file
    type:
      - 'null'
      - File
    doc: File to save the content of the search (used with download option)
    outputBinding:
      glob: $(inputs.file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enasearch:0.2.2--py27_0
