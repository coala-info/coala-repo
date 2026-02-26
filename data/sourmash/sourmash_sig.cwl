cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sourmash
  - sig
label: sourmash_sig
doc: "Manipulate signature files\n\nTool homepage: https://github.com/sourmash-bio/sourmash"
inputs:
  - id: cat
    type:
      - 'null'
      - boolean
    doc: concatenate signature files
    inputBinding:
      position: 101
      prefix: cat
  - id: check
    type:
      - 'null'
      - boolean
    doc: check signature collections against a picklist
    inputBinding:
      position: 101
      prefix: check
  - id: collect
    type:
      - 'null'
      - boolean
    doc: collect manifest information across many files
    inputBinding:
      position: 101
      prefix: collect
  - id: describe
    type:
      - 'null'
      - boolean
    doc: show details of signature
    inputBinding:
      position: 101
      prefix: describe
  - id: downsample
    type:
      - 'null'
      - boolean
    doc: downsample one or more signatures
    inputBinding:
      position: 101
      prefix: downsample
  - id: export
    type:
      - 'null'
      - boolean
    doc: export a signature, e.g. to mash
    inputBinding:
      position: 101
      prefix: export
  - id: extract
    type:
      - 'null'
      - boolean
    doc: extract one or more signatures
    inputBinding:
      position: 101
      prefix: extract
  - id: fileinfo
    type:
      - 'null'
      - boolean
    doc: provide summary information on the given file
    inputBinding:
      position: 101
      prefix: fileinfo
  - id: filter
    type:
      - 'null'
      - boolean
    doc: filter k-mers on abundance
    inputBinding:
      position: 101
      prefix: filter
  - id: flatten
    type:
      - 'null'
      - boolean
    doc: remove abundances
    inputBinding:
      position: 101
      prefix: flatten
  - id: grep
    type:
      - 'null'
      - boolean
    doc: extract one or more signatures by substr/regex match
    inputBinding:
      position: 101
      prefix: grep
  - id: inflate
    type:
      - 'null'
      - boolean
    doc: borrow abundances from one signature => one or more other signatures
    inputBinding:
      position: 101
      prefix: inflate
  - id: ingest
    type:
      - 'null'
      - boolean
    doc: ingest/import a mash or other signature
    inputBinding:
      position: 101
      prefix: ingest
  - id: intersect
    type:
      - 'null'
      - boolean
    doc: intersect two or more signatures
    inputBinding:
      position: 101
      prefix: intersect
  - id: kmers
    type:
      - 'null'
      - boolean
    doc: show k-mers/sequences matching the signature hashes
    inputBinding:
      position: 101
      prefix: kmers
  - id: manifest
    type:
      - 'null'
      - boolean
    doc: create a manifest for a collection of signatures
    inputBinding:
      position: 101
      prefix: manifest
  - id: merge
    type:
      - 'null'
      - boolean
    doc: merge one or more signatures
    inputBinding:
      position: 101
      prefix: merge
  - id: overlap
    type:
      - 'null'
      - boolean
    doc: see detailed comparison of signatures
    inputBinding:
      position: 101
      prefix: overlap
  - id: rename
    type:
      - 'null'
      - boolean
    doc: rename signature
    inputBinding:
      position: 101
      prefix: rename
  - id: split
    type:
      - 'null'
      - boolean
    doc: split signature files
    inputBinding:
      position: 101
      prefix: split
  - id: subtract
    type:
      - 'null'
      - boolean
    doc: subtract one or more signatures
    inputBinding:
      position: 101
      prefix: subtract
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
stdout: sourmash_sig.out
