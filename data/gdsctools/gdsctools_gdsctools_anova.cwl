cwlVersion: v1.2
class: CommandLineTool
baseCommand: gdsctools_anova
label: gdsctools_gdsctools_anova
doc: "ANOVA analysis for Genomic Drug Sensitivity Collaboration (GDSCTools). Note:
  The provided help text contains only system error messages regarding container execution
  and does not list specific command-line arguments.\n\nTool homepage: http://pypi.python.org/pypi/gdsctools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gdsctools:1.0.1--py_0
stdout: gdsctools_gdsctools_anova.out
