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
  - id: out1_name
    type: string
    doc: Name of the output file. Output FASTQ file for the first pair.
    inputBinding:
      position: 2
  - id: out2_name
    type: string
    doc: Name of the output file. Output FASTQ file for the second pair.
    inputBinding:
      position: 3
outputs:
  - id: out1_fq
    type: File
    doc: Output FASTQ file for the first pair.
    outputBinding:
      glob: '$(inputs.out1_name)'
  - id: out2_fq
    type: File
    doc: Output FASTQ file for the second pair.
    outputBinding:
      glob: '$(inputs.out2_name)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0
