cwlVersion: v1.2
class: CommandLineTool
baseCommand: iu-trim-fastq
label: illumina-utils_iu-trim-fastq
doc: "Trim Illumina reads\n\nTool homepage: https://github.com/meren/illumina-utils"
inputs:
  - id: input_file
    type: File
    doc: FASTQ file to be trimmed
    inputBinding:
      position: 1
  - id: trim_from
    type:
      - 'null'
      - int
    doc: Trim from
    inputBinding:
      position: 102
      prefix: --trim-from
  - id: trim_to
    type:
      - 'null'
      - int
    doc: Trim to
    inputBinding:
      position: 102
      prefix: --trim-to
outputs:
  - id: output_file
    type: File
    doc: 'Where trimmed sequences will be written (default: [-i]-TRIMMED-TO-[-l])'
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/illumina-utils:2.13--pyhdfd78af_0
