cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastqtk
  - tab-4
label: fastqtk_tab-4
doc: "It converts a FASTQ file into a tab-delimited text file with four columns.\n\
  \nTool homepage: https://github.com/ndaniel/fastqtk"
inputs:
  - id: input_fq
    type: File
    doc: Input FASTQ file. Use - for STDIN.
    inputBinding:
      position: 1
outputs:
  - id: output_fastq_txt
    type: File
    doc: Output tab-delimited text file. Use - for STDOUT.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0
