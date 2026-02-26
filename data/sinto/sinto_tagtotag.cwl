cwlVersion: v1.2
class: CommandLineTool
baseCommand: sinto_tagtotag
label: sinto_tagtotag
doc: "Copies BAM entries to a new file while copying a read tag to another read tag
  and optionally deleting the originating tag.\n\nTool homepage: https://timoast.github.io/sinto/"
inputs:
  - id: bam_file
    type: File
    doc: Input SAM/BAM file, '-' reads from stdin
    inputBinding:
      position: 101
      prefix: --bam
  - id: delete_originating_tag
    type:
      - 'null'
      - boolean
    doc: Delete originating tag after copy (i.e. move).
    inputBinding:
      position: 101
      prefix: --delete
  - id: from_tag
    type: string
    doc: Read tag to copy from.
    inputBinding:
      position: 101
      prefix: --from
  - id: output_format
    type:
      - 'null'
      - string
    doc: Output format. One of 't' (SAM), 'b' (BAM), or 'u' (uncompressed BAM)
    default: t
    inputBinding:
      position: 101
      prefix: --outputformat
  - id: to_tag
    type: string
    doc: Read tag to copy to.
    inputBinding:
      position: 101
      prefix: --to
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output SAM/BAM file, '-' outputs to stdout
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sinto:0.10.1--pyhdfd78af_0
