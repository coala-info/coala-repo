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
    doc: The first .skd (sketch data) file
    inputBinding:
      position: 1
  - id: db2
    type: File
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
outputs:
  - id: output
    type: File
    doc: Output filename for the merged sketch
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sketchlib:0.2.4--h4349ce8_0
