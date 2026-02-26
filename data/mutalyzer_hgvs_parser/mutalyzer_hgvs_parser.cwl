cwlVersion: v1.2
class: CommandLineTool
baseCommand: mutalyzer_hgvs_parser
label: mutalyzer_hgvs_parser
doc: "Mutalyzer HGVS variant description parser.\n\nTool homepage: The package home
  page"
inputs:
  - id: description
    type: string
    doc: the HGVS variant description to be parsed
    inputBinding:
      position: 1
  - id: alternative_grammar_file
    type:
      - 'null'
      - File
    doc: alternative input grammar file path (do not use with -c)
    inputBinding:
      position: 102
      prefix: -g
  - id: alternative_start_rule
    type:
      - 'null'
      - string
    doc: alternative start (top) rule for the grammar
    inputBinding:
      position: 102
      prefix: -r
  - id: convert_to_model
    type:
      - 'null'
      - boolean
    doc: convert the description to the model
    inputBinding:
      position: 102
      prefix: -c
  - id: raw_parse_tree
    type:
      - 'null'
      - boolean
    doc: raw parse tree (no ambiguity solving)
    inputBinding:
      position: 102
      prefix: -p
  - id: show_version
    type:
      - 'null'
      - boolean
    doc: show program's version number and exit
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: save_parse_tree_as_png
    type:
      - 'null'
      - File
    doc: save the parse tree as a PNG image (pydot required!)
    outputBinding:
      glob: $(inputs.save_parse_tree_as_png)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mutalyzer_hgvs_parser:0.3.9--pyh7e72e81_0
