cwlVersion: v1.2
class: CommandLineTool
baseCommand: gempipe derive
label: gempipe_derive
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
    doc: "Simulate Biolog's utilization tests on strain-specific\n               \
      \        models."
    inputBinding:
      position: 101
      prefix: --biolog
  - id: biosynth
    type:
      - 'null'
      - float
    doc: "Check biosynthesis of each metabolite while granting\n                 \
      \      the specified minimum fraction of objective. If 0, this\n           \
      \            step will be skipped."
    inputBinding:
      position: 101
      prefix: --biosynth
  - id: cnps
    type:
      - 'null'
      - boolean
    doc: "Sistematically simulate growth on all the available\n                  \
      \     C-N-P-S sources."
    inputBinding:
      position: 101
      prefix: --cnps
  - id: cnps_minmed
    type:
      - 'null'
      - float
    doc: "Base the C-N-P-S simulations on a minimal medium\n                     \
      \  leading to the specified minimum objective value. If 0,\n               \
      \        user-defined medium will be used."
    inputBinding:
      position: 101
      prefix: --cnps_minmed
  - id: cores
    type:
      - 'null'
      - int
    doc: How many parallel processes to use.
    inputBinding:
      position: 101
      prefix: --cores
  - id: ingannots
    type:
      - 'null'
      - File
    doc: Path to the input genes annotation file.
    inputBinding:
      position: 101
      prefix: --ingannots
  - id: inpam
    type:
      - 'null'
      - File
    doc: Path to the input PAM.
    inputBinding:
      position: 101
      prefix: --inpam
  - id: inpanmodel
    type:
      - 'null'
      - File
    doc: Path to the input pan-model.
    inputBinding:
      position: 101
      prefix: --inpanmodel
  - id: inreport
    type:
      - 'null'
      - File
    doc: Path to the input report file.
    inputBinding:
      position: 101
      prefix: --inreport
  - id: media
    type:
      - 'null'
      - File
    doc: "Medium definition file or folder containing media\n                    \
      \   definitions, to be used during the automatic gap-\n                    \
      \   filling."
    inputBinding:
      position: 101
      prefix: --media
  - id: minflux
    type:
      - 'null'
      - float
    doc: "Minimum flux through the objective of strain-specific\n                \
      \       models."
    inputBinding:
      position: 101
      prefix: --minflux
  - id: nofig
    type:
      - 'null'
      - boolean
    doc: Skip the generation of figures.
    inputBinding:
      position: 101
      prefix: --nofig
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: "Main output directory (will be created if not\n                       existing)."
    inputBinding:
      position: 101
      prefix: --outdir
  - id: sbml
    type:
      - 'null'
      - boolean
    doc: "Save the output GSMMs in SBML format (L3V1 FBC2) in\n                  \
      \     addition to JSON."
    inputBinding:
      position: 101
      prefix: --sbml
  - id: skipgf
    type:
      - 'null'
      - boolean
    doc: "Skip the gap-filling step applied to the strain-\n                     \
      \  specific models."
    inputBinding:
      position: 101
      prefix: --skipgf
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Make stdout messages more verbose, including debug\n                   \
      \    messages."
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
stdout: gempipe_derive.out
