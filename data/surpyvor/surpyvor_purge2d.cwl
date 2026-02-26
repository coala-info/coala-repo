cwlVersion: v1.2
class: CommandLineTool
baseCommand: surpyvor purge2d
label: surpyvor_purge2d
doc: "Filter alignments from a BAM file.\n\nTool homepage: https://github.com/wdecoster/surpyvor"
inputs:
  - id: bam
    type: File
    doc: bam file to filter
    inputBinding:
      position: 1
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print out more information while running.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: sam/bam file to write filtered alignments to
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/surpyvor:0.15.0--pyhdfd78af_0
