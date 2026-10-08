cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- sourmash
- sig
- grep
label: sourmash_sig_grep
doc: 'Extract signatures by substring or regular expression match.


  Tool homepage: https://github.com/sourmash-bio/sourmash'
inputs:
- id: pattern
  type: string
  doc: Search pattern (string or regular expression).
  inputBinding:
    position: 100
- id: signatures
  type: File[]
  doc: Input signature files (or directories).
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
  doc: output debug information
  inputBinding:
    position: 1
    prefix: --debug
- id: output
  type: string
  doc: output matching signatures to this file (default stdout)
  inputBinding:
    position: 1
    prefix: --output
  default: matches.sig
- id: force
  type:
  - 'null'
  - boolean
  doc: try to load all files as signatures, independent of filename
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
- id: invert_match
  type:
  - 'null'
  - boolean
  doc: select non-matching signatures
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
- id: no_require_manifest
  type:
  - 'null'
  - boolean
  doc: do not require a manifest; generate dynamically if needed
  inputBinding:
    position: 1
    prefix: --no-require-manifest
- id: csv
  type:
  - 'null'
  - string
  doc: save CSV file containing signature data in manifest format
  inputBinding:
    position: 1
    prefix: --csv
- id: silent
  type:
  - 'null'
  - boolean
  doc: do not output signatures
  inputBinding:
    position: 1
    prefix: --silent
- id: count
  type:
  - 'null'
  - boolean
  doc: only output a count of discovered signatures; implies --silent
  inputBinding:
    position: 1
    prefix: --count
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
- id: picklist_files
  type:
  - 'null'
  - type: array
    items: File
  doc: Picklist files named in --picklist (file.csv:colname:coltype); staged in the working directory so the name resolves.
outputs:
- id: output_result
  type: File
  doc: output matching signatures to this file (default stdout)
  outputBinding:
    glob: $(inputs.output)
- id: csv_result
  type:
  - 'null'
  - File
  doc: save CSV file containing signature data in manifest format
  outputBinding:
    glob: $(inputs.csv)
- id: stdout
  type: stdout
  doc: Standard output
stdout: sourmash_sig_grep.stdout.txt
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
requirements:
- class: InitialWorkDirRequirement
  listing:
  - $(inputs.picklist_files)
