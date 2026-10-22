cwlVersion: v1.2
class: CommandLineTool
baseCommand: seg-swap
label: seg-suite_seg-swap
doc: "Swap the order of segments in segment-tuples.\n\nTool homepage: https://github.com/mcfrith/seg-suite"
inputs:
  - id: swap_index
    type: ['null', int]
    doc: Swap the Nth segment with the first segment (default=2)
    inputBinding:
      position: 1
      prefix: -n
  - id: no_canonicalize_strands
    type: ['null', boolean]
    doc: Do not canonicalize strands
    inputBinding:
      position: 1
      prefix: -s
  - id: seg_files
    type:
      type: array
      items: File
    doc: SEG file(s)
    inputBinding:
      position: 2
outputs:
  - id: output
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seg-suite:98--py310h184ae93_0
stdout: seg-suite_seg-swap.out
