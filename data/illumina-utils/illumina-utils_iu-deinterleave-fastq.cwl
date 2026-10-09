cwlVersion: v1.2
class: CommandLineTool
baseCommand: iu-deinterleave-fastq
label: illumina-utils_iu-deinterleave-fastq
doc: "De-interleave an interleaved FASTQ file

Tool homepage: https://github.com/meren/illumina-utils"
inputs:
  - id: input_fastq
    type: File
    doc: "FASTQ file to be de-interleaved"
    inputBinding:
      position: 1
  - id: output_r1
    type: string
    doc: "Read 1s"
    inputBinding:
      position: 2
      prefix: '-1'
  - id: output_r2
    type: string
    doc: "Read 2s"
    inputBinding:
      position: 3
      prefix: '-2'
outputs:
  - id: r1_out
    type: File
    doc: "Read 1s"
    outputBinding:
      glob: $(inputs.output_r1)
  - id: r2_out
    type: File
    doc: "Read 2s"
    outputBinding:
      glob: $(inputs.output_r2)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/illumina-utils:2.13--pyhdfd78af_0
