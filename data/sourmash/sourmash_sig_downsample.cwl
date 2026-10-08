cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- sourmash
- sig
- downsample
label: sourmash_sig_downsample
doc: 'Downsample one or more signatures.


  Tool homepage: https://github.com/sourmash-bio/sourmash'
inputs:
- id: signatures
  type: File[]
  doc: Input signature files (or directories).
  inputBinding:
    position: 100
- id: scaled
  type:
  - 'null'
  - int
  doc: scaled value to downsample to
  inputBinding:
    position: 1
    prefix: --scaled
- id: from_file
  type:
  - 'null'
  - File
  doc: a text file containing a list of files to load signatures from
  inputBinding:
    position: 1
    prefix: --from-file
- id: quiet
  type:
  - 'null'
  - boolean
  doc: suppress non-error output
  inputBinding:
    position: 1
    prefix: --quiet
- id: output
  type: string
  doc: output signature to this file (default stdout)
  inputBinding:
    position: 1
    prefix: --output
  default: downsampled.sig
- id: force
  type:
  - 'null'
  - boolean
  doc: try to load all files as signatures
  inputBinding:
    position: 1
    prefix: --force
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
- id: num_hashes
  type:
  - 'null'
  - int
  doc: num value should be between 50 and 50000
  inputBinding:
    position: 1
    prefix: --num-hashes
- id: picklist_files
  type:
  - 'null'
  - type: array
    items: File
  doc: Picklist files named in --picklist (file.csv:colname:coltype); staged in the working directory so the name resolves.
outputs:
- id: output_result
  type: File
  doc: output signature to this file (default stdout)
  outputBinding:
    glob: $(inputs.output)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
requirements:
- class: InitialWorkDirRequirement
  listing:
  - $(inputs.picklist_files)
