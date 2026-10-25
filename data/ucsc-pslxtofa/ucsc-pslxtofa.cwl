cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslxToFa
label: ucsc-pslxtofa
doc: "Convert pslx (PSL with sequence) to a FASTA file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_pslx
    type: File
    doc: Input PSLX file (with sequence columns).
    inputBinding:
      position: 10
  - id: out_fa
    type: string
    doc: Output FASTA file name.
    inputBinding:
      position: 11
  - id: lift_target
    type:
      - 'null'
      - string
    doc: Name of a lift file (.lft) to create for the target sequences.
    inputBinding:
      position: 1
      prefix: -liftTarget=
      separate: false
  - id: lift_query
    type:
      - 'null'
      - string
    doc: Name of a lift file (.lft) to create for the query sequences.
    inputBinding:
      position: 2
      prefix: -liftQuery=
      separate: false
outputs:
  - id: out_fa_file
    type: File
    doc: Output FASTA file.
    outputBinding:
      glob: $(inputs.out_fa)
  - id: lift_target_file
    type:
      - 'null'
      - File
    doc: Lift file created for the target sequences.
    outputBinding:
      glob: $(inputs.lift_target)
  - id: lift_query_file
    type:
      - 'null'
      - File
    doc: Lift file created for the query sequences.
    outputBinding:
      glob: $(inputs.lift_query)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslxtofa:482--h0b57e2e_0
