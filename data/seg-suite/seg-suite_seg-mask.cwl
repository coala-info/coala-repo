cwlVersion: v1.2
class: CommandLineTool
baseCommand: seg-mask
label: seg-suite_seg-mask
doc: "Mask segments in sequences.\n\nTool homepage: https://github.com/mcfrith/seg-suite"
inputs:
  - id: mask_letter
    type: ['null', string]
    doc: Letter to use for masking, instead of lowercase
    inputBinding:
      position: 1
      prefix: -x
  - id: preserve_case
    type: ['null', boolean]
    doc: Preserve uppercase/lowercase in non-masked regions
    inputBinding:
      position: 1
      prefix: -c
  - id: seg_file
    type: File
    doc: SEG file
    inputBinding:
      position: 2
  - id: sequence_file
    type: File
    doc: FASTA or FASTQ file
    inputBinding:
      position: 3
outputs:
  - id: output
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seg-suite:98--py310h184ae93_0
stdout: seg-suite_seg-mask.out
