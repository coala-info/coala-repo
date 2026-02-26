cwlVersion: v1.2
class: CommandLineTool
baseCommand: sourmash_lca
label: sourmash_lca
doc: "Taxonomic utilities\n\nTool homepage: https://github.com/sourmash-bio/sourmash"
inputs:
  - id: classify
    type:
      - 'null'
      - boolean
    doc: classify genomes
    inputBinding:
      position: 101
      prefix: classify
  - id: compare_csv
    type:
      - 'null'
      - boolean
    doc: compare spreadsheets
    inputBinding:
      position: 101
      prefix: compare_csv
  - id: index
    type:
      - 'null'
      - boolean
    doc: create LCA database
    inputBinding:
      position: 101
      prefix: index
  - id: rankinfo
    type:
      - 'null'
      - boolean
    doc: database rank info
    inputBinding:
      position: 101
      prefix: rankinfo
  - id: summarize
    type:
      - 'null'
      - boolean
    doc: summarize mixture
    inputBinding:
      position: 101
      prefix: summarize
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
stdout: sourmash_lca.out
