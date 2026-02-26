cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedSort
label: ucsc-psltobigpsl_bedSort
doc: "Sort a BED file by chromosome and start position. This is a standard utility
  from the UCSC Genome Browser toolset, often used to prepare BED files for conversion
  to BigBed format.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_bed
    type: File
    doc: The input BED file to be sorted.
    inputBinding:
      position: 1
outputs:
  - id: output_bed
    type: File
    doc: The destination path for the sorted BED file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-psltobigpsl:482--h0b57e2e_0
