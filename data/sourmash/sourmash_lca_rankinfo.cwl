cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- sourmash
- lca
- rankinfo
label: sourmash_lca_rankinfo
doc: 'Summarize the lineage diversity of k-mers in LCA databases.


  Tool homepage: https://github.com/sourmash-bio/sourmash'
inputs:
- id: db
  type: File[]
  doc: LCA databases.
  inputBinding:
    position: 100
- id: quiet
  type:
  - 'null'
  - boolean
  doc: suppress non-error output
  inputBinding:
    position: 1
    prefix: --quiet
- id: debug
  type:
  - 'null'
  - boolean
  doc: output debugging output
  inputBinding:
    position: 1
    prefix: --debug
- id: scaled
  type:
  - 'null'
  - int
  doc: scaled
  inputBinding:
    position: 1
    prefix: --scaled
- id: minimum_num
  type:
  - 'null'
  - int
  doc: Minimum number of different lineages a k-mer must be in to be counted
  inputBinding:
    position: 1
    prefix: --minimum-num
outputs:
- id: stdout
  type: stdout
  doc: Standard output
stdout: sourmash_lca_rankinfo.stdout.txt
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
