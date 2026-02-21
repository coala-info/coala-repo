cwlVersion: v1.2
class: CommandLineTool
baseCommand: pymol-jupiter
label: pymol-jupiter
doc: A tool for molecular visualization (PyMOL) likely integrated with Jupyter environments,
  as indicated by the container image name.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pymol-jupiter:v1.0.0_cv2
stdout: pymol-jupiter.out
