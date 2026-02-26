cwlVersion: v1.2
class: CommandLineTool
baseCommand: tagbam
label: tagbam
doc: "Tag reads in BAM file\n\nTool homepage: https://github.com/fellen31/tagbam"
inputs:
  - id: compression
    type:
      - 'null'
      - int
    doc: BAM output compression level
    default: 6
    inputBinding:
      position: 101
      prefix: --compression
  - id: input
    type: File
    doc: Input BAM file
    inputBinding:
      position: 101
      prefix: --input
  - id: tag
    type: string
    doc: Tag to add (must be 1-2 characters)
    inputBinding:
      position: 101
      prefix: --tag
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of parallel decompression & writer threads to use
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
  - id: value
    type: string
    doc: Value to add
    inputBinding:
      position: 101
      prefix: --value
outputs:
  - id: output_file
    type: File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tagbam:0.1.0--h3ab6199_0
