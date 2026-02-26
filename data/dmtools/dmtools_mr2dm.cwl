cwlVersion: v1.2
class: CommandLineTool
baseCommand: dmtools mr2dm
label: dmtools_mr2dm
doc: "Convert methylation ratio files to DM format.\n\nTool homepage: https://github.com/ZhouQiangwei/dmtools"
inputs:
  - id: add_strand_info
    type:
      - 'null'
      - float
    doc: add strand information to meth level. eg 0.5, -0.5
    inputBinding:
      position: 101
      prefix: --sv
  - id: chromosome_size_file
    type: File
    doc: chromosome size file.
    inputBinding:
      position: 101
      prefix: -g
  - id: coverage_filter
    type:
      - 'null'
      - int
    doc: coverage filter, >=[int], default 4.
    default: 4
    inputBinding:
      position: 101
      prefix: --CF
  - id: fcontext
    type:
      - 'null'
      - string
    doc: CG/CHG/CHH/ALL, only convert provide context in methratio file or 
      bedsimple, default ALL
    default: ALL
    inputBinding:
      position: 101
  - id: file_format
    type:
      - 'null'
      - string
    doc: file format. methratio, bedmethyl, bismark or bedsimple [default 
      methratio]
    default: methratio
    inputBinding:
      position: 101
      prefix: -f
  - id: max_zoom_levels
    type:
      - 'null'
      - int
    doc: The maximum number of zoom levels. [0-10]
    inputBinding:
      position: 101
      prefix: --zl
  - id: methratio_file
    type: File
    doc: methratio file
    inputBinding:
      position: 101
      prefix: -m
  - id: pcontext
    type:
      - 'null'
      - string
    doc: CG/CHG/CHH/C, needed when bedmethyl format, default C
    inputBinding:
      position: 101
  - id: print_context
    type:
      - 'null'
      - boolean
    doc: print context
    inputBinding:
      position: 101
      prefix: --Cx
  - id: print_coverage
    type:
      - 'null'
      - boolean
    doc: print coverage
    inputBinding:
      position: 101
      prefix: -C
  - id: print_end
    type:
      - 'null'
      - boolean
    doc: print end
    inputBinding:
      position: 101
      prefix: -E
  - id: print_id
    type:
      - 'null'
      - boolean
    doc: print ID
    inputBinding:
      position: 101
      prefix: --Id
  - id: print_strand
    type:
      - 'null'
      - boolean
    doc: print strand
    inputBinding:
      position: 101
      prefix: -S
  - id: sort_coordinates
    type:
      - 'null'
      - string
    doc: make chromsize file and meth file in same coordinate, default Y
    default: Y
    inputBinding:
      position: 101
      prefix: --sort
outputs:
  - id: output_dm_file
    type: File
    doc: output DM file
    outputBinding:
      glob: $(inputs.output_dm_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dmtools:0.2.6--hda3def1_0
