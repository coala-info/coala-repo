cwlVersion: v1.2
class: CommandLineTool
baseCommand: peglit.score
label: peglit_score
doc: "Score a given linker for a pegRNA: PBS, spacer, template and scaffold basepairing
  subscores between 0 and 1 (higher is better).\n\nTool homepage: https://github.com/sshen8/peglit/"
inputs:
  - id: sequence
    type: string
    doc: pegRNA subsequences separated by commas in 5' -> 3' orientation (spacer,scaffold,template,pbs)
    inputBinding:
      position: 1
  - id: linker
    type: string
    doc: Linker sequence to score
    inputBinding:
      position: 2
  - id: max
    type:
      - 'null'
      - boolean
    doc: Pool basepairing probabilities of a subsequence by maximum instead of mean
    inputBinding:
      position: 3
      prefix: --max
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print more detail about the score
    inputBinding:
      position: 3
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peglit:1.1.0--pyh7cba7a3_0
stdout: peglit_score.out
