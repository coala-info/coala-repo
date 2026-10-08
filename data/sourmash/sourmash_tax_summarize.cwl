cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- sourmash
- tax
- summarize
label: sourmash_tax_summarize
doc: 'Print summary information for lineage spreadsheets or taxonomy databases.


  Tool homepage: https://github.com/sourmash-bio/sourmash'
inputs:
- id: taxonomy_files
  type: File[]
  doc: Database lineages.
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
- id: output_lineage_information
  type:
  - 'null'
  - string
  doc: output a CSV file containing individual lineage counts
  inputBinding:
    position: 1
    prefix: --output-lineage-information
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
- id: force
  type:
  - 'null'
  - boolean
  doc: continue past errors in file and taxonomy loading
  inputBinding:
    position: 1
    prefix: --force
- id: lins
  type:
  - 'null'
  - boolean
  doc: use LIN taxonomy in place of standard taxonomic ranks.
  inputBinding:
    position: 1
    prefix: --lins
- id: ictv
  type:
  - 'null'
  - boolean
  doc: use ICTV taxonomy in place of standard taxonomic ranks. Note that the taxonomy CSV must contain ICTV ranks.
  inputBinding:
    position: 1
    prefix: --ictv
outputs:
- id: output_lineage_information_result
  type:
  - 'null'
  - File
  doc: output a CSV file containing individual lineage counts
  outputBinding:
    glob: $(inputs.output_lineage_information)
- id: stdout
  type: stdout
  doc: Standard output
stdout: sourmash_tax_summarize.stdout.txt
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
