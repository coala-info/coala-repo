cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastqtk
  - count-lengths
label: fastqtk_count-lengths
doc: "It provides total number of reads and a summary statistics regarding the lengths
  of the reads from an input FASTQ file and outputs it to a text file.\n\nTool homepage:
  https://github.com/ndaniel/fastqtk"
inputs:
  - id: input_fq
    type: File
    doc: Input FASTQ file
    inputBinding:
      position: 1
  - id: count_txt
    type: File
    doc: Output file for read counts
    inputBinding:
      position: 2
outputs:
  - id: statistics_txt
    type: File
    doc: Output file for summary statistics
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0
