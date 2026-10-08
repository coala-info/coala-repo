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
    type: string
    doc: Name of the output text file with the total number of reads
    inputBinding:
      position: 2
  - id: statistics_txt
    type: string
    doc: Name of the output text file with the summary statistics of the read
      lengths
    inputBinding:
      position: 3
outputs:
  - id: count_out
    type: File
    doc: Text file with the total number of reads
    outputBinding:
      glob: $(inputs.count_txt)
  - id: statistics_out
    type: File
    doc: Text file with the summary statistics of the read lengths
    outputBinding:
      glob: $(inputs.statistics_txt)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0
