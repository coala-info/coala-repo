cwlVersion: v1.2
class: CommandLineTool
baseCommand: gempipe autopilot
label: gempipe_autopilot
doc: "gempipe v1.38.5. Full documentation available at\nhttps://gempipe.readthedocs.io/en/latest/index.html.
  Please cite: \"Lazzari G.,\nFelis G. E., Salvetti E., Calgaro M., Di Cesare F.,
  Teusink B., Vitulo N.\nGempipe: a tool for drafting, curating, and analyzing pan
  and multi-strain\ngenome-scale metabolic models. mSystems. December 2025.\nhttps://doi.org/10.1128/msystems.01007-25\"\
  .\n\nTool homepage: https://github.com/lazzarigioele/gempipe"
inputs:
  - id: aux
    type:
      - 'null'
      - boolean
    doc: Test auxotrophies for aminoacids and vitamins.
    inputBinding:
      position: 101
      prefix: --aux
  - id: biolog
    type:
      - 'null'
      - boolean
    doc: "Simulate Biolog's utilization tests on strain-specific\nmodels."
    inputBinding:
      position: 101
      prefix: --biolog
  - id: biosynth
    type:
      - 'null'
      - float
    doc: "Check biosynthesis of each metabolite while granting\nthe specified minimum
      fraction of objective. If 0,\nthis step will be skipped."
    inputBinding:
      position: 101
      prefix: --biosynth
  - id: busco_f
    type:
      - 'null'
      - string
    doc: "Maximum number of fragmented Busco's single copy\northologs (absolute or
      percentage)."
    inputBinding:
      position: 101
      prefix: --buscoF
  - id: busco_m
    type:
      - 'null'
      - string
    doc: "Maximum number of missing Busco's single copy\northologs (absolute or percentage)."
    inputBinding:
      position: 101
      prefix: --buscoM
  - id: buscodb
    type:
      - 'null'
      - string
    doc: "Busco database to use ('show' to see the list of\navailable databases)."
    inputBinding:
      position: 101
      prefix: --buscodb
  - id: cnps
    type:
      - 'null'
      - boolean
    doc: "Sistematically simulate growth on all the available\nC-N-P-S sources."
    inputBinding:
      position: 101
      prefix: --cnps
  - id: cnps_minmed
    type:
      - 'null'
      - float
    doc: "Base the C-N-P-S simulations on a minimal medium\nleading to the specified
      minimum objective value. If\n0, user-defined medium will be used."
    inputBinding:
      position: 101
      prefix: --cnps_minmed
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of parallel processes to use.
    inputBinding:
      position: 101
      prefix: --cores
  - id: coverage
    type:
      - 'null'
      - int
    doc: "Minimum percentage coverage to use when aligning\nagainst the BiGG gene
      database."
    inputBinding:
      position: 101
      prefix: --coverage
  - id: dbmem
    type:
      - 'null'
      - boolean
    doc: "Load the entire eggNOG-mapper database into memory\n(should speed up the
      functional annotation step)."
    inputBinding:
      position: 101
      prefix: --dbmem
  - id: dbs
    type:
      - 'null'
      - Directory
    doc: "Path were the needed databases are stored (or\ndownloaded if not already
      existing)."
    inputBinding:
      position: 101
      prefix: --dbs
  - id: dedup
    type:
      - 'null'
      - boolean
    doc: "Try to remove duplicate metabolites and reactions\nusing MNX annotation,
      when a reference is provided."
    inputBinding:
      position: 101
      prefix: --dedup
  - id: genbanks
    type:
      - 'null'
      - type: array
        items: File
    doc: "Input genbank files (.gb, .gbff) or folder containing\nthe genbanks (see
      documentation)."
    inputBinding:
      position: 101
      prefix: --genbanks
  - id: genomes
    type:
      - 'null'
      - type: array
        items: File
    doc: "Input genome files or folder containing the genomes\n(see documentation)."
    inputBinding:
      position: 101
      prefix: --genomes
  - id: identity
    type:
      - 'null'
      - int
    doc: "Minimum percentage amino acidic sequence identity to\nuse when aligning
      against the BiGG gene database."
    inputBinding:
      position: 101
      prefix: --identity
  - id: mancor
    type:
      - 'null'
      - string
    doc: "Manual corrections to apply during the reference\nexpansion."
    inputBinding:
      position: 101
      prefix: --mancor
  - id: media
    type:
      - 'null'
      - type: array
        items: File
    doc: "Medium definition file or folder containing media\ndefinitions, to be used
      during the automatic gap-\nfilling."
    inputBinding:
      position: 101
      prefix: --media
  - id: metadata
    type:
      - 'null'
      - File
    doc: Table for manual correction of genome metadata.
    inputBinding:
      position: 101
      prefix: --metadata
  - id: minflux
    type:
      - 'null'
      - float
    doc: "Minimum flux through the objective of strain-specific\nmodels."
    inputBinding:
      position: 101
      prefix: --minflux
  - id: minpanflux
    type:
      - 'null'
      - float
    doc: Minimum flux through the objective of the pan model.
    inputBinding:
      position: 101
      prefix: --minpanflux
  - id: n50
    type:
      - 'null'
      - int
    doc: Minimum N50 allowed per genome.
    inputBinding:
      position: 101
      prefix: --N50
  - id: ncontigs
    type:
      - 'null'
      - int
    doc: Maximum number of contigs allowed per genome.
    inputBinding:
      position: 101
      prefix: --ncontigs
  - id: nofig
    type:
      - 'null'
      - boolean
    doc: Skip the generation of figures.
    inputBinding:
      position: 101
      prefix: --nofig
  - id: norec
    type:
      - 'null'
      - boolean
    doc: Skip gene recovery when starting from genomes.
    inputBinding:
      position: 101
      prefix: --norec
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: "Main output directory (will be created if not\nexisting)."
    inputBinding:
      position: 101
      prefix: --outdir
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Delete the working/ directory at the startup.
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: proteomes
    type:
      - 'null'
      - type: array
        items: File
    doc: "Input proteome files or folder containing the\nproteomes (see documentation)."
    inputBinding:
      position: 101
      prefix: --proteomes
  - id: refmodel
    type:
      - 'null'
      - string
    doc: Model to be used as reference.
    inputBinding:
      position: 101
      prefix: --refmodel
  - id: refproteome
    type:
      - 'null'
      - string
    doc: Proteome to be used as reference.
    inputBinding:
      position: 101
      prefix: --refproteome
  - id: refspont
    type:
      - 'null'
      - string
    doc: Reference gene marking spontaneous reactions.
    inputBinding:
      position: 101
      prefix: --refspont
  - id: sbml
    type:
      - 'null'
      - boolean
    doc: "Save the output GSMMs in SBML format (L3V1 FBC2) in\naddition to JSON."
    inputBinding:
      position: 101
      prefix: --sbml
  - id: staining
    type:
      - 'null'
      - string
    doc: Gram staining, 'pos' or 'neg'.
    inputBinding:
      position: 101
      prefix: --staining
  - id: taxids
    type:
      - 'null'
      - string
    doc: "Taxids of the species to model (comma separated, for\nexample '252393,68334')."
    inputBinding:
      position: 101
      prefix: --taxids
  - id: tcdb
    type:
      - 'null'
      - boolean
    doc: "Experimental feature: try to build transport reactions\nusing TCDB."
    inputBinding:
      position: 101
      prefix: --tcdb
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Make stdout messages more verbose, including debug\nmessages."
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
stdout: gempipe_autopilot.out
