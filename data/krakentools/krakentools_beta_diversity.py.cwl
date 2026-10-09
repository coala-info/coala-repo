cwlVersion: v1.2
class: CommandLineTool
baseCommand: beta_diversity.py
label: krakentools_beta_diversity.py
doc: "Calculate Bray-Curtis dissimilarity between communities from Bracken, Kraken report or Krona files.\n\nTool homepage: https://github.com/jenniferlu717/KrakenTools"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: "Input files (one per community) for which to compute Bray-Curtis dissimilarity"
    inputBinding:
      position: 1
      prefix: -i
  - id: type
    type:
      - 'null'
      - type: enum
        symbols: [single, simple, bracken, kreport, kreport2, krona]
    doc: "Type of input file[s]: single, simple, bracken, kreport, kreport2, krona"
    inputBinding:
      position: 101
      prefix: --type
  - id: cols
    type:
      - 'null'
      - string
    doc: "Category and counts columns separated by a single comma: cat,counts (1 = first column)"
    inputBinding:
      position: 101
      prefix: --cols
  - id: level
    type:
      - 'null'
      - type: enum
        symbols: [all, S, G, F, O]
    doc: "For Kraken or Krona files, taxonomy level for which to compare samples [default: all]"
    inputBinding:
      position: 101
      prefix: --level
outputs:
  - id: dissimilarity
    type: stdout
    doc: "Bray-Curtis dissimilarity matrix printed by the tool"
stdout: beta_diversity.txt
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krakentools:1.2.1--pyh7e72e81_0
