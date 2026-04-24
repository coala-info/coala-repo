cwlVersion: v1.2
class: CommandLineTool
baseCommand: gene-fetch
label: gene-fetch
doc: "Fetch gene and/or protein sequences from the NCBI GenBank database.\n\nTool
  homepage: https://github.com/bge-barcoding/gene_fetch"
inputs:
  - id: api_key
    type: string
    doc: API key to use for NCBI API requests (required)
    inputBinding:
      position: 101
      prefix: --api-key
  - id: clean
    type:
      - 'null'
      - boolean
    doc: Force clean start - clear output directory regardless of previous run 
      parameters
    inputBinding:
      position: 101
      prefix: --clean
  - id: email
    type: string
    doc: Email to use for NCBI API requests (required)
    inputBinding:
      position: 101
      prefix: --email
  - id: genbank
    type:
      - 'null'
      - boolean
    doc: Download GenBank (.gb) files corresponding to fetched sequences
    inputBinding:
      position: 101
      prefix: --genbank
  - id: gene
    type: string
    doc: Name of gene to search for in NCBI RefSeq database (e.g., cox1, coi, 
      co1)
    inputBinding:
      position: 101
      prefix: --gene
  - id: header
    type:
      - 'null'
      - string
    doc: "FASTA header format: 'basic' (ID only, default) or 'detailed' (ID|taxid|accession|description|length)"
    inputBinding:
      position: 101
      prefix: --header
  - id: input_csv
    type:
      - 'null'
      - File
    doc: Path to input CSV file containing taxIDs (must have columns "taxID" and
      "ID")
    inputBinding:
      position: 101
      prefix: --in
  - id: input_taxonomy_csv
    type:
      - 'null'
      - File
    doc: Path to input CSV file containing taxonomic information (must have 
      columns "ID", "phylum", "class", "order", "family", "genus", "species")
    inputBinding:
      position: 101
      prefix: --in2
  - id: max_sequences
    type:
      - 'null'
      - int
    doc: Maximum number of sequences to fetch (only works with -s/--single)
    inputBinding:
      position: 101
      prefix: --max-sequences
  - id: nucleotide_size
    type:
      - 'null'
      - int
    doc: 'Minimum nucleotide sequence length(default: 1000. Can be bypassed by setting
      to zero/a negative number)'
    inputBinding:
      position: 101
      prefix: --nucleotide-size
  - id: protein_size
    type:
      - 'null'
      - int
    doc: 'Minimum protein sequence length (default: 500. Can be bypassed by setting
      to zero/a negative number)'
    inputBinding:
      position: 101
      prefix: --protein-size
  - id: single
    type:
      - 'null'
      - string
    doc: Single taxID to search and fetch (e.g., 7227)
    inputBinding:
      position: 101
      prefix: --single
  - id: type
    type: string
    doc: Specify sequence type to fetch (protein / nucleotide coding sequence / 
      both)
    inputBinding:
      position: 101
      prefix: --type
outputs:
  - id: out
    type: Directory
    doc: Path to directory to save output files (will create new directories)
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gene-fetch:1.0.21--pyhdfd78af_0
