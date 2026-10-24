cwlVersion: v1.2
class: CommandLineTool
baseCommand: faRc
label: ucsc-farc_faRc
doc: "Reverse complement a FA file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_fa
    type: File
    doc: Input FA file
    inputBinding:
      position: 10
  - id: out_fa
    type: string
    doc: Output FA file name. In.fa and out.fa may be the same file.
    inputBinding:
      position: 11
  - id: just_complement
    type:
      - 'null'
      - boolean
    doc: "prepends C unless asked to keep name\n                     (cannot appear
      together with -justReverse)"
    inputBinding:
      position: 4
      prefix: -justComplement
  - id: just_reverse
    type:
      - 'null'
      - boolean
    doc: prepends R unless asked to keep name
    inputBinding:
      position: 3
      prefix: -justReverse
  - id: keep_case
    type:
      - 'null'
      - boolean
    doc: "works well for ACGTUN in either case. bizarre for other letters.\n     \
      \          without it bases are turned to lower, all else to n's"
    inputBinding:
      position: 2
      prefix: -keepCase
  - id: keep_name
    type:
      - 'null'
      - boolean
    doc: keep name identical (don't prepend RC)
    inputBinding:
      position: 1
      prefix: -keepName
outputs:
  - id: output_fa
    type: File
    doc: Output FA file
    outputBinding:
      glob: $(inputs.out_fa)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-farc:482--h0b57e2e_0
