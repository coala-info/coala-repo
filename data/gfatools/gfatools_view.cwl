cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfatools view
label: gfatools_view
doc: "View and subset GFA graphs\n\nTool homepage: https://github.com/lh3/gfatools"
inputs:
  - id: input_gfa
    type: File
    doc: Input GFA file
    inputBinding:
      position: 1
  - id: delete_list
    type:
      - 'null'
      - boolean
    doc: delete the list of segments (requiring -l; ignoring -r)
    inputBinding:
      position: 102
      prefix: -d
  - id: no_sequences
    type:
      - 'null'
      - boolean
    doc: don't print sequences
    inputBinding:
      position: 102
      prefix: -S
  - id: region
    type:
      - 'null'
      - string
    doc: a region like chr1:101-200 (a 1-based closed region)
    inputBinding:
      position: 102
      prefix: -R
  - id: remove_multiple_edges
    type:
      - 'null'
      - boolean
    doc: remove multiple edges
    inputBinding:
      position: 102
      prefix: -M
  - id: segment_list
    type:
      - 'null'
      - File
    doc: segment list to subset
    inputBinding:
      position: 102
      prefix: -l
  - id: subset_radius
    type:
      - 'null'
      - int
    doc: subset radius (effective with -l)
    inputBinding:
      position: 102
      prefix: -r
  - id: verbose_level
    type:
      - 'null'
      - int
    doc: verbose level
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfatools:0.5.5--h577a1d6_0
stdout: gfatools_view.out
