cwlVersion: v1.2
class: CommandLineTool
baseCommand: mhcnuggets_mnuggets_predict.py
label: mhcnuggets_mnuggets_predict.py
doc: "MHCnuggets: Peptide-MHC binding prediction. (Note: The provided input text contains
  system execution errors rather than the tool's help documentation.)\n\nTool homepage:
  http://karchinlab.org/apps/mhcnuggets.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mhcnuggets:2.4.1--pyh7cba7a3_0
stdout: mhcnuggets_mnuggets_predict.py.out
