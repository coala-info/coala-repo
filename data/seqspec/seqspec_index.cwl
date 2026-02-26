cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqspec index
label: seqspec_index
doc: "Identify the position of elements in a spec for use in downstream tools.\n\n\
  Tool homepage: https://github.com/sbooeshaghi/seqspec"
inputs:
  - id: yaml
    type: File
    doc: Sequencing specification yaml file
    inputBinding:
      position: 1
  - id: ids
    type: string
    doc: IDs
    inputBinding:
      position: 102
      prefix: --ids
  - id: modality
    type: string
    doc: Modality
    inputBinding:
      position: 102
      prefix: --modality
  - id: no_overlap
    type:
      - 'null'
      - boolean
    doc: Disable overlap
    default: false
    inputBinding:
      position: 102
      prefix: --no-overlap
  - id: rev
    type:
      - 'null'
      - boolean
    doc: Returns 3'->5' region order
    inputBinding:
      position: 102
      prefix: --rev
  - id: selector
    type:
      - 'null'
      - string
    doc: Selector for ID, [read, region, file]
    default: read
    inputBinding:
      position: 102
      prefix: --selector
  - id: tool
    type:
      - 'null'
      - string
    doc: Tool, [chromap, kb, kb-single, relative, seqkit, simpleaf, starsolo, 
      splitcode, tab, zumis]
    default: tab
    inputBinding:
      position: 102
      prefix: --tool
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Path to output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqspec:0.4.0--pyhdfd78af_0
