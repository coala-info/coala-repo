cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- sourmash
- sig
- collect
label: sourmash_sig_collect
doc: 'Collect manifest information across many files.


  Tool homepage: https://github.com/sourmash-bio/sourmash'
inputs:
- id: locations
  type: File[]
  doc: Locations of input signatures.
  inputBinding:
    position: 100
- id: output
  type: string
  doc: manifest output file
  inputBinding:
    position: 1
    prefix: --output
  default: manifest.csv
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
- id: from_file
  type:
  - 'null'
  - File
  doc: a text file containing a list of files to load signatures from
  inputBinding:
    position: 1
    prefix: --from-file
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
- id: merge_previous
  type:
  - 'null'
  - boolean
  doc: merge new manifests into existing
  inputBinding:
    position: 1
    prefix: --merge-previous
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
outputs:
- id: output_result
  type: File
  doc: manifest output file
  outputBinding:
    glob: $(inputs.output)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
