cwlVersion: v1.2
class: CommandLineTool
baseCommand: iso2flux_solve_iso2flux_label.py
label: iso2flux_solve_iso2flux_label.py
doc: "A tool for solving label distributions using iso2flux. Note: The provided help
  text contains only system error messages and does not list command-line arguments.\n
  \nTool homepage: https://github.com/cfoguet/iso2flux"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/iso2flux:phenomenal-v0.7.1_cv2.1.60
stdout: iso2flux_solve_iso2flux_label.py.out
