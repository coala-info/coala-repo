cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - umis
  - fasttagcount
label: umis_fasttagcount
doc: "Count up evidence for tagged molecules, this implementation assumes the\n  alignment
  file is coordinate sorted\n\nTool homepage: https://github.com/vals/umis"
inputs:
  - id: sam_file
    type: File
    doc: SAM file
    inputBinding:
      position: 1
  - id: cb_cutoff
    type:
      - 'null'
      - string
    doc: "Number of counts to filter cellular barcodes. Set to\n                 \
      \      'auto' to calculate a cutoff automatically."
    inputBinding:
      position: 102
      prefix: --cb_cutoff
  - id: cb_histogram
    type:
      - 'null'
      - File
    doc: "A TSV file with CBs and a count. If the counts are are\n               \
      \        the number of reads at a CB, the cb_cutoff option can\n           \
      \            be used to filter out CBs to be counted."
    inputBinding:
      position: 102
      prefix: --cb_histogram
  - id: gene_tags
    type:
      - 'null'
      - boolean
    doc: "Use the optional TX and GX tags in the BAM file to read\n              \
      \         gene mapping information in stead of the mapping target\n        \
      \               nane. Useful if e.g. reads have been mapped to genome\n    \
      \                   in stead of transcriptome."
    inputBinding:
      position: 102
      prefix: --gene_tags
  - id: genemap
    type:
      - 'null'
      - File
    doc: "A TSV file mapping transcript ids to gene ids. If\n                    \
      \   provided expression will be summarised to gene level\n                 \
      \      (recommended)."
    inputBinding:
      position: 102
      prefix: --genemap
  - id: minevidence
    type:
      - 'null'
      - float
    inputBinding:
      position: 102
      prefix: --minevidence
  - id: parse_tags
    type:
      - 'null'
      - boolean
    doc: "Parse BAM tags in stead of read name. In this mode the\n               \
      \        optional tags UM and CR will be used for UMI and cell\n           \
      \            barcode, respetively."
    inputBinding:
      position: 102
      prefix: --parse_tags
  - id: positional
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --positional
  - id: subsample
    type:
      - 'null'
      - int
    inputBinding:
      position: 102
      prefix: --subsample
  - id: umi_matrix
    type:
      - 'null'
      - File
    doc: "Save a sparse matrix of counts without UMI deduping to\n               \
      \        this file."
    inputBinding:
      position: 102
      prefix: --umi_matrix
outputs:
  - id: out_file
    type: File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/umis:1.0.9--py310h1fe012e_5
