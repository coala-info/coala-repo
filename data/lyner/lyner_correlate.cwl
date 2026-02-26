cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
  - correlate
label: lyner_correlate
doc: "Calculate pairwise Pearson correlation coefficients between columns of a matrix.\n\
  \nTool homepage: https://github.com/tedil/lyner"
inputs:
  - id: method
    type:
      - 'null'
      - string
    doc: 'Correlation method to use. Options: pearson, kendall, spearman.'
    default: pearson
    inputBinding:
      position: 101
      prefix: --method
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Path to the output correlation matrix file.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
