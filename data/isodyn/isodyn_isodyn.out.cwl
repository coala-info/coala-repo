cwlVersion: v1.2
class: CommandLineTool
baseCommand: isodyn.out
label: isodyn_isodyn.out
doc: "IsoDyn is a software tool for metabolic modeling and flux analysis, typically
  used for simulating isotopic non-stationary metabolic states.\n\nTool homepage:
  https://github.com/seliv55/isodyn"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/isodyn:phenomenal-v1.0_cv0.2.52
stdout: isodyn_isodyn.out.out
