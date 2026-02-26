cwlVersion: v1.2
class: CommandLineTool
baseCommand: tsumugi_genes
label: tsumugi_genes
doc: "Filter annotations based on gene symbols or gene pairs.\n\nTool homepage: https://github.com/akikuno/TSUMUGI-dev"
inputs:
  - id: drop_gene_symbol
    type:
      - 'null'
      - string
    doc: Drop annotations with gene symbols or gene pairs listed in a text file
    inputBinding:
      position: 101
      prefix: --drop
  - id: genewise
    type:
      - 'null'
      - boolean
    doc: Filter by user-provided gene symbols
    inputBinding:
      position: 101
      prefix: --genewise
  - id: input_pairwise
    type:
      - 'null'
      - File
    doc: Path to 'pairwise_similarity_annotations' file (JSONL or JSONL.gz). If 
      omitted, data are read from STDIN.
    inputBinding:
      position: 101
      prefix: --in
  - id: keep_gene_symbol
    type:
      - 'null'
      - string
    doc: Keep ONLY annotations with gene symbols or gene pairs listed in a text 
      file
    inputBinding:
      position: 101
      prefix: --keep
  - id: pairwise
    type:
      - 'null'
      - boolean
    doc: Filter by user-provided gene pairs
    inputBinding:
      position: 101
      prefix: --pairwise
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tsumugi:1.0.2--pyhdfd78af_0
stdout: tsumugi_genes.out
