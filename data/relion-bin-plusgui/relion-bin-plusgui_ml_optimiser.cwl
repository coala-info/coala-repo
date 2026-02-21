cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_ml_optimiser
label: relion-bin-plusgui_ml_optimiser
doc: "Maximum Likelihood (ML) optimiser from the RELION (REgularised LIkelihood OptimizatioN)
  package.\n\nTool homepage: https://github.com/3dem/relion"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/relion-bin-plusgui:v1.4dfsg-4-deb_cv1
stdout: relion-bin-plusgui_ml_optimiser.out
