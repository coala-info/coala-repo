cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncbi-acc-download
label: ncbi-acc-download
doc: "Download sequences from NCBI based on accession numbers.\n\nTool homepage: https://github.com/kblin/ncbi-acc-download/"
inputs:
  - id: ncbi_accession
    type:
      type: array
      items: string
    doc: NCBI accession number(s) to download
    inputBinding:
      position: 1
  - id: api_key
    type:
      - 'null'
      - string
    doc: Specify USER NCBI API key. More info at 
      https://www.ncbi.nlm.nih.gov/books/NBK25497/
    inputBinding:
      position: 102
      prefix: --api-key
  - id: extended_validation
    type:
      - 'null'
      - string
    doc: "Perform extended validation. Possible options are 'none' to skip validation,
      'loads' to check if the sequence file loads in Biopython, or 'all' to run all
      checks. Default: none"
    inputBinding:
      position: 102
      prefix: --extended-validation
  - id: format
    type:
      - 'null'
      - string
    doc: 'File format to download nucleotide sequences in. Default: genbank'
    inputBinding:
      position: 102
      prefix: --format
  - id: molecule_type
    type:
      - 'null'
      - string
    doc: 'Molecule type to download. Default: nucleotide'
    inputBinding:
      position: 102
      prefix: --molecule
  - id: prefix
    type:
      - 'null'
      - string
    doc: Filename prefix to use for output files instead of using the NCBI ID.
    inputBinding:
      position: 102
      prefix: --prefix
  - id: range
    type:
      - 'null'
      - string
    doc: region to subset accession. only for single accession
    inputBinding:
      position: 102
      prefix: --range
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Recursively get all entries of a WGS entry.
    inputBinding:
      position: 102
      prefix: --recursive
  - id: url
    type:
      - 'null'
      - boolean
    doc: Instead of downloading the sequences, just print the URLs to stdout.
    inputBinding:
      position: 102
      prefix: --url
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print a progress indicator.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Single filename to use for the combined output.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbi-acc-download:0.2.8--pyh5e36f6f_0
