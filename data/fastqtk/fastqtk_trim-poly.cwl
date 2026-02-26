cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastqtk
  - trim-poly
label: fastqtk_trim-poly
doc: "It trims poly-A/C/G/T/N tails at both ends of the reads sequences from a FASTQ
  file. For redirecting to STDOUT/STDIN use - instead of file name.\n\nTool homepage:
  https://github.com/ndaniel/fastqtk"
inputs:
  - id: poly_nucleotide
    type: string
    doc: nucleotide or nucleotides that form the poly tails that will be trimmed
    inputBinding:
      position: 1
  - id: min_tail_length
    type: int
    doc: the length of the poly tail; all poly-tails equal or longer than M will
      be trimmed
    inputBinding:
      position: 2
  - id: input_fastq
    type: File
    doc: Input FASTQ file
    inputBinding:
      position: 3
outputs:
  - id: output_fastq
    type: File
    doc: Output FASTQ file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0
