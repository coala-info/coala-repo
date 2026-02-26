cwlVersion: v1.2
class: CommandLineTool
baseCommand: divvier
label: divvier
doc: "a program for MSA processing\n\nTool homepage: https://github.com/simonwhelan/Divvier"
inputs:
  - id: input_file
    type: File
    doc: input file
    inputBinding:
      position: 1
  - id: approx
    type:
      - 'null'
      - int
    doc: minimum number of characters tested in a split during divvying
    default: 10
    inputBinding:
      position: 102
      prefix: -approx
  - id: checksplits
    type:
      - 'null'
      - boolean
    doc: go through sequence and ensure there's a pair for every split. Can be 
      slow
    inputBinding:
      position: 102
      prefix: -checksplits
  - id: divvy
    type:
      - 'null'
      - boolean
    doc: do standard divvying
    default: true
    inputBinding:
      position: 102
      prefix: -divvy
  - id: divvygap
    type:
      - 'null'
      - boolean
    doc: Output a gap instead of the static * character so divvied MSAs can be 
      used in phylogeny program
    inputBinding:
      position: 102
      prefix: -divvygap
  - id: hmm_approx
    type:
      - 'null'
      - boolean
    doc: Do the pairHMM bounding approximation
    default: true
    inputBinding:
      position: 102
      prefix: -HMMapprox
  - id: hmm_exact
    type:
      - 'null'
      - boolean
    doc: Do the full pairHMM and ignore bounding
    inputBinding:
      position: 102
      prefix: -HMMexact
  - id: mincol
    type:
      - 'null'
      - int
    doc: Minimum number of characters in a column to output when 
      divvying/filtering
    default: 2
    inputBinding:
      position: 102
      prefix: -mincol
  - id: partial
    type:
      - 'null'
      - boolean
    doc: do partial filtering by testing removal of individual characters
    inputBinding:
      position: 102
      prefix: -partial
  - id: thresh
    type:
      - 'null'
      - float
    doc: set the threshold for divvying to X
    inputBinding:
      position: 102
      prefix: -thresh
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/divvier:1.01--h5ca1c30_5
stdout: divvier.out
