cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - blobtools
  - taxify
label: blobtools_taxify
doc: "Assigns taxonomic IDs to sequences based on similarity search results and a
  taxid mapping file.\n\nTool homepage: https://blobtools.readme.io/docs/what-is-blobtools"
inputs:
  - id: custom_file
    type:
      - 'null'
      - File
    doc: File containing list of sequence IDs
    inputBinding:
      position: 101
      prefix: --custom
  - id: custom_score
    type:
      - 'null'
      - float
    doc: Score to assign to all sequence IDs in list
    inputBinding:
      position: 101
      prefix: --custom_score
  - id: custom_taxid
    type:
      - 'null'
      - int
    doc: TaxID to assign to all sequence IDs in list
    inputBinding:
      position: 101
      prefix: --custom_taxid
  - id: hit_column_qseqid
    type:
      - 'null'
      - int
    doc: "Zero-based column of qseqid in similarity search result [default: 0]\n \
      \                                               Change if different format than
      (-outfmt '6')"
    inputBinding:
      position: 101
      prefix: --hit_column_qseqid
  - id: hit_column_score
    type:
      - 'null'
      - int
    doc: "Zero-based column of (bit)score in similarity search result [default: 11]\n\
      \                                                Change if different format
      than (-outfmt '6')"
    inputBinding:
      position: 101
      prefix: --hit_column_score
  - id: hit_column_sseqid
    type:
      - 'null'
      - int
    doc: "Zero-based column of sseqid in similarity search result [default: 1]\n \
      \                                               Change if different format than
      (-outfmt '6')"
    inputBinding:
      position: 101
      prefix: --hit_column_sseqid
  - id: hit_file
    type: File
    doc: "BLAST/Diamond similarity search result (TSV format).\n                 \
      \                               Defaults assume \"-outfmt '6 qseqid sseqid pident
      length mismatch gapopen qstart qend sstart send evalue bitscore'\""
    inputBinding:
      position: 101
      prefix: --hit_file
  - id: map_col_sseqid
    type:
      - 'null'
      - int
    doc: Zero-based column of sseqid in TaxID mapping file (it will search for 
      sseqid in this column)
    inputBinding:
      position: 101
      prefix: --map_col_sseqid
  - id: map_col_taxid
    type:
      - 'null'
      - int
    doc: Zero-based Column of taxid in TaxID mapping file (it will extract for 
      taxid from this column)
    inputBinding:
      position: 101
      prefix: --map_col_taxid
  - id: out_prefix
    type:
      - 'null'
      - string
    doc: Output prefix
    inputBinding:
      position: 101
      prefix: --out
  - id: taxid_mapping_file
    type:
      - 'null'
      - File
    doc: TaxID mapping file (contains seqid and taxid)
    inputBinding:
      position: 101
      prefix: --taxid_mapping_file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blobtools:1.1.1--py_1
stdout: blobtools_taxify.out
