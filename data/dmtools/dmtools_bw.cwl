cwlVersion: v1.2
class: CommandLineTool
baseCommand: dmtools_bw
label: dmtools_bw
doc: "Convert DM file to bigwig format.\n\nTool homepage: https://github.com/ZhouQiangwei/dmtools"
inputs:
  - id: chromosome
    type:
      - 'null'
      - string
    doc: chromosome for print
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
    default: 10000
    inputBinding:
      position: 101
      prefix: --maxcover
  - id: max_zoom_levels
    type:
      - 'null'
      - int
    doc: The maximum number of zoom levels. [0-10]
    default: 2
    inputBinding:
      position: 101
      prefix: --zl
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: '>= minumum coverage show'
    default: 0
    inputBinding:
      position: 101
      prefix: --mincover
  - id: region
    type:
      - 'null'
      - type: array
        items: string
    doc: region for print, can be seperated by space. chr1:1-2900 chr2:1-200
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
  - id: output_bigwig_file
    type: File
    doc: Prefix of methratio.dm output file
    outputBinding:
      glob: $(inputs.output_bigwig_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dmtools:0.2.6--hda3def1_0
