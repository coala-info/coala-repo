cwlVersion: v1.2
class: CommandLineTool
baseCommand: xcfinfo
label: xcftools_xcfinfo
doc: "Print the size, mode and layers of a GIMP XCF file\n\nTool homepage: https://github.com/j-jorge/xcftools"
inputs:
  - id: xcf_file
    type: File
    doc: The input XCF file (optionally compressed, see gzip/bzip/unpack).
    inputBinding:
      position: 2
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Show progress messages.
    inputBinding:
      position: 1
      prefix: -v
  - id: bzip
    type:
      - 'null'
      - boolean
    doc: Input is bzip2 compressed.
    inputBinding:
      position: 1
      prefix: -j
  - id: path_separator
    type:
      - 'null'
      - string
    doc: Use 'string' to separate the groups in the paths.
    inputBinding:
      position: 1
      prefix: -p
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: Input is gzip compressed.
    inputBinding:
      position: 1
      prefix: -z
  - id: unpack
    type:
      - 'null'
      - string
    doc: Use 'command' to decompress input.
    inputBinding:
      position: 1
      prefix: -Z
  - id: utf8
    type:
      - 'null'
      - boolean
    doc: Use UTF-8 for layer names.
    inputBinding:
      position: 1
      prefix: -u
outputs:
  - id: info
    type: stdout
    doc: Layer listing printed by xcfinfo.
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xcftools:1.0.7--0
stdout: xcfinfo.txt
