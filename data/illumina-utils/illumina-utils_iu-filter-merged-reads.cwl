cwlVersion: v1.2
class: CommandLineTool
baseCommand: iu-filter-merged-reads
label: illumina-utils_iu-filter-merged-reads
doc: "Filter reads from a merged file based on maximum mismatches at the overlapped region

Tool homepage: https://github.com/meren/illumina-utils"
inputs:
  - id: input_fasta
    type: File
    doc: "FASTA file to be filtered"
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: "Where filtered reads will be written"
    inputBinding:
      position: 2
      prefix: '-o'
  - id: max_mismatches
    type:
      - 'null'
      - int
    doc: "Maximum number of mismatches allowed in the overlapped region"
    inputBinding:
      position: 3
      prefix: '-m'
outputs:
  - id: filtered_out
    type: File
    doc: "Filtered reads"
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/illumina-utils:2.13--pyhdfd78af_0
