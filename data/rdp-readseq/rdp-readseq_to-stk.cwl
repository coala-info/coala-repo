cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rdp-readseq
  - to-stk
label: rdp-readseq_to-stk
doc: "Convert aligned sequences to Stockholm (stk) format.

Tool homepage: https://github.com/rdpstaff/ReadSeq"
inputs:
  - id: input_file
    type: File
    doc: "Input file of aligned sequences"
    inputBinding:
      position: 3
  - id: outfile
    type: string
    doc: "Output stk file"
    inputBinding:
      position: 4
  - id: header
    type:
      - 'null'
      - string
    doc: "Header of the output file, in case of a different stk version. Default is # STOCKHOLM 1.0"
    inputBinding:
      position: 1
      prefix: --header
  - id: removeref
    type:
      - 'null'
      - boolean
    doc: "If set, do not write the GC reference sequences to the output"
    inputBinding:
      position: 2
      prefix: --removeref
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: "Stockholm format file"
    outputBinding:
      glob: $(inputs.outfile)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rdp-readseq:v2.0.2-6-deb_cv1
