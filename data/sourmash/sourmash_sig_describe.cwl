cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- sourmash
- sig
- describe
label: sourmash_sig_describe
doc: 'Show details of signatures.


  Tool homepage: https://github.com/sourmash-bio/sourmash'
inputs:
- id: signatures
  type: File[]
  doc: Input signature files (or directories).
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
  doc: provide debugging output
  inputBinding:
    position: 1
    prefix: --debug
- id: csv
  type:
  - 'null'
  - string
  doc: output information to a CSV file
  inputBinding:
    position: 1
    prefix: --csv
- id: force
  type:
  - 'null'
  - boolean
  doc: try to load all files as signatures
  inputBinding:
    position: 1
    prefix: --force
- id: from_file
  type:
  - 'null'
  - File
  doc: a text file containing a list of files to load signatures from
  inputBinding:
    position: 1
    prefix: --from-file
- id: ksize
  type:
  - 'null'
  - int
  doc: k-mer size to select; no default.
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
- id: include_db_pattern
  type:
  - 'null'
  - string
  doc: search only signatures that match this pattern in name, filename, or md5
  inputBinding:
    position: 1
    prefix: --include-db-pattern
- id: exclude_db_pattern
  type:
  - 'null'
  - string
  doc: search only signatures that do not match this pattern in name, filename, or md5
  inputBinding:
    position: 1
    prefix: --exclude-db-pattern
- id: picklist_files
  type:
  - 'null'
  - type: array
    items: File
  doc: Picklist files named in --picklist (file.csv:colname:coltype); staged in the working directory so the name resolves.
outputs:
- id: csv_result
  type:
  - 'null'
  - File
  doc: output information to a CSV file
  outputBinding:
    glob: $(inputs.csv)
- id: stdout
  type: stdout
  doc: Standard output
stdout: sourmash_sig_describe.stdout.txt
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
requirements:
- class: InitialWorkDirRequirement
  listing:
  - $(inputs.picklist_files)
