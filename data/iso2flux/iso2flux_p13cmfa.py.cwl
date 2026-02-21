cwlVersion: v1.2
class: CommandLineTool
baseCommand: iso2flux_p13cmfa.py
label: iso2flux_p13cmfa.py
doc: "A tool for 13C Metabolic Flux Analysis (MFA). Note: The provided input text
  contains system error messages regarding container execution and does not include
  usage instructions or argument definitions.\n\nTool homepage: https://github.com/cfoguet/iso2flux"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/iso2flux:phenomenal-v0.7.1_cv2.1.60
stdout: iso2flux_p13cmfa.py.out
