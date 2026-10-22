cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sketchlib
  - merge
label: sketchlib_merge
doc: "Merge two sketch files (.skm and .skd pair)\n\nTool homepage: https://github.com/bacpop/sketchlib.rust"
inputs:
  - id: db1
    type: File
    secondaryFiles:
      - ^.skm
    doc: The first .skd (sketch data) file
    inputBinding:
      position: 1
  - id: db2
    type: File
    secondaryFiles:
      - ^.skm
    doc: The second .skd (sketch data) file
    inputBinding:
      position: 2
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't show any messages
    inputBinding:
      position: 103
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Show progress messages
    inputBinding:
      position: 103
      prefix: --verbose
  - id: output_path
    type: string
    doc: Output prefix for the merged sketch (.skm and .skd are added)
    inputBinding:
      position: 104
      prefix: -o
outputs:
  - id: output
    type:
      type: array
      items: File
    doc: Merged sketch files (.skm and .skd) written with the given output prefix
    outputBinding:
      glob: $(inputs.output_path)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sketchlib:0.2.4--h4349ce8_0
