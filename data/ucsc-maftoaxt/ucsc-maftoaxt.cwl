cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafToAxt
label: ucsc-maftoaxt
doc: "Convert from maf to axt format\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_maf
    type: File
    doc: Input MAF file
    inputBinding:
      position: 1
  - id: t_name
    type: string
    doc: Name of the target sequence. It should be the maf target since it must always
      be oriented in "+" direction. Use 'first' to always use the first sequence.
    inputBinding:
      position: 2
  - id: q_name
    type: string
    doc: Name of the query sequence
    inputBinding:
      position: 3
  - id: output
    type: string
    doc: Output AXT file name
    inputBinding:
      position: 4
  - id: strip_db
    type:
      - 'null'
      - boolean
    doc: Strip names from start to first period.
    inputBinding:
      position: 101
      prefix: -stripDb
outputs:
  - id: out_output
    type: File
    doc: Output AXT file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-maftoaxt:482--h0b57e2e_0
