cwlVersion: v1.2
class: CommandLineTool
baseCommand: to-stk
label: rdp-readseq_to-stk
doc: Converts a readseq file to a Stockholm format file.
inputs:
  - id: input_file
    type: File
    doc: The input readseq file.
    inputBinding:
      position: 1
  - id: header
    type:
      - 'null'
      - string
    doc: The header of the output file in case a different stk version.
    inputBinding:
      position: 102
      prefix: --header
  - id: removeref
    type:
      - 'null'
      - boolean
    doc: If set, do not write the GC reference sequences to output.
    inputBinding:
      position: 102
      prefix: --removeref
outputs:
  - id: out_file
    type: File
    doc: The output Stockholm format file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rdp-readseq:v2.0.2-6-deb_cv1
