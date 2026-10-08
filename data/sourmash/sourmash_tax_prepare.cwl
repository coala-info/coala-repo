cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- sourmash
- tax
- prepare
label: sourmash_tax_prepare
doc: 'Prepare and combine taxonomy files.


  Tool homepage: https://github.com/sourmash-bio/sourmash'
inputs:
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
  type: string
  doc: output file
  inputBinding:
    position: 1
    prefix: --output
  default: taxonomy.out
- id: database_format
  type:
  - 'null'
  - string
  doc: format of output file; default is 'sql')
  inputBinding:
    position: 1
    prefix: --database-format
- id: keep_full_identifiers
  type:
  - 'null'
  - boolean
  doc: do not split identifiers on whitespace
  inputBinding:
    position: 1
    prefix: --keep-full-identifiers
- id: keep_identifier_versions
  type:
  - 'null'
  - boolean
  doc: after splitting identifiers, do not remove accession versions
  inputBinding:
    position: 1
    prefix: --keep-identifier-versions
- id: fail_on_missing_taxonomy
  type:
  - 'null'
  - boolean
  doc: fail quickly if taxonomy is not available for an identifier
  inputBinding:
    position: 1
    prefix: --fail-on-missing-taxonomy
- id: force
  type:
  - 'null'
  - boolean
  doc: continue past errors in file and taxonomy loading
  inputBinding:
    position: 1
    prefix: --force
outputs:
- id: output_result
  type: File
  doc: output file
  outputBinding:
    glob: $(inputs.output)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
