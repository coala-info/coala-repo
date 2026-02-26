cwlVersion: v1.2
class: CommandLineTool
baseCommand: faRc
label: ucsc-farc_faRc
doc: "Reverse complement a FA file\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_fa
    type: File
    doc: Input FA file
    inputBinding:
      position: 1
  - id: just_complement
    type:
      - 'null'
      - boolean
    doc: "prepends C unless asked to keep name\n                     (cannot appear
      together with -justReverse)"
    inputBinding:
      position: 102
      prefix: -justComplement
  - id: just_reverse
    type:
      - 'null'
      - boolean
    doc: prepends R unless asked to keep name
    inputBinding:
      position: 102
      prefix: -justReverse
  - id: keep_case
    type:
      - 'null'
      - boolean
    doc: "works well for ACGTUN in either case. bizarre for other letters.\n     \
      \          without it bases are turned to lower, all else to n's"
    inputBinding:
      position: 102
      prefix: -keepCase
  - id: keep_name
    type:
      - 'null'
      - boolean
    doc: keep name identical (don't prepend RC)
    inputBinding:
      position: 102
      prefix: -keepName
outputs:
  - id: output_fa
    type: File
    doc: Output FA file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-farc:482--h0b57e2e_0
