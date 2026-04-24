cwlVersion: v1.2
class: CommandLineTool
baseCommand: dupre
label: dupre
doc: "duplicate rate estimation from small subsamples\n\nTool homepage: https://bitbucket.org/genomeinformatics/dupre/"
inputs:
  - id: Zwidth
    type:
      - 'null'
      - float
    doc: allowed standard deviation of sum of most significant terms
    inputBinding:
      position: 101
      prefix: --Zwidth
  - id: complexity
    type:
      - 'null'
      - boolean
    doc: output complexity instead of duplication rate
    inputBinding:
      position: 101
      prefix: --complexity
  - id: full_occupancy
    type:
      - 'null'
      - type: array
        items: string
    doc: true occupancy vector of the full dataset (space-separated ints, or a 
      filename)
    inputBinding:
      position: 101
      prefix: --full
  - id: histogram
    type:
      - 'null'
      - boolean
    doc: instance data is given as PRESEQ histogram file(s)
    inputBinding:
      position: 101
      prefix: --histogram
  - id: k0
    type:
      - 'null'
      - int
    doc: occupancy number above which to use the heuristic
    inputBinding:
      position: 101
      prefix: --K0
  - id: name
    type:
      - 'null'
      - string
    doc: name of this problem instance
    inputBinding:
      position: 101
      prefix: --name
  - id: observed_occupancy
    type:
      - 'null'
      - type: array
        items: string
    doc: observed occupancy vector (space-separated ints, or a filename)
    inputBinding:
      position: 101
      prefix: --observed
  - id: stripnames
    type:
      - 'null'
      - boolean
    doc: strip instance names of observed occupancy vector of last component for
      lookup
    inputBinding:
      position: 101
      prefix: --stripnames
  - id: subsample
    type:
      - 'null'
      - string
    doc: subsample size, relative (ends with x) or absolute (integer), e.g. 
      '0.01x' or '10000'
    inputBinding:
      position: 101
      prefix: --subsample
  - id: target
    type:
      - 'null'
      - string
    doc: target size, relative (ends with x) or absolute (integer), e.g. '5x' or
      '1000000')
    inputBinding:
      position: 101
      prefix: --target
  - id: truth_occupancy
    type:
      - 'null'
      - type: array
        items: string
    doc: true occupancy vector of the full dataset (space-separated ints, or a 
      filename)
    inputBinding:
      position: 101
      prefix: --truth
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose output
    inputBinding:
      position: 101
      prefix: --verbose
  - id: zwidth
    type:
      - 'null'
      - float
    doc: allowed standard deviation for each expected occupancy
    inputBinding:
      position: 101
      prefix: --zwidth
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dupre:0.1--py35_0
stdout: dupre.out
