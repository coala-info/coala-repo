cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - umis
  - tagcount
label: umis_tagcount
doc: "Count up evidence for tagged molecules\n\nTool homepage: https://github.com/vals/umis"
inputs:
  - id: sam_file
    type: File
    doc: Input SAM file
    inputBinding:
      position: 1
  - id: cb_cutoff
    type:
      - 'null'
      - string
    doc: Number of counts to filter cellular barcodes. Set to 'auto' to 
      calculate a cutoff automatically.
    inputBinding:
      position: 102
      prefix: --cb_cutoff
  - id: cb_histogram
    type:
      - 'null'
      - File
    doc: A TSV file with CBs and a count. If the counts are are the number of 
      reads at a CB, the cb_cutoff option can be used to filter out CBs to be 
      counted.
    inputBinding:
      position: 102
      prefix: --cb_histogram
  - id: gene_tags
    type:
      - 'null'
      - boolean
    doc: Use the optional TX and GX tags in the BAM file to read gene mapping 
      information in stead of the mapping target nane. Useful if e.g. reads have
      been mapped to genome in stead of transcriptome.
    inputBinding:
      position: 102
      prefix: --gene_tags
  - id: genemap
    type:
      - 'null'
      - File
    doc: A TSV file mapping transcript ids to gene ids. If provided expression 
      will be summarised to gene level (recommended).
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
  - id: no_scale_evidence
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --no_scale_evidence
  - id: output_evidence_table
    type:
      - 'null'
      - string
    inputBinding:
      position: 102
      prefix: --output_evidence_table
  - id: parse_tags
    type:
      - 'null'
      - boolean
    doc: Parse BAM tags in stead of read name. In this mode the optional tags UM
      and CR will be used for UMI and cell barcode, respetively.
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
  - id: sparse
    type:
      - 'null'
      - boolean
    doc: Ouput counts in MatrixMarket format.
    inputBinding:
      position: 102
      prefix: --sparse
  - id: subsample
    type:
      - 'null'
      - int
    inputBinding:
      position: 102
      prefix: --subsample
outputs:
  - id: out_file
    type: File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/umis:1.0.9--py310h1fe012e_5
