cwlVersion: v1.2
class: CommandLineTool
baseCommand: biasaway
label: biasaway_background
doc: "Background generator offering the possibility of using very\ndifferent ways
  of generating backgrounds lying into two categories:\n    - Creation of new random
  sequences (generators):\n        - k-mer shuffling using the foreground sequences\n\
  \            -> type: `biasaway k -h`\n        - k-mer shuffling within a sliding
  window using foreground\n          sequences\n            -> type: `biasaway w -h`\n\
  \    - Extraction of sequences from a set of possible background sequences\n   \
  \   (choosers):\n        - respecting the %GC distribution of the foreground (using
  %GC\n          bins)\n            -> type: `biasaway g -h`\n        - respecting
  the %GC distribution as in the previous item and also\n          respecting the
  %GC composition within a sliding window for %GC\n          bin\n            -> type:
  `biasaway c -h`\n\nTool homepage: https://github.com/asntech/biasaway"
inputs:
  - id: subcommand
    type: string
    doc: Valid subcommands
    inputBinding:
      position: 1
  - id: c
    type:
      - 'null'
      - boolean
    doc: "%GC distribution and %GC composition within a sliding window\n         \
      \        background chooser"
    inputBinding:
      position: 102
  - id: g
    type:
      - 'null'
      - boolean
    doc: '%GC distribution-based background chooser'
    inputBinding:
      position: 102
  - id: k
    type:
      - 'null'
      - boolean
    doc: k-mer shuffling generator
    inputBinding:
      position: 102
  - id: w
    type:
      - 'null'
      - boolean
    doc: k-mer shuffling within a sliding window generator
    inputBinding:
      position: 102
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biasaway:3.3.0--py_0
stdout: biasaway_background.out
