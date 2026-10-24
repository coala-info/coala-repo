cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigWigCorrelate
label: ucsc-bigwigcorrelate
doc: "Correlate bigWig files, optionally only on target regions.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: bigwig_files
    type:
      type: array
      items: File
    doc: "Two bigWig files, or one file listing bigWig file names (listOfFiles)"
    inputBinding:
      position: 1
  - id: restrict
    type:
      - 'null'
      - File
    doc: "Restrict correlation to parts covered by this bigBed file"
    inputBinding:
      position: 101
      prefix: -restrict=
      separate: false
  - id: threshold
    type:
      - 'null'
      - float
    doc: "Clip values to this threshold"
    inputBinding:
      position: 101
      prefix: -threshold=
      separate: false
  - id: root_names
    type:
      - 'null'
      - boolean
    doc: "If set just report the root (minus directory and suffix) of file names when using listOfFiles"
    inputBinding:
      position: 101
      prefix: -rootNames
  - id: ignore_missing
    type:
      - 'null'
      - boolean
    doc: "If set do not correlate where either side is missing data. Normally missing data is treated as zeros"
    inputBinding:
      position: 101
      prefix: -ignoreMissing
outputs:
  - id: stdout
    type: stdout
    doc: "Correlation values"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bigwigcorrelate:482--h0b57e2e_0
stdout: ucsc-bigwigcorrelate.out
