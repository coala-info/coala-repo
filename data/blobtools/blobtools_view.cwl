cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - blobtools
  - view
label: blobtools_view
doc: "View and filter a BlobDB database.\n\nTool homepage: https://blobtools.readme.io/docs/what-is-blobtools"
inputs:
  - id: display_hits
    type:
      - 'null'
      - boolean
    doc: Displays taxonomic hits from tax files that contributed to the 
      taxonomy.
    inputBinding:
      position: 101
      prefix: --hits
  - id: experimental_output
    type:
      - 'null'
      - string
    doc: Experimental output
    default: false
    inputBinding:
      position: 101
      prefix: --experimental
  - id: generate_concoct_files
    type:
      - 'null'
      - boolean
    doc: Generate concoct files
    default: false
    inputBinding:
      position: 101
      prefix: --concoct
  - id: generate_cov_files
    type:
      - 'null'
      - boolean
    doc: Generate cov files
    default: false
    inputBinding:
      position: 101
      prefix: --cov
  - id: input_blobdb
    type: File
    doc: BlobDB file (created with "blobtools create")
    inputBinding:
      position: 101
      prefix: --input
  - id: no_table_view
    type:
      - 'null'
      - boolean
    doc: Do not generate table view
    default: false
    inputBinding:
      position: 101
      prefix: --notable
  - id: sequence_list
    type:
      - 'null'
      - File
    doc: List of sequence names (file).
    inputBinding:
      position: 101
      prefix: --list
  - id: taxonomic_rank
    type:
      - 'null'
      - type: array
        items: string
    doc: "Taxonomic rank(s) at which output will be written. (supported: 'species',
      'genus', 'family', 'order', 'phylum', 'superkingdom', 'all')"
    default: phylum
    inputBinding:
      position: 101
      prefix: --rank
  - id: taxrule
    type:
      - 'null'
      - string
    doc: 'Taxrule used for computing taxonomy (supported: "bestsum", "bestsumorder")'
    default: bestsum
    inputBinding:
      position: 101
      prefix: --taxrule
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: Output prefix
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blobtools:1.1.1--py_1
