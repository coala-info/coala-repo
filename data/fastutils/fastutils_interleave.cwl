cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastutils
  - interleave
label: fastutils_interleave
doc: "Interleaves paired-end sequencing reads.\n\nTool homepage: https://github.com/haghshenas/fastutils"
inputs:
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: output reads in fastq format if possible
    inputBinding:
      position: 101
      prefix: --fastq
  - id: in1
    type:
      type: array
      items: File
      inputBinding:
        prefix: --in1
    doc: fasta/q file(s) containing forward (left) reads, one file per library, in the same order
      as the other read file list
    inputBinding:
      position: 101
  - id: in2
    type:
      type: array
      items: File
      inputBinding:
        prefix: --in2
    doc: fasta/q file(s) containing reverse (right) reads, one file per library, in the same order
      as the other read file list
    inputBinding:
      position: 102
  - id: separator
    type:
      - 'null'
      - string
    doc: separator character
    inputBinding:
      position: 101
      prefix: --separator
  - id: out_path
    type: string
    doc: output file [stdout]
    inputBinding:
      position: 103
      prefix: --out
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: output interlaced reads in STR file
    outputBinding:
      glob: $(inputs.out_path)
successCodes: [0, 1]
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastutils:0.3--h077b44d_5
