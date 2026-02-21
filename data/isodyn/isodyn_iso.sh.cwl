cwlVersion: v1.2
class: CommandLineTool
baseCommand: isodyn_iso.sh
label: isodyn_iso.sh
doc: "IsoDyn is a software tool for the modeling of metabolic and isotope dynamics.
  Note: The provided text contains system error messages regarding container image
  building and does not list specific command-line arguments.\n\nTool homepage: https://github.com/seliv55/isodyn"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/isodyn:phenomenal-v1.0_cv0.2.52
stdout: isodyn_iso.sh.out
