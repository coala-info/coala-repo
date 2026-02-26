cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastqtk
  - fa2fq
label: fastqtk_fa2fq
doc: "Converts a FASTA file to a FASTQ file.\n\nTool homepage: https://github.com/ndaniel/fastqtk"
inputs:
  - id: input_fa
    type: File
    doc: Input FASTA file. Use '-' for STDIN.
    inputBinding:
      position: 1
outputs:
  - id: output_fq
    type: File
    doc: Output FASTQ file. Use '-' for STDOUT.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0
