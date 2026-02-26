cwlVersion: v1.2
class: CommandLineTool
baseCommand: sumpaps
label: pmidcite_sumpaps
doc: "Summarize NIH's citation data on a set(s) of papers\n\nTool homepage: http://github.com/dvklopfenstein/pmidcite"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: File(s) containing NIH citation data for numerous papers with PMIDs
    inputBinding:
      position: 1
  - id: group1_min
    type:
      - 'null'
      - float
    doc: Minimum NIH percentile to be placed in group 1
    default: 2.1
    inputBinding:
      position: 102
      prefix: '-1'
  - id: group2_min
    type:
      - 'null'
      - float
    doc: Minimum NIH percentile to be placed in group 2
    default: 30.0
    inputBinding:
      position: 102
      prefix: '-2'
  - id: group3_min
    type:
      - 'null'
      - float
    doc: Minimum NIH percentile to be placed in group 3
    default: 60.0
    inputBinding:
      position: 102
      prefix: '-3'
  - id: group4_min
    type:
      - 'null'
      - float
    doc: Minimum NIH percentile to be placed in group 4
    default: 94.0
    inputBinding:
      position: 102
      prefix: '-4'
  - id: labels
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Paper label choices: TOP CIT CLI REF CITS ALL'
    default: TOP
    inputBinding:
      position: 102
      prefix: -p
  - id: print_nih_dividers
    type:
      - 'null'
      - boolean
    doc: Print the NIH percentile grouper divider percentages
    inputBinding:
      position: 102
      prefix: --print-NIH-dividers
  - id: print_rcfile
    type:
      - 'null'
      - boolean
    doc: 'Print the location of the pmidcite configuration file (env var: PMIDCITECONF)'
    inputBinding:
      position: 102
      prefix: --print-rcfile
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pmidcite:0.3.1--pyhdfd78af_0
stdout: pmidcite_sumpaps.out
