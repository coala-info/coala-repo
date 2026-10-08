cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- sourmash
- lca
- index
label: sourmash_lca_index
doc: 'Create a lowest common ancestor (LCA) database from signatures and a taxonomy spreadsheet.


  Tool homepage: https://github.com/sourmash-bio/sourmash'
inputs:
- id: csv
  type: File
  doc: Taxonomy spreadsheet.
  inputBinding:
    position: 100
- id: lca_db_out
  type: string
  doc: Output database name.
  inputBinding:
    position: 101
- id: signatures
  type:
  - 'null'
  - File[]
  doc: Signatures or directory of signatures to index.
  inputBinding:
    position: 102
- id: from_file
  type:
  - 'null'
  - File
  doc: a text file containing a list of files to load signatures from
  inputBinding:
    position: 1
    prefix: --from-file
- id: scaled
  type:
  - 'null'
  - int
  doc: scaled
  inputBinding:
    position: 1
    prefix: --scaled
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
- id: split_identifiers
  type:
  - 'null'
  - boolean
  doc: split names in signatures on whitespace
  inputBinding:
    position: 1
    prefix: --split-identifiers
- id: keep_identifier_versions
  type:
  - 'null'
  - boolean
  doc: do not remove accession versions
  inputBinding:
    position: 1
    prefix: --keep-identifier-versions
- id: force
  type:
  - 'null'
  - boolean
  doc: force
  inputBinding:
    position: 1
    prefix: --force
- id: report
  type:
  - 'null'
  - string
  doc: output a report on anomalies, if any
  inputBinding:
    position: 1
    prefix: --report
- id: require_taxonomy
  type:
  - 'null'
  - boolean
  doc: ignore signatures with no taxonomy entry
  inputBinding:
    position: 1
    prefix: --require-taxonomy
- id: fail_on_missing_taxonomy
  type:
  - 'null'
  - boolean
  doc: fail quickly if taxonomy is not available for an identifier
  inputBinding:
    position: 1
    prefix: --fail-on-missing-taxonomy
- id: database_format
  type:
  - 'null'
  - string
  doc: format of output database; default is 'json')
  inputBinding:
    position: 1
    prefix: --database-format
- id: ksize
  type:
  - 'null'
  - int
  doc: k-mer size to select; default=31
  inputBinding:
    position: 1
    prefix: --ksize
- id: protein
  type:
  - 'null'
  - boolean
  doc: choose a protein signature; by default, a nucleotide signature is used
  inputBinding:
    position: 1
    prefix: --protein
- id: no_protein
  type:
  - 'null'
  - boolean
  doc: do not choose a protein signature
  inputBinding:
    position: 1
    prefix: --no-protein
- id: dayhoff
  type:
  - 'null'
  - boolean
  doc: choose Dayhoff-encoded amino acid signatures
  inputBinding:
    position: 1
    prefix: --dayhoff
- id: no_dayhoff
  type:
  - 'null'
  - boolean
  doc: do not choose Dayhoff-encoded amino acid signatures
  inputBinding:
    position: 1
    prefix: --no-dayhoff
- id: hp
  type:
  - 'null'
  - boolean
  doc: choose hydrophobic-polar-encoded amino acid signatures
  inputBinding:
    position: 1
    prefix: --hp
- id: no_hp
  type:
  - 'null'
  - boolean
  doc: do not choose hydrophobic-polar-encoded amino acid signatures
  inputBinding:
    position: 1
    prefix: --no-hp
- id: skipm1n3
  type:
  - 'null'
  - boolean
  doc: choose skipmer (m1n3) signatures
  inputBinding:
    position: 1
    prefix: --skipm1n3
- id: no_skipm1n3
  type:
  - 'null'
  - boolean
  doc: do not choose skipmer (m1n3) signatures
  inputBinding:
    position: 1
    prefix: --no-skipm1n3
- id: skipm2n3
  type:
  - 'null'
  - boolean
  doc: choose skipmer (m2n3) signatures
  inputBinding:
    position: 1
    prefix: --skipm2n3
- id: no_skipm2n3
  type:
  - 'null'
  - boolean
  doc: do not choose skipmer (m2n3) signatures
  inputBinding:
    position: 1
    prefix: --no-skipm2n3
- id: dna
  type:
  - 'null'
  - boolean
  doc: 'choose a nucleotide signature (default: True)'
  inputBinding:
    position: 1
    prefix: --dna
- id: no_dna
  type:
  - 'null'
  - boolean
  doc: do not choose a nucleotide signature
  inputBinding:
    position: 1
    prefix: --no-dna
- id: picklist
  type:
  - 'null'
  - string
  doc: select signatures based on a picklist, i.e. 'file.csv:colname:coltype'
  inputBinding:
    position: 1
    prefix: --picklist
- id: picklist_require_all
  type:
  - 'null'
  - boolean
  doc: require that all picklist values be found or else fail
  inputBinding:
    position: 1
    prefix: --picklist-require-all
- id: picklist_files
  type:
  - 'null'
  - type: array
    items: File
  doc: Picklist files named in --picklist (file.csv:colname:coltype); staged in the working directory so the name resolves.
outputs:
- id: report_result
  type:
  - 'null'
  - File
  doc: output a report on anomalies, if any
  outputBinding:
    glob: $(inputs.report)
- id: lca_db
  type:
    type: array
    items: File
  doc: LCA database written by sourmash (database name plus the .lca.json or .lca.sql extension).
  outputBinding:
    glob: $(inputs.lca_db_out)*
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
requirements:
- class: InitialWorkDirRequirement
  listing:
  - $(inputs.picklist_files)
