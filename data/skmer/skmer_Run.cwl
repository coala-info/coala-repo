cwlVersion: v1.2
class: CommandLineTool
baseCommand: skmer
label: skmer_Run
doc: "skmer: error: argument {commands}: invalid choice: 'Run' (choose from 'reference',
  'subsample', 'correct', 'distance', 'query')\n\nTool homepage: https://github.com/shahab-sarmashghi/Skmer"
inputs:
  - id: commands
    type: string
    doc: 'Available commands: reference, subsample, correct, distance, query'
    inputBinding:
      position: 1
  - id: debug
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --debug
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/skmer:3.3.0--pyh086e186_0
stdout: skmer_Run.out
