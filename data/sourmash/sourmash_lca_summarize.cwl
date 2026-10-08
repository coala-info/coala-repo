cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- sourmash
- lca
- summarize
label: sourmash_lca_summarize
doc: 'Summarize the taxonomic content of query signatures with LCA databases.


  Tool homepage: https://github.com/sourmash-bio/sourmash'
inputs:
- id: db
  type:
  - 'null'
  - type: array
    items: File
  doc: one or more LCA databases to use
  inputBinding:
    position: 1
    prefix: --db
- id: query
  type:
  - 'null'
  - type: array
    items: File
  doc: one or more signature files to use as queries
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
  doc: minimum number of hashes to require for a match
  inputBinding:
    position: 1
    prefix: --threshold
- id: output
  type: string
  doc: file to which CSV output will be written
  inputBinding:
    position: 1
    prefix: --output
  default: summarize.csv
- id: scaled
  type:
  - 'null'
  - int
  doc: scaled value to downsample to
  inputBinding:
    position: 1
    prefix: --scaled
- id: ignore_abundance
  type:
  - 'null'
  - boolean
  doc: ignore hash abundances in query signatures do not weight results
  inputBinding:
    position: 1
    prefix: --ignore-abundance
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
outputs:
- id: output_result
  type: File
  doc: file to which CSV output will be written
  outputBinding:
    glob: $(inputs.output)
- id: stdout
  type: stdout
  doc: Standard output
stdout: sourmash_lca_summarize.stdout.txt
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
