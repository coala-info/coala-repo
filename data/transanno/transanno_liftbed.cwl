cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - transanno
  - liftbed
label: transanno_liftbed
doc: "Lift BED file\n\nTool homepage: https://github.com/informationsea/transanno"
inputs:
  - id: bed
    type: File
    doc: input BED file
    inputBinding:
      position: 1
  - id: allow_multi_map
    type:
      - 'null'
      - boolean
    doc: Allow multi-map
    inputBinding:
      position: 102
      prefix: --allow-multi-map
  - id: chain
    type: File
    doc: chain file
    inputBinding:
      position: 102
      prefix: --chain
  - id: failed_path
    type:
      - 'null'
      - string
    doc: Failed BED output path
    inputBinding:
      position: 103
      prefix: --failed
  - id: output_path
    type: string
    doc: BED output path (unsorted)
    inputBinding:
      position: 104
      prefix: --output
outputs:
  - id: output
    type: File
    doc: BED output path (unsorted)
    outputBinding:
      glob: $(inputs.output_path)
  - id: failed
    type:
      - 'null'
      - File
    doc: Failed BED output path
    outputBinding:
      glob: $(inputs.failed_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transanno:0.4.5--h4349ce8_0
