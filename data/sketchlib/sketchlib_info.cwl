cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sketchlib
  - info
label: sketchlib_info
doc: "Print information about a .skm file\n\nTool homepage: https://github.com/bacpop/sketchlib.rust"
inputs:
  - id: skm_file
    type: File
    doc: Sketch metadata file (.skm) to describe
    inputBinding:
      position: 1
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't show any messages
    inputBinding:
      position: 102
      prefix: --quiet
  - id: sample_info
    type:
      - 'null'
      - boolean
    doc: Write out the information for every sample contained
    inputBinding:
      position: 102
      prefix: --sample-info
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Show progress messages
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sketchlib:0.2.4--h4349ce8_0
stdout: sketchlib_info.out
