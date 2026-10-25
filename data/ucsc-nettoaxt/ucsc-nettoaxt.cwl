cwlVersion: v1.2
class: CommandLineTool
baseCommand: netToAxt
label: ucsc-nettoaxt
doc: "Convert net (and chain) to axt.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_net
    type: File
    doc: Input net file
    inputBinding:
      position: 1
  - id: in_chain
    type: File
    doc: Input chain file
    inputBinding:
      position: 2
  - id: target_2bit
    type: File
    doc: Target 2bit file (a directory of .nib files, an older format, may also 
      be used)
    inputBinding:
      position: 3
  - id: query_2bit
    type: File
    doc: Query 2bit file (a directory of .nib files, an older format, may also 
      be used)
    inputBinding:
      position: 4
  - id: out_axt
    type: string
    doc: Output axt file
    inputBinding:
      position: 5
  - id: q_chain
    type:
      - 'null'
      - boolean
    doc: net is with respect to the q side of chains.
    inputBinding:
      position: 0
      prefix: -qChain
  - id: max_gap
    type:
      - 'null'
      - int
    doc: maximum size of gap before breaking. Default 100
    inputBinding:
      position: 0
      prefix: -maxGap=
      separate: false
  - id: gap_out
    type:
      - 'null'
      - string
    doc: Output gap sizes to file (gap.tab)
    inputBinding:
      position: 0
      prefix: -gapOut=
      separate: false
  - id: no_split
    type:
      - 'null'
      - boolean
    doc: Don't split chain when there is an insertion of another chain
    inputBinding:
      position: 0
      prefix: -noSplit
outputs:
  - id: output_axt
    type: File
    doc: Output axt file
    outputBinding:
      glob: $(inputs.out_axt)
  - id: gap_out_file
    type:
      - 'null'
      - File
    doc: Gap size table written by -gapOut
    outputBinding:
      glob: $(inputs.gap_out)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-nettoaxt:482--h0b57e2e_0
