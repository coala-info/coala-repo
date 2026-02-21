cwlVersion: v1.2
class: CommandLineTool
baseCommand: isodyn
label: isodyn
doc: "Isodyn is a software tool for metabolic modeling and isotope distribution analysis
  (description inferred from tool name as the provided text contains only container
  runtime errors).\n\nTool homepage: https://github.com/seliv55/isodyn"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/isodyn:phenomenal-v1.0_cv0.2.52
stdout: isodyn.out
