cwlVersion: v1.2
class: CommandLineTool
baseCommand: tidk explore
label: tidk_explore
doc: "Use a range of kmer sizes to find potential telomeric repeats.\nOne of either
  length, or minimum and maximum must be specified.\n\nTool homepage: https://github.com/tolkit/telomeric-identifier"
inputs:
  - id: fasta
    type: File
    doc: The input fasta file
    inputBinding:
      position: 1
  - id: distance
    type:
      - 'null'
      - float
    doc: The distance from the end of the chromosome as a proportion of 
      chromosome length. Must range from 0-0.5.
    default: 0.01
    inputBinding:
      position: 102
      prefix: --distance
  - id: length
    type:
      - 'null'
      - int
    doc: Length of substring
    inputBinding:
      position: 102
      prefix: --length
  - id: log
    type:
      - 'null'
      - boolean
    doc: Output a log file.
    inputBinding:
      position: 102
      prefix: --log
  - id: maximum
    type:
      - 'null'
      - int
    doc: Maximum length of substring
    default: 12
    inputBinding:
      position: 102
      prefix: --maximum
  - id: minimum
    type:
      - 'null'
      - int
    doc: Minimum length of substring
    default: 5
    inputBinding:
      position: 102
      prefix: --minimum
  - id: threshold
    type:
      - 'null'
      - int
    doc: Positions of repeats are only reported if they occur sequentially in a 
      greater number than the threshold
    default: 100
    inputBinding:
      position: 102
      prefix: --threshold
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tidk:0.2.65--h3dc2dae_0
stdout: tidk_explore.out
