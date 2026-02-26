cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastqtk
  - trim-id
label: fastqtk_trim-id
doc: "It retains the beginning part of the reads ids all the way to the first blank
  space or newline. Basically the reads ids are truncated after the first blank space
  if they have one. Also the trims ids for the quality sequences (every third line
  is changed to +).\n\nTool homepage: https://github.com/ndaniel/fastqtk"
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
