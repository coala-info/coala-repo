cwlVersion: v1.2
class: CommandLineTool
baseCommand: seg-merge
label: seg-suite_seg-merge
doc: "Merge overlapping and touching segment-tuples.\n\nTool homepage: https://github.com/mcfrith/seg-suite"
inputs:
  - id: seg_files
    type:
      type: array
      items: File
    doc: SEG file(s)
    inputBinding:
      position: 1
outputs:
  - id: output
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seg-suite:98--py310h184ae93_0
stdout: seg-suite_seg-merge.out
