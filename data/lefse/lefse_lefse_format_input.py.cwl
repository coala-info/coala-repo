cwlVersion: v1.2
class: CommandLineTool
baseCommand: lefse_format_input.py
label: lefse_lefse_format_input.py
doc: "Format a feature table (features on rows or columns, with class, subclass and subject rows) for LEfSe.\n\nTool homepage: https://github.com/SegataLab/lefse"
inputs:
  - id: input_file
    type: File
    doc: 'the input file, feature hierarchical level can be specified with | or . and those symbols must not be present for other reasons in the input file'
    inputBinding:
      position: 1
  - id: output_file
    type: string
    doc: 'the output file containing the data for LEfSe'
    inputBinding:
      position: 2
  - id: output_table
    type:
      - 'null'
      - string
    doc: 'the formatted table in txt format'
    inputBinding:
      position: 10
      prefix: --output_table
  - id: features_dir
    type:
      - 'null'
      - string
    doc: 'set whether the features are on rows (r, default) or on columns (c)'
    inputBinding:
      position: 10
      prefix: -f
  - id: class_row
    type:
      - 'null'
      - int
    doc: 'set which feature to use as class (default 1)'
    inputBinding:
      position: 10
      prefix: -c
  - id: subclass_row
    type:
      - 'null'
      - int
    doc: 'set which feature to use as subclass (default -1 meaning no subclass)'
    inputBinding:
      position: 10
      prefix: -s
  - id: norm_value
    type:
      - 'null'
      - float
    doc: 'set the normalization value (default -1.0 meaning no normalization)'
    inputBinding:
      position: 10
      prefix: -o
  - id: subject_row
    type:
      - 'null'
      - int
    doc: 'set which feature to use as subject (default -1 meaning no subject)'
    inputBinding:
      position: 10
      prefix: -u
  - id: missing_policy
    type:
      - 'null'
      - string
    doc: 'set the policy for missing values: f removes the features with missing values, s removes samples with missing values (default f)'
    inputBinding:
      position: 10
      prefix: -m
  - id: min_subclass_card
    type:
      - 'null'
      - int
    doc: 'set the minimum cardinality of each subclass'
    inputBinding:
      position: 10
      prefix: -n
  - id: biom_class
    type:
      - 'null'
      - string
    doc: 'For biom input files: set which feature to use as class'
    inputBinding:
      position: 10
      prefix: -biom_c
  - id: biom_subclass
    type:
      - 'null'
      - string
    doc: 'For biom input files: set which feature to use as subclass'
    inputBinding:
      position: 10
      prefix: -biom_s
outputs:
  - id: output_file_out
    type: File
    doc: 'The LEfSe formatted input file'
    outputBinding:
      glob: $(inputs.output_file)
  - id: table_output
    type: File?
    doc: 'The formatted table in txt format, written when output_table is set'
    outputBinding:
      glob: $(inputs.output_table)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lefse:1.1.2--pyhdfd78af_0
