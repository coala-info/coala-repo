cwlVersion: v1.2
class: CommandLineTool
baseCommand: svtk pe-test
label: svtk_pe-test
doc: "Calculate enrichment of discordant pairs at SV breakpoints.\n\nTool homepage:
  https://github.com/talkowski-lab/svtk"
inputs:
  - id: vcf
    type: File
    doc: Variants.
    inputBinding:
      position: 1
  - id: disc
    type: File
    doc: Table of discordant pair coordinates.
    inputBinding:
      position: 2
  - id: background
    type:
      - 'null'
      - int
    doc: Number of background samples to sample for PE evidence.
    default: 160
    inputBinding:
      position: 103
      prefix: --background
  - id: index
    type:
      - 'null'
      - File
    doc: Tabix index of discordant pair file. Required if discordant pair file 
      is hosted remotely.
    inputBinding:
      position: 103
      prefix: --index
  - id: log
    type:
      - 'null'
      - boolean
    doc: Print progress log to stderr.
    inputBinding:
      position: 103
      prefix: --log
  - id: medianfile
    type:
      - 'null'
      - File
    doc: Median coverage statistics for each library (optional). If provided, 
      each sample's split counts will be normalized accordingly. Same format as 
      RdTest, one column per sample.
    inputBinding:
      position: 103
      prefix: --medianfile
  - id: samples
    type:
      - 'null'
      - string
    doc: Whitelist of samples to restrict testing to.
    inputBinding:
      position: 103
      prefix: --samples
  - id: window_in
    type:
      - 'null'
      - int
    doc: Window inside breakpoint to query for discordant pairs.
    default: 50
    inputBinding:
      position: 103
      prefix: --window-in
  - id: window_out
    type:
      - 'null'
      - int
    doc: Window outside breakpoint to query for discordant pairs.
    default: 500
    inputBinding:
      position: 103
      prefix: --window-out
outputs:
  - id: fout
    type: File
    doc: Output table of PE counts.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtk:0.0.20190615--py39hbcbf7aa_7
