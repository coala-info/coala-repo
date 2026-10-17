cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - psirc-quant
  - inspect
label: psirc_inspect
doc: "Inspects and gives information about an index\n\nTool homepage: https://github.com/nictru/psirc"
inputs:
  - id: index
    type: File
    doc: "Index file to inspect"
    inputBinding:
      position: 10
  - id: gfa
    type:
      - 'null'
      - string
    doc: "Filename for GFA output of T-DBG"
    inputBinding:
      position: 1
      prefix: -G
  - id: gtf
    type:
      - 'null'
      - File
    doc: "GTF file with the transcript annotation"
    inputBinding:
      position: 2
      prefix: -g
  - id: bed
    type:
      - 'null'
      - string
    doc: "Filename for BED output (default: index + \".bed\")"
    inputBinding:
      position: 3
      prefix: -b
outputs:
  - id: gfa_file
    type:
      - 'null'
      - File
    doc: "GFA output of the transcript de Bruijn graph"
    outputBinding:
      glob: $(inputs.gfa)
  - id: bed_file
    type:
      - 'null'
      - File
    doc: "BED output"
    outputBinding:
      glob: $(inputs.bed)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psirc:1.0.0--h6f0a7f7_1
