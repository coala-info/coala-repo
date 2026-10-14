cwlVersion: v1.2
class: CommandLineTool
baseCommand: convert_table.py
label: picrust2_convert_table.py
doc: "Converts to and from PICRUSt2 function abundance table. Currently supports converting to legacy contributional format and to and from HUMAnN2 function tables.\n\nTool homepage: https://github.com/picrust/picrust2"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: conversion
    type: string
    doc: 'Type of conversion: contrib_to_legacy, humann2_unstrat_to_picrust2, humann2_strat_to_picrust2, picrust2_unstrat_to_humann2_split, picrust2_strat_to_humann2_split, or picrust2_to_humann2_merged.'
    inputBinding:
      position: 101
      prefix: --conversion
  - id: raw_abun
    type:
      - 'null'
      - boolean
    doc: 'When converting to legacy contributional table, output abundance as raw rather than relative abundance.'
    inputBinding:
      position: 101
      prefix: --raw_abun
  - id: output_path
    type: string
    doc: 'Path to output: a folder name if multiple files are output, otherwise a filename.'
    inputBinding:
      position: 102
      prefix: --output
  - id: input_tables
    type:
      type: array
      items: File
    doc: 'Input table(s) to convert.'
    inputBinding:
      position: 200
outputs:
  - id: output
    type:
      - 'null'
      - File
      - Directory
    doc: 'Converted table (a file for a single output, a folder when multiple files are written)'
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picrust2:2.6.3--pyhdfd78af_1
