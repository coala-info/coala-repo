cwlVersion: v1.2
class: CommandLineTool
baseCommand: iu-interleave-fastq
label: illumina-utils_iu-interleave-fastq
doc: "Interleave two FASTQ files (read 1 and read 2) into one

Tool homepage: https://github.com/meren/illumina-utils"
inputs:
  - id: input_r1
    type: File
    doc: "Read 1"
    inputBinding:
      position: 1
      prefix: '-1'
  - id: input_r2
    type: File
    doc: "Read 2"
    inputBinding:
      position: 2
      prefix: '-2'
  - id: output_file_path
    type: string
    doc: "Interleaved FASTQ file path"
    inputBinding:
      position: 3
      prefix: '-o'
outputs:
  - id: interleaved_out
    type: File
    doc: "Interleaved FASTQ file"
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/illumina-utils:2.13--pyhdfd78af_0
