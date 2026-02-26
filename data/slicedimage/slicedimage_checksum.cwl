cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - slicedimage
  - checksum
label: slicedimage_checksum
doc: "Calculate and write checksums for a sliced image partition file.\n\nTool homepage:
  https://github.com/spacetx/slicedimage"
inputs:
  - id: in_url
    type: string
    doc: URL for the source partition file
    inputBinding:
      position: 1
  - id: pretty
    type:
      - 'null'
      - boolean
    doc: Pretty-print the output file
    inputBinding:
      position: 102
      prefix: --pretty
outputs:
  - id: out_path
    type: File
    doc: Path to write partition file with checksums
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slicedimage:3.1.2--py_0
