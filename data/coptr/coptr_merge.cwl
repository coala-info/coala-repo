cwlVersion: v1.2
class: CommandLineTool
baseCommand: coptr_merge
label: coptr_merge
doc: "Merges multiple BAM files into a single BAM file.\n\nTool homepage: https://github.com/tyjo/coptr"
inputs:
  - id: in_bams
    type:
      type: array
      items: File
    doc: A space separated list of BAM files to merge. Assumes same reads were 
      mapped against different indexes. Only keeps read 1 of paired end 
      sequencing, since this is used downstream.
    inputBinding:
      position: 1
outputs:
  - id: out_bam
    type: File
    doc: Path to merged BAM.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coptr:1.1.4--pyhdfd78af_3
