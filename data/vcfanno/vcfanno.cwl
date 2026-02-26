cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcfanno
label: vcfanno
doc: "vcfanno version 0.3.7 [built with go1.24.6]\n\nTool homepage: https://github.com/brentp/vcfanno"
inputs:
  - id: base_path
    type:
      - 'null'
      - string
    doc: optional base-path to prepend to annotation files in the config
    inputBinding:
      position: 101
      prefix: -base-path
  - id: ends
    type:
      - 'null'
      - boolean
    doc: annotate the start and end as well as the interval itself.
    inputBinding:
      position: 101
      prefix: -ends
  - id: lua
    type:
      - 'null'
      - string
    doc: optional path to a file containing custom lua functions to be used as 
      ops
    inputBinding:
      position: 101
      prefix: -lua
  - id: permissive_overlap
    type:
      - 'null'
      - boolean
    doc: annotate with an overlapping variant even it doesn't share the same ref
      and alt alleles. Default is to require exact match between variants.
    inputBinding:
      position: 101
      prefix: -permissive-overlap
  - id: processes
    type:
      - 'null'
      - int
    doc: number of processes to use.
    default: 2
    inputBinding:
      position: 101
      prefix: -p
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfanno:0.3.7--he881be0_0
stdout: vcfanno.out
