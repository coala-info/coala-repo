cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - check_labels.R
label: cell-types-analysis_check_labels.R
doc: "Clean the cell labels of a metadata file: remove non-alphanumeric characters
  and set the labels to lower case unless told not to\n\nTool homepage: https://github.com/ebi-gene-expression-group/cell-types-analysis"
inputs:
  - id: input_file
    type: File
    doc: Path to input metadata file in .tsv format
    inputBinding:
      position: 101
      prefix: --input-file
  - id: label_field
    type: string
    doc: Name of label field in metadata file
    inputBinding:
      position: 101
      prefix: --label-field
  - id: condensed
    type:
      - 'null'
      - boolean
    doc: 'Is the provided metadata file in condensed format? Default: False'
    inputBinding:
      position: 101
      prefix: --condensed
  - id: attribute_type_col_num
    type:
      - 'null'
      - int
    doc: 'Number of the attribute type field in condensed metadata file. Default:
      5'
    inputBinding:
      position: 101
      prefix: --attribute-type-col-num
  - id: variable_col_num
    type:
      - 'null'
      - int
    doc: 'Number of the label field in condensed metadata file. Default: 6'
    inputBinding:
      position: 101
      prefix: --variable-col-num
  - id: avoid_lowercase
    type:
      - 'null'
      - boolean
    doc: 'Should setting the labels to lowercase be skipped? Default: False'
    inputBinding:
      position: 101
      prefix: --avoid-lowercase
  - id: output_path_name
    type: string
    doc: Output for updated file
    inputBinding:
      position: 102
      prefix: --output-path
outputs:
  - id: output_file
    type: File
    doc: Updated metadata file with cleaned labels
    outputBinding:
      glob: $(inputs.output_path_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cell-types-analysis:0.1.11--hdfd78af_1
