cwlVersion: v1.2
class: CommandLineTool
baseCommand: enasearch retrieve_taxons
label: enasearch_retrieve_taxons
doc: "Retrieve data from the ENA Taxon Portal.\n\n  This function retrieves data (other
  than taxon) from ENA by:\n\n  - Formatting the ids to query then on the Taxon Portal
  - Building the URL\n  based on the ids to retrieve and some parameters to format
  the results -\n  Requesting the URL to extract the data\n\n  The output can be redirected
  to a file and directly display to the\n  standard output given the display chosen.\n\
  \nTool homepage: http://bebatut.fr/enasearch/"
inputs:
  - id: display
    type: string
    doc: "Display option to specify the display format\n                         \
      \ (accessible with get_display_options)"
    inputBinding:
      position: 101
      prefix: --display
  - id: download
    type:
      - 'null'
      - string
    doc: "Download option to specify that records are to be\n                    \
      \      saved in a file (used with file option, list\n                      \
      \    accessible with get_download_options)"
    inputBinding:
      position: 101
      prefix: --download
  - id: expanded
    type:
      - 'null'
      - boolean
    doc: Determine if a CON record is expanded
    inputBinding:
      position: 101
      prefix: --expanded
  - id: header
    type:
      - 'null'
      - boolean
    doc: To obtain only the header of a record
    inputBinding:
      position: 101
      prefix: --header
  - id: ids
    type:
      type: array
      items: string
    doc: Ids for taxon to return
    inputBinding:
      position: 101
      prefix: --ids
  - id: length
    type:
      - 'null'
      - int
    doc: "Number of records to retrieve (used only for display\n                 \
      \         different of fasta and fastq"
    inputBinding:
      position: 101
      prefix: --length
  - id: offset
    type:
      - 'null'
      - int
    doc: "First record to get (used only for display different\n                 \
      \         of fasta and fastq"
    inputBinding:
      position: 101
      prefix: --offset
  - id: result
    type:
      - 'null'
      - string
    doc: "Id of a taxonomy result (accessible with\n                          get_taxonomy_results)"
    inputBinding:
      position: 101
      prefix: --result
  - id: subseq_range
    type:
      - 'null'
      - string
    doc: "Range for subsequences (integer start and stop\n                       \
      \   separated by a -)"
    inputBinding:
      position: 101
      prefix: --subseq_range
outputs:
  - id: file
    type:
      - 'null'
      - File
    doc: "File to save the content of the search (used with\n                    \
      \      download option)"
    outputBinding:
      glob: $(inputs.file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enasearch:0.2.2--py27_0
