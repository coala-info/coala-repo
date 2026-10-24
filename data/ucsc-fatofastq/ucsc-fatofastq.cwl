cwlVersion: v1.2
class: CommandLineTool
baseCommand: faToFastq
label: ucsc-fatofastq
doc: "Convert fa to fastq format, just faking quality values.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: output_name
    type: string
    doc: Name of the output FASTQ file
    inputBinding:
      position: 2
  - id: qual
    type:
      - 'null'
      - string
    doc: Quality letter to use. Default is '<'.
    inputBinding:
      position: 101
      prefix: -qual=
      separate: false
outputs:
  - id: output_fastq
    type: File
    doc: Output FASTQ file
    outputBinding:
      glob: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-fatofastq:482--h0b57e2e_0
