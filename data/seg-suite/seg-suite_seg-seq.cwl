cwlVersion: v1.2
class: CommandLineTool
baseCommand: seg-seq
label: seg-suite_seg-seq
doc: "Get segments of sequences.\n\nTool homepage: https://github.com/mcfrith/seg-suite"
inputs:
  - id: segment_number
    type: ['null', int]
    doc: Use the Nth segment in each segment-tuple (default 1)
    inputBinding:
      position: 1
      prefix: -n
  - id: seg_file
    type: File
    doc: SEG file
    inputBinding:
      position: 2
  - id: fasta_files
    type:
      type: array
      items: File
    doc: FASTA file(s)
    inputBinding:
      position: 3
outputs:
  - id: output
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seg-suite:98--py310h184ae93_0
stdout: seg-suite_seg-seq.out
