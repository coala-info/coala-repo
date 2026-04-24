cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfatools_blacklist
label: gfatools_blacklist
doc: "Identify and output regions from a GFA graph that are considered 'blacklisted'.\n\
  \nTool homepage: https://github.com/lh3/gfatools"
inputs:
  - id: input_gfa
    type: File
    doc: Input GFA file
    inputBinding:
      position: 1
  - id: include_both_strands
    type:
      - 'null'
      - boolean
    doc: include regions involving both strands (mostly inversions)
    inputBinding:
      position: 102
      prefix: -b
  - id: min_region_length
    type:
      - 'null'
      - int
    doc: min region length
    inputBinding:
      position: 102
      prefix: -l
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfatools:0.5.5--h577a1d6_0
stdout: gfatools_blacklist.out
