cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - maq
  - bfq2fastq
label: maq_bfq2fastq
doc: "Convert .bfq files to .fastq files\n\nTool homepage: https://github.com/maqetta/maqetta"
inputs:
  - id: input_bfq
    type: File
    doc: Input .bfq file
    inputBinding:
      position: 1
  - id: out_fastq
    type: string
    doc: Output .fastq file
    inputBinding:
      position: 2
outputs:
  - id: output_fastq
    type: File
    doc: Output .fastq file
    outputBinding:
      glob: '$(inputs.out_fastq)'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maq:v0.7.1-8-deb_cv1
