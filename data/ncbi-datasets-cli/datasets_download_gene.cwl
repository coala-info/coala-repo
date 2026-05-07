cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - datasets
  - download
  - gene
label: datasets_download_gene
doc: Download a gene data package. Gene data packages include gene, transcript 
  and protein sequences and one or more data reports. Data packages are 
  downloaded as a zip archive.
inputs:
  - id: subcommand
    type: string
    doc: The specific download method (gene-id, symbol, accession, or taxon)
    inputBinding:
      position: 1
  - id: query
    type: string
    doc: The identifier for the subcommand (e.g., Gene ID, symbol, accession, or
      taxon name)
    inputBinding:
      position: 2
  - id: fasta_filter
    type:
      - 'null'
      - type: array
        items: string
    doc: Limit protein and RNA sequence files to the specified RefSeq nucleotide
      and protein accessions
    inputBinding:
      position: 103
      prefix: --fasta-filter
  - id: fasta_filter_file
    type: File
    doc: Limit protein and RNA sequence files to the specified RefSeq nucleotide
      and protein accessions included in the specified file
    inputBinding:
      position: 103
      prefix: --fasta-filter-file
  - id: preview
    type:
      - 'null'
      - boolean
    doc: Show information about the requested data package
    inputBinding:
      position: 103
      prefix: --preview
  - id: api_key
    type:
      - 'null'
      - string
    doc: Specify an NCBI API key
    inputBinding:
      position: 103
      prefix: --api-key
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Emit debugging info
    inputBinding:
      position: 103
      prefix: --debug
  - id: filename
    type: string
    doc: Specify a custom file name for the downloaded data package
    inputBinding:
      position: 103
      prefix: --filename
  - id: no_progressbar
    type:
      - 'null'
      - boolean
    doc: Hide progress bar
    inputBinding:
      position: 103
      prefix: --no-progressbar
outputs:
  - id: output_filename
    type:
      - 'null'
      - File
    doc: Specify a custom file name for the downloaded data package
    outputBinding:
      glob: $(inputs.filename)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: ensemblorg/datasets-cli:latest
s:url: https://github.com/metagenlab/assembly_finder
$namespaces:
  s: https://schema.org/
