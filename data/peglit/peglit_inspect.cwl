cwlVersion: v1.2
class: CommandLineTool
baseCommand: peglit.inspect
label: peglit_inspect
doc: "Inspect a given linker for a pegRNA: print its score, subscores and predicted
  RNA structures (ensemble, MFE and suboptimal) for the extension and the full pegRNA.\n\nTool
  homepage: https://github.com/sshen8/peglit/"
inputs:
  - id: sequence
    type: string
    doc: pegRNA subsequences separated by commas in 5' -> 3' orientation (spacer,scaffold,template,pbs,motif)
    inputBinding:
      position: 1
  - id: linker
    type: string
    doc: Linker sequence to inspect
    inputBinding:
      position: 2
  - id: epsilon
    type:
      - 'null'
      - float
    doc: Basepairing probabilities are considered equal if their difference is less than this tolerance value
    inputBinding:
      position: 3
      prefix: --epsilon
  - id: scaffold_thresh
    type:
      - 'null'
      - float
    doc: A * marks a predicted structure whose scaffold interacts with the rest of the pegRNA with probability greater than this threshold
    inputBinding:
      position: 3
      prefix: --scaffold-thresh
  - id: motif_thresh
    type:
      - 'null'
      - float
    doc: A + marks a predicted structure whose motif interacts with the rest of the pegRNA with probability greater than this threshold
    inputBinding:
      position: 3
      prefix: --motif-thresh
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peglit:1.1.0--pyh7cba7a3_0
stdout: peglit_inspect.out
