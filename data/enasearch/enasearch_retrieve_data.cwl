cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - enasearch
  - retrieve_data
label: enasearch_retrieve_data
doc: "Retrieve ENA data (other than taxon).\n\n  This function retrieves data (other
  than taxon) from ENA by:\n\n  - Building the URL based on the ids to retrieve and
  some parameters to\n  format the results - Requesting the URL to extract the data\n\
  \n  The output can be redirected to a file and directly display to the\n  standard
  output given the display chosen.\n\nTool homepage: http://bebatut.fr/enasearch/"
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
    doc: Ids for records to return (other than Taxon and Project)
    inputBinding:
      position: 101
      prefix: --ids
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
    doc: First record to get (used only for display different of  fasta and 
      fastq
    inputBinding:
      position: 101
      prefix: --offset
  - id: subseq_range
    type:
      - 'null'
      - string
    doc: Range for subsequences (integer start and stop separated  by a -)
    inputBinding:
      position: 101
      prefix: --subseq_range
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
