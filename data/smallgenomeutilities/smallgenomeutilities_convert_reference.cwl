cwlVersion: v1.2
class: CommandLineTool
baseCommand: convert_reference
label: smallgenomeutilities_convert_reference
doc: "Convert reference sequences based on MSA and BAM alignment.\n\nTool homepage:
  https://github.com/cbg-ethz/smallgenomeutilities"
inputs:
  - id: hard_clip_bases
    type:
      - 'null'
      - boolean
    doc: Hard-clip bases instead of the default soft-clipping
    inputBinding:
      position: 101
      prefix: -H
  - id: input_sam_bam
    type: File
    doc: Input SAM/BAM file
    inputBinding:
      position: 101
      prefix: -i
  - id: insert_padding
    type:
      - 'null'
      - boolean
    doc: Insert silent padding states 'P' in CIGAR
    inputBinding:
      position: 101
      prefix: -p
  - id: msa_input
    type: File
    doc: MSA input of all contigs aligned
    inputBinding:
      position: 101
      prefix: -m
  - id: target_contig_name
    type: string
    doc: Name of target contig
    inputBinding:
      position: 101
      prefix: -t
  - id: use_x_slash_for_match_mismatch
    type:
      - 'null'
      - boolean
    doc: Use X/= instead of M for Match/Mismatch states
    inputBinding:
      position: 101
      prefix: -X
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print more information
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_sam_bam
    type:
      - 'null'
      - File
    doc: Output SAM/BAM file
    outputBinding:
      glob: $(inputs.output_sam_bam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smallgenomeutilities:0.5.2--pyhdfd78af_0
