cwlVersion: v1.2
class: CommandLineTool
baseCommand: isa2w4m.py
label: isa2w4m
doc: "Script for extracting assays from ISATab data and outputing in W4M format.\n\
  \nTool homepage: https://github.com/workflow4metabolomics/isa2w4m"
inputs:
  - id: all_assays
    type:
      - 'null'
      - boolean
    doc: Extract all assays.
    inputBinding:
      position: 101
      prefix: -a
  - id: assay_filename
    type:
      - 'null'
      - string
    doc: "Filename of the assay to extract. If unset, the first\n                \
      \        assay of the chosen study will be used."
    inputBinding:
      position: 101
      prefix: -f
  - id: input_dir
    type: Directory
    doc: Input directory containing the ISA-Tab files.
    inputBinding:
      position: 101
      prefix: -i
  - id: matrix_output
    type:
      - 'null'
      - string
    doc: "Output file for sample x variable matrix. You can use\n                \
      \        it as a template, where %s will be replaced by the\n              \
      \          study name and %a by the assay filename. Default is\n           \
      \             \"%s-%a-sample-variable-matrix.tsv\"."
    default: '"%s-%a-sample-variable-matrix.tsv"'
    inputBinding:
      position: 101
      prefix: -m
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Set output directory. Default is "."
    default: '"."'
    inputBinding:
      position: 101
      prefix: -d
  - id: samp_na_filtering
    type:
      - 'null'
      - string
    doc: "Filter out NA values in the specified sample metadata\n                \
      \        columns. The value is a comma separated list of column\n          \
      \              names."
    inputBinding:
      position: 101
      prefix: -S
  - id: sample_output
    type:
      - 'null'
      - string
    doc: "Output file for sample metadata. You can use it as a\n                 \
      \       template, where %s will be replaced by the study name\n            \
      \            and %a by the assay filename. Default is\n                    \
      \    \"%s-%a-sample-metadata.tsv\"."
    default: '"%s-%a-sample-metadata.tsv"'
    inputBinding:
      position: 101
      prefix: -s
  - id: study_filename
    type:
      - 'null'
      - string
    doc: "Filename of the study to extract. If unset, the first\n                \
      \        study found will be used."
    inputBinding:
      position: 101
      prefix: -n
  - id: var_na_filtering
    type:
      - 'null'
      - string
    doc: "Filter out NA values in the specified variable\n                       \
      \ metadata columns. The value is a comma separated list\n                  \
      \      of column names."
    inputBinding:
      position: 101
      prefix: -V
  - id: variable_output
    type:
      - 'null'
      - string
    doc: "Output file for variable metadata. You can use it as a\n               \
      \         template, where %s will be replaced by the study name\n          \
      \              and %a by the assay filename. Default is\n                  \
      \      \"%s-%a-variable-metadata.tsv\"."
    default: '"%s-%a-variable-metadata.tsv"'
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/isa2w4m:phenomenal-v1.1.0_cv1.4.11
stdout: isa2w4m.out
