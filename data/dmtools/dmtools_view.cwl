cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dmtools
  - view
label: dmtools_view
doc: "View mode parameters\n\nTool homepage: https://github.com/ZhouQiangwei/dmtools"
inputs:
  - id: bed_file
    type:
      - 'null'
      - File
    doc: 'bed file for view, format: chrom start end (strand).'
    inputBinding:
      position: 101
      prefix: --bed
  - id: chromosome
    type:
      - 'null'
      - string
    doc: chromosome for view
    inputBinding:
      position: 101
      prefix: --chr
  - id: context
    type:
      - 'null'
      - int
    doc: "[0/1/2/3] context for show, 0 represent 'C/ALL' context, 1 'CG' context,
      2 'CHG' context, 3 'CHH' context."
    inputBinding:
      position: 101
      prefix: --context
  - id: input_dm_file
    type: File
    doc: input DM file
    inputBinding:
      position: 101
      prefix: -i
  - id: max_coverage
    type:
      - 'null'
      - int
    doc: <= maximum coverage show
    inputBinding:
      position: 101
      prefix: --maxcover
  - id: max_zoom_levels
    type:
      - 'null'
      - int
    doc: The maximum number of zoom levels. [0-10], valid for dm out
    inputBinding:
      position: 101
      prefix: --zl
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: '>= minumum coverage show'
    inputBinding:
      position: 101
      prefix: --mincover
  - id: output_format
    type:
      - 'null'
      - string
    doc: txt or dm format
    inputBinding:
      position: 101
      prefix: --outformat
  - id: region
    type:
      - 'null'
      - type: array
        items: string
    doc: region for view, can be seperated by space. chr1:1-2900 chr2:1-200
    inputBinding:
      position: 101
      prefix: -r
  - id: strand
    type:
      - 'null'
      - int
    doc: "[0/1/2] strand for show, 0 represent '+' positive strand, 1 '-' negative
      strand, 2 '.' all information"
    inputBinding:
      position: 101
      prefix: --strand
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dmtools:0.2.6--hda3def1_0
