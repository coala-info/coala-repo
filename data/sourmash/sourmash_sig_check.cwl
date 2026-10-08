cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- sourmash
- sig
- check
label: sourmash_sig_check
doc: 'Check signature collections against a picklist.


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
- id: output_missing
  type:
  - 'null'
  - string
  doc: output picklist with remaining unmatched entries to this file
  inputBinding:
    position: 1
    prefix: --output-missing
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
- id: save_manifest_matching
  type:
  - 'null'
  - string
  doc: save a manifest of the matching entries to this file.
  inputBinding:
    position: 1
    prefix: --save-manifest-matching
- id: fail_if_missing
  type:
  - 'null'
  - boolean
  doc: exit with an error code (-1) if there are any missing picklist values.
  inputBinding:
    position: 1
    prefix: --fail-if-missing
- id: no_require_manifest
  type:
  - 'null'
  - boolean
  doc: do not require a manifest; generate dynamically if needed
  inputBinding:
    position: 1
    prefix: --no-require-manifest
- id: manifest_format
  type:
  - 'null'
  - string
  doc: format of manifest output file; default is 'csv')
  inputBinding:
    position: 1
    prefix: --manifest-format
- id: abspath
  type:
  - 'null'
  - boolean
  doc: convert all locations to absolute paths
  inputBinding:
    position: 1
    prefix: --abspath
- id: no_abspath
  type:
  - 'null'
  - boolean
  doc: do not convert all locations to absolute paths
  inputBinding:
    position: 1
    prefix: --no-abspath
- id: relpath
  type:
  - 'null'
  - boolean
  doc: convert all locations to paths relative to the output manifest
  inputBinding:
    position: 1
    prefix: --relpath
- id: no_relpath
  type:
  - 'null'
  - boolean
  doc: do not convert all locations to paths relative to the output manifest
  inputBinding:
    position: 1
    prefix: --no-relpath
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
- id: v4
  type:
  - 'null'
  - boolean
  doc: use sourmash v4 command-line behavior (default)
  inputBinding:
    position: 1
    prefix: --v4
- id: v5
  type:
  - 'null'
  - boolean
  doc: use sourmash v5 command-line behavior
  inputBinding:
    position: 1
    prefix: --v5
- id: picklist_files
  type:
  - 'null'
  - type: array
    items: File
  doc: Picklist files named in --picklist (file.csv:colname:coltype); staged in the working directory so the name resolves.
outputs:
- id: output_missing_result
  type:
  - 'null'
  - File
  doc: output picklist with remaining unmatched entries to this file
  outputBinding:
    glob: $(inputs.output_missing)
- id: save_manifest_matching_result
  type:
  - 'null'
  - File
  doc: save a manifest of the matching entries to this file.
  outputBinding:
    glob: $(inputs.save_manifest_matching)
- id: log
  type: stderr
  doc: Standard error (progress and summary messages)
stderr: sourmash_sig_check.log.txt
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
requirements:
- class: InitialWorkDirRequirement
  listing:
  - $(inputs.picklist_files)
