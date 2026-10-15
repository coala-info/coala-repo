cwlVersion: v1.2
class: CommandLineTool
baseCommand: PretextMap
label: pretextmap_PretextMap
doc: "PretextMap Version 0.2.3\n\nTool homepage: https://github.com/wtsi-hpag/PretextMap"
inputs:
  - id: input_file
    type: File
    doc: Input .pairs or .sam file; PretextMap reads it from standard input (it does
      not accept a file name argument).
  - id: filter_exclude
    type:
      - 'null'
      - string
    doc: Exclude sequences matching the pattern
    inputBinding:
      position: 102
      prefix: --filterExclude
  - id: filter_include
    type:
      - 'null'
      - string
    doc: Include sequences matching the pattern
    inputBinding:
      position: 102
      prefix: --filterInclude
  - id: high_res
    type:
      - 'null'
      - boolean
    doc: Enable high resolution mode
    inputBinding:
      position: 102
      prefix: --highRes
  - id: mapq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality
    inputBinding:
      position: 102
      prefix: --mapq
  - id: sortby
    type:
      - 'null'
      - string
    doc: Sort by length, name, or nosort
    inputBinding:
      position: 102
      prefix: --sortby
  - id: sortorder
    type:
      - 'null'
      - string
    doc: 'Sort order: descend or ascend'
    inputBinding:
      position: 102
      prefix: --sortorder
  - id: output_file_path
    type: string
    doc: Output PretextMap file name
    inputBinding:
      position: 101
      prefix: -o
outputs:
  - id: output_file
    type: File
    doc: Output PretextMap contact map file (.pretext)
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pretextmap:0.2.3--h9948957_0
stdin: $(inputs.input_file.path)
