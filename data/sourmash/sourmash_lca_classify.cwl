cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- sourmash
- lca
- classify
label: sourmash_lca_classify
doc: 'Classify query signatures with lowest common ancestor (LCA) databases.


  Tool homepage: https://github.com/sourmash-bio/sourmash'
inputs:
- id: db
  type:
  - 'null'
  - type: array
    items: File
  doc: databases to use to classify
  inputBinding:
    position: 1
    prefix: --db
- id: query
  type:
  - 'null'
  - type: array
    items: File
  doc: query signatures to classify
  inputBinding:
    position: 1
    prefix: --query
- id: query_from_file
  type:
  - 'null'
  - File
  doc: file containing list of signature files to query
  inputBinding:
    position: 1
    prefix: --query-from-file
- id: threshold
  type:
  - 'null'
  - int
  doc: 'minimum number of hashes needed for a taxonomic classification (default: 5)'
  inputBinding:
    position: 1
    prefix: --threshold
- id: majority
  type:
  - 'null'
  - boolean
  doc: use majority vote classification instead of lca
  inputBinding:
    position: 1
    prefix: --majority
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
- id: output
  type: string
  doc: output CSV to the specified file; by default output to stdout
  inputBinding:
    position: 1
    prefix: --output
  default: classify.csv
- id: scaled
  type:
  - 'null'
  - int
  doc: scaled
  inputBinding:
    position: 1
    prefix: --scaled
outputs:
- id: output_result
  type: File
  doc: output CSV to the specified file; by default output to stdout
  outputBinding:
    glob: $(inputs.output)
- id: stdout
  type: stdout
  doc: Standard output
stdout: sourmash_lca_classify.stdout.txt
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
