cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastqtk
  - fq2fa
label: fastqtk_fq2fa
doc: "It a FASTQ file to FASTA file.\n\nTool homepage: https://github.com/ndaniel/fastqtk"
inputs:
  - id: input_fq
    type: File
    doc: Input FASTQ file. Use - for STDIN.
    inputBinding:
      position: 1
outputs:
  - id: output_fa
    type: File
    doc: Output FASTA file. Use - for STDOUT.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0
