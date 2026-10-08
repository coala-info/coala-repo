cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sourmash
  - index
label: sourmash_index
doc: 'Create an on-disk database of signatures that can be searched quickly & in low memory. All signatures
  must be scaled, and must be the same k-mer size and molecule type; the standard signature selectors
  (-k/--ksize, --scaled, --dna/--protein) choose which signatures to be added.


  Tool homepage: https://github.com/sourmash-bio/sourmash'
inputs:
  - id: index_name
    type: string
    doc: name to save index under; defaults to {name}.sbt.zip
    inputBinding:
      position: 1
  - id: signatures
    type:
      type: array
      items: File
    doc: signatures to load into SBT
    inputBinding:
      position: 2
  - id: append
    type:
      - 'null'
      - boolean
    doc: add signatures to an existing SBT
    inputBinding:
      position: 103
      prefix: --append
  - id: bf_size
    type:
      - 'null'
      - string
    doc: Bloom filter size used for internal nodes
    inputBinding:
      position: 103
      prefix: --bf-size
  - id: dayhoff
    type:
      - 'null'
      - boolean
    doc: choose Dayhoff-encoded amino acid signatures
    inputBinding:
      position: 103
      prefix: --dayhoff
  - id: force
    type:
      - 'null'
      - boolean
    doc: try loading *all* files in provided subdirectories, not just .sig files
    inputBinding:
      position: 103
      prefix: --force
  - id: from_file
    type:
      - 'null'
      - File
    doc: a text file containing a list of files to load signatures from
    inputBinding:
      position: 103
      prefix: --from-file
  - id: hydrophobic_polar
    type:
      - 'null'
      - boolean
    doc: choose hydrophobic-polar-encoded amino acid signatures
    inputBinding:
      position: 103
      prefix: --hydrophobic-polar
  - id: index_type
    type:
      - 'null'
      - string
    doc: 'type of index to build (default: SBT)'
    inputBinding:
      position: 103
      prefix: --index-type
  - id: ksize
    type:
      - 'null'
      - int
    doc: k-mer size to select; no default.
    inputBinding:
      position: 103
      prefix: --ksize
  - id: n_children
    type:
      - 'null'
      - int
    doc: number of children for internal nodes; default=2
    inputBinding:
      position: 103
      prefix: --n_children
  - id: no_dayhoff
    type:
      - 'null'
      - boolean
    doc: do not choose Dayhoff-encoded amino acid signatures
    inputBinding:
      position: 103
      prefix: --no-dayhoff
  - id: no_hydrophobic_polar
    type:
      - 'null'
      - boolean
    doc: do not choose hydrophobic-polar-encoded amino acid signatures
    inputBinding:
      position: 103
      prefix: --no-hp
  - id: no_nucleotide
    type:
      - 'null'
      - boolean
    doc: do not choose a nucleotide signature
    inputBinding:
      position: 103
      prefix: --no-dna
  - id: no_protein
    type:
      - 'null'
      - boolean
    doc: do not choose a protein signature
    inputBinding:
      position: 103
      prefix: --no-protein
  - id: no_skipmer_m1n3
    type:
      - 'null'
      - boolean
    doc: do not choose skipmer (m1n3) signatures
    inputBinding:
      position: 103
      prefix: --no-skipm1n3
  - id: no_skipmer_m2n3
    type:
      - 'null'
      - boolean
    doc: do not choose skipmer (m2n3) signatures
    inputBinding:
      position: 103
      prefix: --no-skipm2n3
  - id: nucleotide
    type:
      - 'null'
      - boolean
    doc: 'choose a nucleotide signature (default: True)'
    inputBinding:
      position: 103
      prefix: --dna
  - id: picklist
    type:
      - 'null'
      - string
    doc: select signatures based on a picklist, i.e. 'file.csv:colname:coltype'
    inputBinding:
      position: 103
      prefix: --picklist
  - id: picklist_require_all
    type:
      - 'null'
      - boolean
    doc: require that all picklist values be found or else fail
    inputBinding:
      position: 103
      prefix: --picklist-require-all
  - id: protein
    type:
      - 'null'
      - boolean
    doc: choose a protein signature; by default, a nucleotide signature is used
    inputBinding:
      position: 103
      prefix: --protein
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: suppress non-error output
    inputBinding:
      position: 103
      prefix: --quiet
  - id: scaled
    type:
      - 'null'
      - float
    doc: downsample to this scaled; value should be between 100 and 1e6
    inputBinding:
      position: 103
      prefix: --scaled
  - id: skipmer_m1n3
    type:
      - 'null'
      - boolean
    doc: choose skipmer (m1n3) signatures
    inputBinding:
      position: 103
      prefix: --skipm1n3
  - id: skipmer_m2n3
    type:
      - 'null'
      - boolean
    doc: choose skipmer (m2n3) signatures
    inputBinding:
      position: 103
      prefix: --skipm2n3
  - id: sparseness
    type:
      - 'null'
      - float
    doc: What percentage of internal nodes will not be saved; ranges from 0.0 (save all nodes) to 1.0
      (no nodes saved)
    inputBinding:
      position: 103
      prefix: --sparseness
outputs:
  - id: index
    type:
      type: array
      items: File
    doc: index file written by sourmash (name.sbt.zip, or the name given)
    outputBinding:
      glob:
        - $(inputs.index_name)
        - $(inputs.index_name).sbt.zip
  - id: sbt_storage
    type:
      type: array
      items: Directory
    doc: hidden storage folder (.sbt.<name>) written for SBT indexes named *.sbt.json
    outputBinding:
      glob: .sbt.*
  - id: log
    type: stderr
    doc: Standard error (progress messages)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
stderr: sourmash_index.log.txt
