cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rtg
  - sdfstats
label: rtg-tools_rtg_sdfstats
doc: 'Print statistics that describe a directory of SDF formatted data. Tool homepage: https://github.com/RealTimeGenomics/rtg-tools'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: lengths
    type:
      - 'null'
      - boolean
    doc: 'print out the name and length of each sequence. (Not recommended for read sets)'
    inputBinding:
      position: 101
      prefix: --lengths
  - id: position
    type:
      - 'null'
      - boolean
    doc: 'only display info about unknown bases (Ns) by read position'
    inputBinding:
      position: 101
      prefix: --position
  - id: quality
    type:
      - 'null'
      - boolean
    doc: 'display mean of quality'
    inputBinding:
      position: 101
      prefix: --quality
  - id: sex
    type:
      - 'null'
      - string
    doc: 'display reference sequence list for the given sex, if defined. Allowed values are [male, female, either]. May be specified 0 or more times, or as a comma separated list'
    inputBinding:
      position: 101
      prefix: --sex
  - id: taxonomy
    type:
      - 'null'
      - boolean
    doc: 'display information about taxonomy'
    inputBinding:
      position: 101
      prefix: --taxonomy
  - id: unknowns
    type:
      - 'null'
      - boolean
    doc: 'display info about unknown bases (Ns)'
    inputBinding:
      position: 101
      prefix: --unknowns
  - id: sdfs
    type:
      type: array
      items: Directory
    doc: 'SDF directories. Must be specified 1 or more times'
    inputBinding:
      position: 200
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
stdout: rtg-tools_rtg_sdfstats.out
