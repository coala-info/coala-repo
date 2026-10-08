cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- sourmash
- sig
- filter
label: sourmash_sig_filter
doc: 'Filter k-mers (hashes) on abundance.


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
- id: output
  type: string
  doc: output signature to this file (default stdout)
  inputBinding:
    position: 1
    prefix: --output
  default: filtered.sig
- id: md5
  type:
  - 'null'
  - string
  doc: select signatures whose md5 contains this substring
  inputBinding:
    position: 1
    prefix: --md5
- id: name
  type:
  - 'null'
  - string
  doc: select signatures whose name contains this substring
  inputBinding:
    position: 1
    prefix: --name
- id: min_abundance
  type:
  - 'null'
  - int
  doc: keep hashes >= this minimum abundance
  inputBinding:
    position: 1
    prefix: --min-abundance
- id: max_abundance
  type:
  - 'null'
  - int
  doc: keep hashes <= this maximum abundance
  inputBinding:
    position: 1
    prefix: --max-abundance
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
outputs:
- id: output_result
  type: File
  doc: output signature to this file (default stdout)
  outputBinding:
    glob: $(inputs.output)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
