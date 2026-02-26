cwlVersion: v1.2
class: CommandLineTool
baseCommand: fmf
label: bgt_fmf
doc: "Process FMF files\n\nTool homepage: https://github.com/Dysman/bgTools-playerPrefsEditor"
inputs:
  - id: input_fmf
    type: File
    doc: Input FMF file
    inputBinding:
      position: 1
  - id: condition
    type:
      - 'null'
      - string
    doc: Condition to apply
    inputBinding:
      position: 2
  - id: load_ram
    type:
      - 'null'
      - boolean
    doc: load the entire FMF into RAM
    inputBinding:
      position: 103
      prefix: -m
  - id: output_row_name_only
    type:
      - 'null'
      - boolean
    doc: only output the row name (the 1st column)
    inputBinding:
      position: 103
      prefix: -n
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bgt:r283--h577a1d6_7
stdout: bgt_fmf.out
