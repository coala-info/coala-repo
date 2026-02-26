cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastqtk
  - interleave
label: fastqtk_interleave
doc: "It interleaves two input paired-end FASTQ files into one output FASTQ file.\n\
  \nTool homepage: https://github.com/ndaniel/fastqtk"
inputs:
  - id: in1_fq
    type: File
    doc: First input FASTQ file
    inputBinding:
      position: 1
  - id: in2_fq
    type: File
    doc: Second input FASTQ file
    inputBinding:
      position: 2
outputs:
  - id: out_fq
    type: File
    doc: Output FASTQ file. Use '-' for STDOUT.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0
