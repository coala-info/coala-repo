cwlVersion: v1.2
class: CommandLineTool
baseCommand: dmtools_merge
label: dmtools_merge
doc: "Merge multiple DM files\n\nTool homepage: https://github.com/ZhouQiangwei/dmtools"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: input DM files
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
  - id: merge_method
    type:
      - 'null'
      - string
    doc: method for merge overlap sites, weighted/ mean
    inputBinding:
      position: 101
      prefix: --method
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
