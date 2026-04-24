cwlVersion: v1.2
class: CommandLineTool
baseCommand: build_cell_ontology_dict.R
label: cell-types-analysis_build_cell_ontology_dict.R
doc: "Builds a dictionary mapping cell labels to cell ontology terms from SDRF files.\n\
  \nTool homepage: https://github.com/ebi-gene-expression-group/cell-types-analysis"
inputs:
  - id: barcode_col_name
    type:
      - 'null'
      - string
    doc: Name of the barcode column in SDRF files (must be identical across all 
      files)
    inputBinding:
      position: 101
      prefix: --barcode-col-name
  - id: cell_label_col_name
    type:
      - 'null'
      - string
    doc: Name of the cell label column in SDRF files (must be identical across 
      all files)
    inputBinding:
      position: 101
      prefix: --cell-label-col-name
  - id: cell_ontology_col_name
    type:
      - 'null'
      - string
    doc: Name of the cell ontology terms column in SDRF files (must be identical
      across all files)
    inputBinding:
      position: 101
      prefix: --cell-ontology-col-name
  - id: condensed_sdrf
    type:
      - 'null'
      - boolean
    doc: is the provided SDRF file in a condensed form?
    inputBinding:
      position: 101
      prefix: --condensed-sdrf
  - id: input_dir
    type:
      - 'null'
      - Directory
    doc: Path to the directory with condensed SDRF files
    inputBinding:
      position: 101
      prefix: --input-dir
outputs:
  - id: output_dict_path
    type:
      - 'null'
      - File
    doc: Output path for serialised object containing the dictionary
    outputBinding:
      glob: $(inputs.output_dict_path)
  - id: output_text_path
    type:
      - 'null'
      - File
    doc: Output path for txt version of label - term mapping
    outputBinding:
      glob: $(inputs.output_text_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cell-types-analysis:0.1.11--hdfd78af_1
