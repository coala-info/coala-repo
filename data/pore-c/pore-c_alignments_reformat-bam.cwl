cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pore_c, alignments, reformat-bam]
label: pore-c_alignments_reformat-bam
doc: "Reformat query names of a SAM/BAM file so that each alignment has a unique name (read_id:read_idx:align_idx) and add a BX tag.\n\nTool homepage: https://github.com/nanoporetech/pore-c"
inputs:
  - id: input_is_bam
    type:
      - 'null'
      - boolean
    doc: "If piping a BAM from stdin (rather than sam)"
    inputBinding:
      position: 1
      prefix: --input-is-bam
  - id: output_is_bam
    type:
      - 'null'
      - boolean
    doc: "If piping a BAM to stdout (rather than sam)"
    inputBinding:
      position: 1
      prefix: --output-is-bam
  - id: set_bx_flag
    type:
      - 'null'
      - boolean
    doc: "Set the BX tag to the read name"
    inputBinding:
      position: 1
      prefix: --set-bx-flag
  - id: input_sam
    type: File
    doc: "Input SAM/BAM file"
    inputBinding:
      position: 10
  - id: output_sam
    type: string
    doc: "Output SAM/BAM file name"
    inputBinding:
      position: 11
outputs:
  - id: reformatted
    type: File
    doc: "Reformatted alignment file"
    outputBinding:
      glob: "$(inputs.output_sam)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pore-c:0.4.0--pyhdfd78af_0
