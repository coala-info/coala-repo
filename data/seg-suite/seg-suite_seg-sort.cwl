cwlVersion: v1.2
class: CommandLineTool
baseCommand: seg-sort
label: seg-suite_seg-sort
doc: "Sort segments in SEG format, in alphabetical order of sequence name, then ascending order of start coordinate (runs LC_ALL=C sort -b -k2,2 -k3n).\n\nTool homepage: https://github.com/mcfrith/seg-suite"
inputs:
  - id: seg_files
    type:
      type: array
      items: File
    doc: SEG file(s) to sort
    inputBinding:
      position: 1
outputs:
  - id: output
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seg-suite:98--py310h184ae93_0
stdout: seg-suite_seg-sort.out
