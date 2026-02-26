cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastqtk
  - deinterleave
label: fastqtk_deinterleave
doc: "It splits an interleaved input FASTQ file into two paired-end FASTQ files.\n\
  \nTool homepage: https://github.com/ndaniel/fastqtk"
inputs:
  - id: input_fq
    type: File
    doc: Interleaved input FASTQ file. Use - for STDIN.
    inputBinding:
      position: 1
outputs:
  - id: out1_fq
    type: File
    doc: Output FASTQ file for the first pair.
    outputBinding:
      glob: '*.out'
  - id: out2_fq
    type: File
    doc: Output FASTQ file for the second pair.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0
