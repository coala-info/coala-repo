cwlVersion: v1.2
class: CommandLineTool
baseCommand: cell-types-analysis_build_cell_ontology_dict.R
label: cell-types-analysis_build_cell_ontology_dict.R
doc: "A tool to build a cell ontology dictionary for cell types analysis.\n\nTool
  homepage: https://github.com/ebi-gene-expression-group/cell-types-analysis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cell-types-analysis:0.1.11--hdfd78af_1
stdout: cell-types-analysis_build_cell_ontology_dict.R.out
