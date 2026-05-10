cwlVersion: v1.2
class: CommandLineTool
baseCommand: metacache
label: metacache_help
doc: "MetaCache  Copyright (C) 2016-2026  André Müller & Robin Kobus\nThis program
  comes with ABSOLUTELY NO WARRANTY.\nThis is free software, and you are welcome to
  redistribute it\nunder certain conditions. See the file 'LICENSE' for details.\n\
  \nTool homepage: https://github.com/muellan/metacache"
inputs:
  - id: mode
    type: string
    doc: 'Available modes: help, build, modify, query, build+query, merge, info'
    inputBinding:
      position: 1
  - id: pairfiles
    type:
      - 'null'
      - boolean
    doc: Query paired-end reads in separate files
    inputBinding:
      position: 102
      prefix: -pairfiles
  - id: pairseq
    type:
      - 'null'
      - boolean
    doc: Query paired-end reads in one file (a1,a2,b1,b2,...)
    inputBinding:
      position: 102
      prefix: -pairseq
  - id: out_path
    type: string
    doc: Output or path parameter `out_path`
    inputBinding:
      position: 103
      prefix: --out
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.out_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metacache:2.6.0--h077b44d_0
