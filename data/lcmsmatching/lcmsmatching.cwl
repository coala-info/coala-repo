cwlVersion: v1.2
class: CommandLineTool
baseCommand: lcmsmatching
label: lcmsmatching
doc: "A tool for LC-MS matching (Note: The provided text is a system error log and
  does not contain help documentation or argument definitions).\n\nTool homepage:
  https://github.com/workflow4metabolomics/lcmsmatching"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/lcmsmatching:phenomenal-v3.4.3_cv1.5.70
stdout: lcmsmatching.out
