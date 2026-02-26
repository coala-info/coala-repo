cwlVersion: v1.2
class: CommandLineTool
baseCommand: virmet_index
label: virmet_index
doc: "Builds indexes for various databases used by Virmet.\n\nTool homepage: https://github.com/medvir/VirMet"
inputs:
  - id: bact_fungal
    type:
      - 'null'
      - boolean
    doc: build kraken2 bacterial and fungal database
    inputBinding:
      position: 101
      prefix: --bact_fungal
  - id: bovine
    type:
      - 'null'
      - boolean
    doc: make bwa index of bovine database
    inputBinding:
      position: 101
      prefix: --bovine
  - id: dbdir
    type:
      - 'null'
      - Directory
    doc: path to store the indexed Virmet database
    inputBinding:
      position: 101
      prefix: --dbdir
  - id: human
    type:
      - 'null'
      - boolean
    doc: make bwa index of human database
    inputBinding:
      position: 101
      prefix: --human
  - id: viral
    type:
      - 'null'
      - string
    doc: make blast index of viral database. Accepts 'n' or 'p'.
    inputBinding:
      position: 101
      prefix: --viral
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virmet:2.0.1--pyhdfd78af_0
stdout: virmet_index.out
