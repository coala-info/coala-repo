cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastqtk
  - rev-com
label: fastqtk_rev-com
doc: "It reverse complements all the reads from a FASTQ file.\n\nTool homepage: https://github.com/ndaniel/fastqtk"
inputs:
  - id: input_fq
    type: File
    doc: Input FASTQ file. Use - for STDIN.
    inputBinding:
      position: 1
outputs:
  - id: output_fq
    type: File
    doc: Output FASTQ file. Use - for STDOUT.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0
