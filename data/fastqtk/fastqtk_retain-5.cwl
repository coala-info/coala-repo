cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastqtk
  - retain-5
label: fastqtk_retain-5
doc: "It retains the first N nucleotides from 5' end of the reads from a FASTQ file.
  N is a non-zero positive integer.\n\nTool homepage: https://github.com/ndaniel/fastqtk"
inputs:
  - id: n
    type: int
    doc: The first N nucleotides to retain from the 5' end of reads.
    inputBinding:
      position: 1
  - id: input_fastq
    type: File
    doc: Input FASTQ file. Use - for STDIN.
    inputBinding:
      position: 2
outputs:
  - id: output_fastq
    type: File
    doc: Output FASTQ file. Use - for STDOUT.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0
