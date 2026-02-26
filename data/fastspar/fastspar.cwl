cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastspar
label: fastspar
doc: "c++ implementation of SparCC\n\nTool homepage: https://github.com/scwatts/fastspar"
inputs:
  - id: exclusion_iterations
    type:
      - 'null'
      - int
    doc: Number of exclusion interations to perform
    default: 10
    inputBinding:
      position: 101
      prefix: --exclusion_iterations
  - id: iterations
    type:
      - 'null'
      - int
    doc: Number of interations to perform
    default: 50
    inputBinding:
      position: 101
      prefix: --iterations
  - id: otu_table
    type: File
    doc: OTU input OTU count table
    inputBinding:
      position: 101
      prefix: --otu_table
  - id: seed
    type:
      - 'null'
      - int
    doc: Random number generator seed
    default: 1
    inputBinding:
      position: 101
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: threshold
    type:
      - 'null'
      - float
    doc: Correlation strength exclusion threshold
    default: 0.1
    inputBinding:
      position: 101
      prefix: --threshold
  - id: yes
    type:
      - 'null'
      - boolean
    doc: Assume yes for prompts
    inputBinding:
      position: 101
      prefix: --yes
outputs:
  - id: correlation
    type: File
    doc: Correlation output table
    outputBinding:
      glob: $(inputs.correlation)
  - id: covariance
    type: File
    doc: Covariance output table
    outputBinding:
      glob: $(inputs.covariance)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastspar:1.0.0--h1b620e3_6
