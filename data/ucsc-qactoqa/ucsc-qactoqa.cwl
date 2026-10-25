cwlVersion: v1.2
class: CommandLineTool
baseCommand: qacToQa
label: ucsc-qactoqa
doc: "Convert from compressed (.qac) to uncompressed (.qa) quality score format.\n\nTool
  homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_qac
    type: File
    doc: Input compressed quality score file (.qac).
    inputBinding:
      position: 10
  - id: out_qa
    type: string
    doc: Output uncompressed quality score file name (.qa).
    inputBinding:
      position: 11
  - id: name
    type:
      - 'null'
      - string
    doc: Restrict output to just this sequence name.
    inputBinding:
      position: 1
      prefix: -name=
      separate: false
outputs:
  - id: out_qa_file
    type: File
    doc: Output uncompressed quality score file.
    outputBinding:
      glob: $(inputs.out_qa)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-qactoqa:482--h0b57e2e_0
