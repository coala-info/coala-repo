cwlVersion: v1.2
class: CommandLineTool
baseCommand: PretextMap
label: pretextmap_PretextMap
doc: "PretextMap Version 0.2.3\n\nTool homepage: https://github.com/wtsi-hpag/PretextMap"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input .pairs or .sam file. Reads from stdin if not specified.
    inputBinding:
      position: 1
  - id: filter_exclude
    type:
      - 'null'
      - string
    doc: Exclude sequences matching the pattern
    inputBinding:
      position: 102
  - id: filter_include
    type:
      - 'null'
      - string
    doc: Include sequences matching the pattern
    inputBinding:
      position: 102
  - id: high_res
    type:
      - 'null'
      - boolean
    doc: Enable high resolution mode
    inputBinding:
      position: 102
  - id: licence
    type:
      - 'null'
      - boolean
    doc: View software licence
    inputBinding:
      position: 102
      prefix: --licence
  - id: mapq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality
    inputBinding:
      position: 102
  - id: sortby
    type:
      - 'null'
      - string
    doc: Sort by length, name, or nosort
    inputBinding:
      position: 102
  - id: sortorder
    type:
      - 'null'
      - string
    doc: 'Sort order: descend or ascend'
    inputBinding:
      position: 102
  - id: thirdparty
    type:
      - 'null'
      - boolean
    doc: View third party software used
    inputBinding:
      position: 102
      prefix: --thirdparty
outputs:
  - id: output_file
    type: File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pretextmap:0.2.3--h9948957_0
