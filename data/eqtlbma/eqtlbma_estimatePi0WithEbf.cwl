cwlVersion: v1.2
class: CommandLineTool
baseCommand: eqtlbma_estimatePi0WithEbf
label: eqtlbma_estimatePi0WithEbf
doc: "Estimate the proportion of null hypotheses (pi0) using Empirical Bayes Factors
  (EBF). Note: The provided help text contains only system error messages regarding
  container execution and does not list specific command-line arguments.\n\nTool homepage:
  https://github.com/timflutre/eqtlbma"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eqtlbma:1.3.3--h3dbd7e7_0
stdout: eqtlbma_estimatePi0WithEbf.out
