cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastqtk
  - drop-short
label: fastqtk_drop-short
doc: "It drops the reads that have the sequences stricly shorter than N. N is a non-zero
  positive integer.\n\nTool homepage: https://github.com/ndaniel/fastqtk"
inputs:
  - id: n
    type: int
    doc: The minimum length of reads to keep. Reads strictly shorter than N will
      be dropped.
    inputBinding:
      position: 1
  - id: input_fq
    type: File
    doc: Input FASTQ file. Use '-' for STDIN.
    inputBinding:
      position: 2
outputs:
  - id: output_fq
    type: File
    doc: Output FASTQ file. Use '-' for STDOUT.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0
