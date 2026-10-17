cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - psirc-quant
  - query
label: psirc_query
doc: "Queries for the representation of the specified transcript in the unitig graph\n\nTool homepage: https://github.com/nictru/psirc"
inputs:
  - id: index
    type: File
    doc: "Index to be used for pseudoalignment"
    inputBinding:
      position: 1
      prefix: -i
  - id: trans_id
    type: string
    doc: "Transcript ID to investigate"
    inputBinding:
      position: 2
      prefix: -T
  - id: output
    type: string
    doc: "Output file"
    inputBinding:
      position: 3
      prefix: -o
outputs:
  - id: output_file
    type: File
    doc: "Unitig path of the transcript"
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psirc:1.0.0--h6f0a7f7_1
