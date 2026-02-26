cwlVersion: v1.2
class: CommandLineTool
baseCommand: gempipe
label: gempipe
doc: "gempipe v1.38.5. Full documentation available at\nhttps://gempipe.readthedocs.io/en/latest/index.html.
  Please cite: \"Lazzari G.,\nFelis G. E., Salvetti E., Calgaro M., Di Cesare F.,
  Teusink B., Vitulo N.\nGempipe: a tool for drafting, curating, and analyzing pan
  and multi-strain\ngenome-scale metabolic models. mSystems. December 2025.\nhttps://doi.org/10.1128/msystems.01007-25\"\
  .\n\nTool homepage: https://github.com/lazzarigioele/gempipe"
inputs:
  - id: subcommand
    type: string
    doc: gempipe subcommands
    inputBinding:
      position: 1
  - id: autopilot
    type:
      - 'null'
      - boolean
    doc: "Run recon + derive, with automated pan-model gap-\nfilling. Use with consciousness!"
    inputBinding:
      position: 102
  - id: derive
    type:
      - 'null'
      - boolean
    doc: Derive strain- and species-specific models.
    inputBinding:
      position: 102
  - id: recon
    type:
      - 'null'
      - boolean
    doc: Reconstruct a draft pan-model and a PAM.
    inputBinding:
      position: 102
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gempipe:1.38.5--pyhdfd78af_0
stdout: gempipe.out
