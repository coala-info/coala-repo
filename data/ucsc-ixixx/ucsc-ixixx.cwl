cwlVersion: v1.2
class: CommandLineTool
baseCommand: ixIxx
label: ucsc-ixixx
doc: "Create indices for word searches. The input is a text file where each line starts
  with an identifier, followed by the text to be indexed. The output is a pair of
  files: a main index (.ix) and a secondary index (.ixx) used for fast lookups.\n\n
  Tool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: input_file
    type: File
    doc: Input text file to be indexed. Each line should start with a unique identifier.
    inputBinding:
      position: 1
outputs:
  - id: out_ix
    type: File
    doc: Output main index file (usually ending in .ix).
    outputBinding:
      glob: '*.out'
  - id: out_ixx
    type: File
    doc: Output secondary index file (usually ending in .ixx).
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-ixixx:482--h0b57e2e_0
