cwlVersion: v1.2
class: CommandLineTool
baseCommand: cpstools SSRs
label: cpstools_SSRs
doc: "Find Simple Sequence Repeats (SSRs) in GenBank files.\n\nTool homepage: https://github.com/Xwb7533/CPStools"
inputs:
  - id: input_file
    type: File
    doc: GenBank format file
    inputBinding:
      position: 101
      prefix: --input_file
  - id: kmer_length
    type:
      - 'null'
      - string
    doc: SSRs length
    inputBinding:
      position: 101
      prefix: --kmer_length
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cpstools:3.0--pyhdfd78af_0
stdout: cpstools_SSRs.out
