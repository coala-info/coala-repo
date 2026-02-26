cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastqtk
  - detab
label: fastqtk_detab
doc: "Converts a 4 or 8 columns text tab-delimited file into a FASTQ file.\n\nTool
  homepage: https://github.com/ndaniel/fastqtk"
inputs:
  - id: fastq_txt
    type: File
    doc: Input tab-delimited text file
    inputBinding:
      position: 1
outputs:
  - id: out_fq
    type: File
    doc: Output FASTQ file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0
