cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- sourmash
- tax
- grep
label: sourmash_tax_grep
doc: 'Search taxonomies for matching strings and create picklists.


  Tool homepage: https://github.com/sourmash-bio/sourmash'
inputs:
- id: pattern
  type: string
  doc: Search pattern (string or regular expression).
  inputBinding:
    position: 0
- id: rank
  type:
  - 'null'
  - string
  doc: search only this rank
  inputBinding:
    position: 1
    prefix: --rank
- id: invert_match
  type:
  - 'null'
  - boolean
  doc: select non-matching lineages
  inputBinding:
    position: 1
    prefix: --invert-match
- id: ignore_case
  type:
  - 'null'
  - boolean
  doc: ignore case distinctions (search lower and upper case both)
  inputBinding:
    position: 1
    prefix: --ignore-case
- id: silent
  type:
  - 'null'
  - boolean
  doc: do not output picklist
  inputBinding:
    position: 1
    prefix: --silent
- id: count
  type:
  - 'null'
  - boolean
  doc: only output a count of discovered lineages; implies --silent
  inputBinding:
    position: 1
    prefix: --count
- id: quiet
  type:
  - 'null'
  - boolean
  doc: suppress non-error output
  inputBinding:
    position: 1
    prefix: --quiet
- id: taxonomy_csv
  type:
  - 'null'
  - type: array
    items: File
  doc: database lineages
  inputBinding:
    position: 1
    prefix: --taxonomy-csv
- id: output
  type:
  - 'null'
  - string
  doc: output file (defaults to stdout)
  inputBinding:
    position: 1
    prefix: --output
- id: force
  type:
  - 'null'
  - boolean
  doc: continue past errors in file and taxonomy loading
  inputBinding:
    position: 1
    prefix: --force
outputs:
- id: stdout
  type: stdout
  doc: Standard output
stdout: sourmash_tax_grep.stdout.txt
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
