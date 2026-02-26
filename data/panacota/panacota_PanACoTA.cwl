cwlVersion: v1.2
class: CommandLineTool
baseCommand: PanACoTA
label: panacota_PanACoTA
doc: "Large scale comparative genomics tools\n\nTool homepage: https://github.com/gem-pasteur/PanACoTA"
inputs:
  - id: subcommand
    type: string
    doc: 'Subcommand to run. Available options: all, prepare, annotate, pangenome,
      corepers, align, tree'
    inputBinding:
      position: 1
  - id: subcommand_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the selected subcommand
    inputBinding:
      position: 2
  - id: align
    type:
      - 'null'
      - boolean
    doc: Align Core/Persistent families
    inputBinding:
      position: 103
      prefix: align
  - id: all
    type:
      - 'null'
      - boolean
    doc: Run all PanACoTA modules
    inputBinding:
      position: 103
      prefix: all
  - id: annotate
    type:
      - 'null'
      - boolean
    doc: Quality control and annotation of genomes
    inputBinding:
      position: 103
      prefix: annotate
  - id: corepers
    type:
      - 'null'
      - boolean
    doc: Compute a Core or Persistent genome of your dataset
    inputBinding:
      position: 103
      prefix: corepers
  - id: pangenome
    type:
      - 'null'
      - boolean
    doc: Generate a pan-genome of your dataset
    inputBinding:
      position: 103
      prefix: pangenome
  - id: prepare
    type:
      - 'null'
      - boolean
    doc: Prepare draft dataset
    inputBinding:
      position: 103
      prefix: prepare
  - id: tree
    type:
      - 'null'
      - boolean
    doc: Infer phylogenetic tree based on core/persistent genome
    inputBinding:
      position: 103
      prefix: tree
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panacota:1.4.0--pyhdfd78af_0
stdout: panacota_PanACoTA.out
