cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - omamer
  - mkdb
label: omamer_mkdb
doc: "Build a database, by providing an OMA HDF5 database file [BROWSERBUILD] or\n\
  OrthoXML + FASTA + Newick files [OXMLBUILD].\n\nTool homepage: https://github.com/DessimozLab/omamer"
inputs:
  - id: db
    type: File
    doc: Path to new database (including filename).
    inputBinding:
      position: 101
      prefix: --db
  - id: hidden_taxa
    type:
      - 'null'
      - File
    doc: "Optional -- path to a file giving a list of taxa to\n                  \
      \      hide the proteins during index creation only. HOGs\n                \
      \        will still exist in the database, but it will not be\n            \
      \            possible to place to them. Names must match EXACTLY to\n      \
      \                  those in the given newick species tree."
    default: None
    inputBinding:
      position: 101
      prefix: --hidden_taxa
  - id: k
    type:
      - 'null'
      - int
    doc: k-mer length
    default: 6
    inputBinding:
      position: 101
      prefix: --k
  - id: log_level
    type:
      - 'null'
      - string
    doc: Logging level.
    default: info
    inputBinding:
      position: 101
      prefix: --log_level
  - id: logic
    type:
      - 'null'
      - string
    doc: "Logic used between the two above arguments to filter\n                 \
      \       root-HOGs. Options are AND or OR."
    default: OR
    inputBinding:
      position: 101
      prefix: --logic
  - id: min_fam_completeness
    type:
      - 'null'
      - float
    doc: "Only root-HOGs passing this threshold are used. The\n                  \
      \      completeness of a HOG is defined as the number of\n                 \
      \       observed species divided by the expected number of\n               \
      \         species at the HOG taxonomic level"
    default: 0.5
    inputBinding:
      position: 101
      prefix: --min_fam_completeness
  - id: min_fam_size
    type:
      - 'null'
      - int
    doc: "Only root-HOGs with a protein count passing this\n                     \
      \   threshold are used."
    default: 6
    inputBinding:
      position: 101
      prefix: --min_fam_size
  - id: nthreads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 1
    inputBinding:
      position: 101
      prefix: --nthreads
  - id: oma_path
    type:
      - 'null'
      - Directory
    doc: "Path to OMA browser release (must include OmaServer.h5\n               \
      \         and speciestree.nwk). [BROWSERBUILD]"
    default: None
    inputBinding:
      position: 101
      prefix: --oma_path
  - id: orthoxml
    type:
      - 'null'
      - File
    doc: Path to OrthoXML file containing HOGs. [OXMLBUILD]
    default: None
    inputBinding:
      position: 101
      prefix: --orthoxml
  - id: reduced_alphabet
    type:
      - 'null'
      - boolean
    doc: Use reduced alphabet from Linclust paper.
    default: false
    inputBinding:
      position: 101
      prefix: --reduced_alphabet
  - id: root_taxon
    type:
      - 'null'
      - string
    doc: "HOGs defined at, or descending from, this taxon are\n                  \
      \      uses as root-HOGs. Default is the top level in species\n            \
      \            tree."
    default: None
    inputBinding:
      position: 101
      prefix: --root_taxon
  - id: sequences
    type:
      - 'null'
      - type: array
        items: File
    doc: "Paths to sequence files (1 or multiple, only for non-\n                \
      \        browser build). [OXMLBUILD]"
    default: None
    inputBinding:
      position: 101
      prefix: --sequences
  - id: species_tree
    type:
      - 'null'
      - File
    doc: "Path to newick file containing species tree.\n                        [OXMLBUILD]"
    default: None
    inputBinding:
      position: 101
      prefix: --species_tree
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/omamer:2.1.2--pyhdfd78af_0
stdout: omamer_mkdb.out
