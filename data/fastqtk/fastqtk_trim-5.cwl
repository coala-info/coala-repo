cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastqtk
  - trim-5
label: fastqtk_trim-5
doc: "It trims N nucleotides from 5' end of the reads from a FASTQ file. N is a non-zero
  positive integer.\n\nTool homepage: https://github.com/ndaniel/fastqtk"
inputs:
  - id: n_nucleotides
    type: int
    doc: Number of nucleotides to trim from the 5' end
    inputBinding:
      position: 1
  - id: input_fastq
    type: File
    doc: Input FASTQ file (use - for STDIN)
    inputBinding:
      position: 2
outputs:
  - id: output_fastq
    type: File
    doc: Output FASTQ file (use - for STDOUT)
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0
