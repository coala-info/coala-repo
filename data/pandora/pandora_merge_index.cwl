cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pandora
  - merge_index
label: pandora_merge_index
doc: "Allows multiple indices to be merged (no compatibility check)\n\nTool homepage:
  https://github.com/rmcolq/pandora"
inputs:
  - id: indices
    type:
      type: array
      items: File
    doc: Indices to merge
    inputBinding:
      position: 1
  - id: verbosity
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Verbosity of logging. Repeat for increased verbosity
    inputBinding:
      position: 102
      prefix: -v
  - id: outfile_path
    type: string
    doc: 'Filename for the index [default: <PRG>.kXX.wXX.idx]'
    inputBinding:
      position: 103
      prefix: --outfile
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Filename for merged index
    outputBinding:
      glob: $(inputs.outfile_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pandora:0.9.2--h4ac6f70_0
