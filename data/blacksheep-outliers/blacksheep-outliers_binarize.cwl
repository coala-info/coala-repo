cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deva
  - binarize
label: blacksheep-outliers_binarize
doc: "Takes an annotation table where some columns may have more than 2 possible values (not including empty/null values) and outputs an annotation table with only two values per annotation. Propagates null values.\n\nTool homepage: https://github.com/ruggleslab/blackSheep/"
inputs:
  - id: annotations
    type: File
    doc: Annotation table with samples as rows and annotation labels as columns.
    inputBinding:
      position: 1
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output prefix for writing files. Default outliers.
    inputBinding:
      position: 102
      prefix: --output_prefix
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Files written with the output prefix (tables, log, parameters, heatmaps,
      gene lists).
    outputBinding:
      glob: $((inputs.output_prefix || 'outliers') + '*')
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blacksheep-outliers:0.0.8--py_0
