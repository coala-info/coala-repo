cwlVersion: v1.2
class: CommandLineTool
baseCommand: cooler cp
label: cooler_cp
doc: "Copy a cooler from one file to another or within the same file.\n\nTool homepage:
  https://github.com/open2c/cooler"
inputs:
  - id: src_uri
    type: string
    doc: Source cooler URI
    inputBinding:
      position: 1
  - id: dst_uri
    type: string
    doc: Destination cooler URI
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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cooler:0.10.4--pyhdfd78af_0
stdout: cooler_cp.out
