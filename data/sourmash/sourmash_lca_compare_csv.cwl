cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- sourmash
- lca
- compare_csv
label: sourmash_lca_compare_csv
doc: 'Compare two taxonomy spreadsheets.


  Tool homepage: https://github.com/sourmash-bio/sourmash'
inputs:
- id: csv1
  type: File
  doc: Taxonomy spreadsheet output by classify.
  inputBinding:
    position: 100
- id: csv2
  type: File
  doc: Custom taxonomy spreadsheet.
  inputBinding:
    position: 101
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
- id: start_column
  type:
  - 'null'
  - int
  doc: column at which taxonomic assignments start; default=2
  inputBinding:
    position: 1
    prefix: --start-column
- id: tabs
  type:
  - 'null'
  - boolean
  doc: input spreadsheet is tab-delimited; default is commas
  inputBinding:
    position: 1
    prefix: --tabs
- id: no_headers
  type:
  - 'null'
  - boolean
  doc: no headers present in taxonomy spreadsheet
  inputBinding:
    position: 1
    prefix: --no-headers
- id: force
  type:
  - 'null'
  - boolean
  doc: force
  inputBinding:
    position: 1
    prefix: --force
outputs:
- id: log
  type: stderr
  doc: Standard error (progress and summary messages)
stderr: sourmash_lca_compare_csv.log.txt
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
