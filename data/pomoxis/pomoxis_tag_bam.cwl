cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tag_bam
label: pomoxis_tag_bam
doc: "Add a tag to all alignments in a bam.\n\nTool homepage: https://github.com/nanoporetech/pomoxis"
inputs:
  - id: input
    type: File
    doc: Input bam file.
    inputBinding:
      position: 1
  - id: output
    type: string
    default: tagged.bam
    doc: Output bam file.
    inputBinding:
      position: 2
  - id: tag_name
    type: string
    doc: Tag name.
    inputBinding:
      position: 3
  - id: tag_value
    type: int
    doc: Tag value (an integer).
    inputBinding:
      position: 4
outputs:
  - id: tagged_bam
    type: File
    doc: Bam file with the tag added.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
