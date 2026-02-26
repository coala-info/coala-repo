cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - maq
  - sol2sanger
label: maq_sol2sanger
doc: "Convert Sanger FASTQ to MAQ FASTQ\n\nTool homepage: https://github.com/maqetta/maqetta"
inputs:
  - id: input_fastq
    type: File
    doc: Input Sanger FASTQ file
    inputBinding:
      position: 1
outputs:
  - id: output_fastq
    type: File
    doc: Output MAQ FASTQ file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maq:v0.7.1-8-deb_cv1
