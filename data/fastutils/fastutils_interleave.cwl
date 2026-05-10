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
    doc: fasta/q file containing forward (left) reads
    inputBinding:
      position: 101
      prefix: --in1
  - id: in2
    type:
      type: array
      items: File
    doc: fasta/q file containing reverse (right) reads
    inputBinding:
      position: 101
      prefix: --in2
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
      position: 102
      prefix: --out
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: output interlaced reads in STR file
    outputBinding:
      glob: $(inputs.out_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastutils:0.3--h077b44d_5
