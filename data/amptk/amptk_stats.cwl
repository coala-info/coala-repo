cwlVersion: v1.2
class: CommandLineTool
baseCommand: amptk-stats.py
label: amptk_stats
doc: "Script takes BIOM as input and runs basic summary stats\n\nTool homepage: https://github.com/nextgenusfs/amptk"
inputs:
  - id: biom_file
    type: File
    doc: Input BIOM file (OTU table + metadata)
    inputBinding:
      position: 101
      prefix: --biom
  - id: distance
    type:
      - 'null'
      - string
    doc: Distance metric
    default: raupcrick
    inputBinding:
      position: 101
      prefix: --distance
  - id: ignore_otus
    type:
      - 'null'
      - type: array
        items: string
    doc: OTUs to drop from table and run stats
    default: None
    inputBinding:
      position: 101
      prefix: --ignore_otus
  - id: indicator_species
    type:
      - 'null'
      - boolean
    doc: Run indicator species analysis
    default: false
    inputBinding:
      position: 101
      prefix: --indicator_species
  - id: ord_ellipse
    type:
      - 'null'
      - boolean
    doc: Add ellipses on NMDS instead of centroids & error bars
    default: false
    inputBinding:
      position: 101
      prefix: --ord_ellipse
  - id: ord_method
    type:
      - 'null'
      - string
    doc: Ordination method
    default: NMDS
    inputBinding:
      position: 101
      prefix: --ord_method
  - id: out
    type:
      - 'null'
      - Directory
    doc: Output folder basename
    default: amptk_stats
    inputBinding:
      position: 101
      prefix: --out
  - id: tree
    type: File
    doc: Phylogentic tree from AMPtk taxonomy
    inputBinding:
      position: 101
      prefix: --tree
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
stdout: amptk_stats.out
