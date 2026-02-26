cwlVersion: v1.2
class: CommandLineTool
baseCommand: cooler ln
label: cooler_ln
doc: "Create a hard link to a cooler (rather than a true copy) in the same file.\n\
  \  Also supports soft links (in the same file) or external links (different\n  files).\n\
  \nTool homepage: https://github.com/open2c/cooler"
inputs:
  - id: src_uri
    type: string
    doc: Source URI
    inputBinding:
      position: 1
  - id: dst_uri
    type: string
    doc: Destination URI
    inputBinding:
      position: 2
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Truncate and replace destination file if it already exists.
    inputBinding:
      position: 103
      prefix: --overwrite
  - id: soft
    type:
      - 'null'
      - boolean
    doc: "Creates a soft link rather than a hard link if the source\n            \
      \       and destination file are the same. Otherwise, creates an\n         \
      \          external link. This type of link uses a path rather than a\n    \
      \               pointer."
    inputBinding:
      position: 103
      prefix: --soft
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cooler:0.10.4--pyhdfd78af_0
stdout: cooler_ln.out
