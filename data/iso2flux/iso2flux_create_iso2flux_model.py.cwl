cwlVersion: v1.2
class: CommandLineTool
baseCommand: iso2flux_create_iso2flux_model.py
label: iso2flux_create_iso2flux_model.py
doc: "Create iso2flux model (Note: The provided help text contains system error logs
  rather than tool usage information).\n\nTool homepage: https://github.com/cfoguet/iso2flux"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/iso2flux:phenomenal-v0.7.1_cv2.1.60
stdout: iso2flux_create_iso2flux_model.py.out
