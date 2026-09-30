cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastqtk
  - count
label: fastqtk_count
doc: "It provides the total number of reads from an input FASTQ file and outputs it
  to a text file.\n\nTool homepage: https://github.com/ndaniel/fastqtk"
inputs:
  - id: in_fq
    type: File
    doc: Input FASTQ file
    inputBinding:
      position: 1
  - id: out_txt
    type: string
    doc: Output text file
    inputBinding:
      position: 2
outputs:
  - id: out_out_txt
    type: File
    doc: Output text file
    outputBinding:
      glob: '$(inputs.out_txt)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0
