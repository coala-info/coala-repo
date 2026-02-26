cwlVersion: v1.2
class: CommandLineTool
baseCommand: gempipe recon
label: gempipe_recon
doc: "gempipe v1.38.5. Full documentation available at\nhttps://gempipe.readthedocs.io/en/latest/index.html.
  Please cite: \"Lazzari G.,\nFelis G. E., Salvetti E., Calgaro M., Di Cesare F.,
  Teusink B., Vitulo N.\nGempipe: a tool for drafting, curating, and analyzing pan
  and multi-strain\ngenome-scale metabolic models. mSystems. December 2025.\nhttps://doi.org/10.1128/msystems.01007-25\"\
  .\n\nTool homepage: https://github.com/lazzarigioele/gempipe"
inputs:
  - id: N50
    type:
      - 'null'
      - int
    doc: Minimum N50 allowed per genome.
    default: 50000
    inputBinding:
      position: 101
      prefix: --N50
  - id: buscoF
    type:
      - 'null'
      - string
    doc: "Maximum number of fragmented Busco's single copy\n                     \
      \   orthologs (absolute or percentage)."
    default: 100%
    inputBinding:
      position: 101
      prefix: --buscoF
  - id: buscoM
    type:
      - 'null'
      - string
    doc: "Maximum number of missing Busco's single copy\n                        orthologs
      (absolute or percentage)."
    default: 2%
    inputBinding:
      position: 101
      prefix: --buscoM
  - id: buscodb
    type:
      - 'null'
      - string
    doc: "Busco database to use ('show' to see the list of\n                     \
      \   available databases)."
    default: bacteria_odb10
    inputBinding:
      position: 101
      prefix: --buscodb
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of parallel processes to use.
    default: 1
    inputBinding:
      position: 101
      prefix: --cores
  - id: coverage
    type:
      - 'null'
      - int
    doc: "Minimum percentage coverage to use when aligning\n                     \
      \   against the BiGG gene database."
    default: 70
    inputBinding:
      position: 101
      prefix: --coverage
  - id: dbmem
    type:
      - 'null'
      - boolean
    doc: "Load the entire eggNOG-mapper database into memory\n                   \
      \     (should speed up the functional annotation step)."
    default: false
    inputBinding:
      position: 101
      prefix: --dbmem
  - id: dbs
    type:
      - 'null'
      - Directory
    doc: "Path were the needed databases are stored (or\n                        downloaded
      if not already existing)."
    default: ./working/dbs/
    inputBinding:
      position: 101
      prefix: --dbs
  - id: dedup
    type:
      - 'null'
      - boolean
    doc: "Try to remove duplicate metabolites and reactions\n                    \
      \    using MNX annotation, when a reference is provided."
    default: false
    inputBinding:
      position: 101
      prefix: --dedup
  - id: genbanks
    type:
      - 'null'
      - type: array
        items: File
    doc: "Input genbank files (.gb, .gbff) or folder containing\n                \
      \        the genbanks (see documentation)."
    default: '-'
    inputBinding:
      position: 101
      prefix: --genbanks
  - id: genomes
    type:
      - 'null'
      - type: array
        items: File
    doc: "Input genome files or folder containing the genomes\n                  \
      \      (see documentation)."
    default: '-'
    inputBinding:
      position: 101
      prefix: --genomes
  - id: identity
    type:
      - 'null'
      - int
    doc: "Minimum percentage amino acidic sequence identity to\n                 \
      \       use when aligning against the BiGG gene database."
    default: 30
    inputBinding:
      position: 101
      prefix: --identity
  - id: mancor
    type:
      - 'null'
      - string
    doc: "Manual corrections to apply during the reference\n                     \
      \   expansion."
    default: '-'
    inputBinding:
      position: 101
      prefix: --mancor
  - id: metadata
    type:
      - 'null'
      - File
    doc: Table for manual correction of genome metadata.
    default: '-'
    inputBinding:
      position: 101
      prefix: --metadata
  - id: ncontigs
    type:
      - 'null'
      - int
    doc: Maximum number of contigs allowed per genome.
    default: 200
    inputBinding:
      position: 101
      prefix: --ncontigs
  - id: nofig
    type:
      - 'null'
      - boolean
    doc: Skip the generation of figures.
    default: false
    inputBinding:
      position: 101
      prefix: --nofig
  - id: norec
    type:
      - 'null'
      - boolean
    doc: Skip gene recovery when starting from genomes.
    default: false
    inputBinding:
      position: 101
      prefix: --norec
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: "Main output directory (will be created if not\n                        existing)."
    default: ./
    inputBinding:
      position: 101
      prefix: --outdir
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Delete the working/ directory at the startup.
    default: false
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: proteomes
    type:
      - 'null'
      - type: array
        items: File
    doc: "Input proteome files or folder containing the\n                        proteomes
      (see documentation)."
    default: '-'
    inputBinding:
      position: 101
      prefix: --proteomes
  - id: refmodel
    type:
      - 'null'
      - string
    doc: Model to be used as reference.
    default: '-'
    inputBinding:
      position: 101
      prefix: --refmodel
  - id: refproteome
    type:
      - 'null'
      - File
    doc: Proteome to be used as reference.
    default: '-'
    inputBinding:
      position: 101
      prefix: --refproteome
  - id: refspont
    type:
      - 'null'
      - string
    doc: Reference gene marking spontaneous reactions.
    default: spontaneous
    inputBinding:
      position: 101
      prefix: --refspont
  - id: sbml
    type:
      - 'null'
      - boolean
    doc: "Save the output GSMMs in SBML format (L3V1 FBC2) in\n                  \
      \      addition to JSON."
    default: false
    inputBinding:
      position: 101
      prefix: --sbml
  - id: staining
    type:
      - 'null'
      - string
    doc: Gram staining, 'pos' or 'neg'.
    default: neg
    inputBinding:
      position: 101
      prefix: --staining
  - id: taxids
    type:
      - 'null'
      - string
    doc: "Taxids of the species to model (comma separated, for\n                 \
      \       example '252393,68334')."
    default: '-'
    inputBinding:
      position: 101
      prefix: --taxids
  - id: tcdb
    type:
      - 'null'
      - boolean
    doc: "Experimental feature: try to build transport reactions\n               \
      \         using TCDB."
    default: false
    inputBinding:
      position: 101
      prefix: --tcdb
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Make stdout messages more verbose, including debug\n                   \
      \     messages."
    default: false
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gempipe:1.38.5--pyhdfd78af_0
stdout: gempipe_recon.out
