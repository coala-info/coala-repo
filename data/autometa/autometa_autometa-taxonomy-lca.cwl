cwlVersion: v1.2
class: CommandLineTool
baseCommand: autometa-taxonomy-lca
label: autometa_autometa-taxonomy-lca
doc: "Script to determine Lowest Common Ancestor\n\nTool homepage: https://github.com/KwanLab/Autometa"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: blast
    type: File
    doc: "Path to BLAST results table respective to `orfs` (outfmt 6)"
    inputBinding:
      position: 1
      prefix: --blast
  - id: dbdir
    type:
      - 'null'
      - Directory
    doc: "Path to taxonomy databases directory."
    inputBinding:
      position: 1
      prefix: --dbdir
  - id: dbtype
    type:
      - 'null'
      - string
    doc: "Taxonomy database to use (ncbi, gtdb) (default: ncbi)"
    inputBinding:
      position: 1
      prefix: --dbtype
  - id: lca_output
    type: string
    doc: "Path to write LCA results."
    inputBinding:
      position: 1
      prefix: --lca-output
  - id: sseqid2taxid_output
    type:
      - 'null'
      - string
    doc: "Path to write qseqids sseqids to taxids translations table"
    inputBinding:
      position: 1
      prefix: --sseqid2taxid-output
  - id: lca_error_taxids
    type:
      - 'null'
      - string
    doc: "Path to write table of blast table qseqids that were assigned root due to a missing taxid"
    inputBinding:
      position: 1
      prefix: --lca-error-taxids
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Add verbosity to logging stream."
    inputBinding:
      position: 1
      prefix: --verbose
  - id: force
    type:
      - 'null'
      - boolean
    doc: "Force overwrite if results already exist."
    inputBinding:
      position: 1
      prefix: --force
  - id: cache
    type:
      - 'null'
      - string
    doc: "Path to cache pickled LCA database objects."
    inputBinding:
      position: 1
      prefix: --cache
  - id: only_prepare_cache
    type:
      - 'null'
      - boolean
    doc: "Only prepare the LCA database objects and write to provided --cache parameter"
    inputBinding:
      position: 1
      prefix: --only-prepare-cache
  - id: force_cache_overwrite
    type:
      - 'null'
      - boolean
    doc: "Force overwrite if results already exist."
    inputBinding:
      position: 1
      prefix: --force-cache-overwrite
outputs:
  - id: lca_out
    type: File?
    doc: "LCA results"
    outputBinding:
      glob: "$(inputs.lca_output)"
  - id: sseqid2taxid_out
    type: File?
    doc: "qseqid/sseqid to taxid table"
    outputBinding:
      glob: "${ return inputs.sseqid2taxid_output ? inputs.sseqid2taxid_output : []; }"
  - id: lca_error_taxids_out
    type: File?
    doc: "qseqids assigned root due to a missing taxid"
    outputBinding:
      glob: "${ return inputs.lca_error_taxids ? inputs.lca_error_taxids : []; }"
  - id: cache_out
    type: Directory?
    doc: "Pickled LCA database objects"
    outputBinding:
      glob: "${ return inputs.cache ? inputs.cache : []; }"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
