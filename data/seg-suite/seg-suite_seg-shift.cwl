cwlVersion: v1.2
class: CommandLineTool
baseCommand: seg-shift
label: seg-suite_seg-shift
doc: "Expand or shrink each seg at either end. Do not expand past coordinate 0, and omit segs whose length would become negative.\n\nTool homepage: https://github.com/mcfrith/seg-suite"
inputs:
  - id: beg
    type: ['null', int]
    doc: Expand by this amount at the 5'-end
    inputBinding:
      position: 1
      prefix: --beg
  - id: end
    type: ['null', int]
    doc: Expand by this amount at the 3'-end
    inputBinding:
      position: 1
      prefix: --end
  - id: grow
    type: ['null', int]
    doc: Expand by this amount at both ends
    inputBinding:
      position: 1
      prefix: --grow
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
stdout: seg-suite_seg-shift.out
