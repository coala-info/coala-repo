cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - atlas
  - mergeOverlappingReads
label: atlas_mergeoverlappingreads
doc: "Merging paired-end reads in BAM file\n\nTool homepage: https://bitbucket.org/wegmannlab/atlas/wiki/Home"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
outputs:
  - id: output_bam
    type: File
    doc: Output BAM file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atlas:2.0.1--hadca570_0
