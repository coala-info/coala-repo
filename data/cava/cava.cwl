cwlVersion: v1.2
class: CommandLineTool
baseCommand: cava
label: cava
doc: "CAVA (Clinical Annotation of VAriants) is a lightweight, fast and flexible NGS
  variant annotation tool.\n\nTool homepage: https://github.com/karlstav/cava"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/cava:v1.1.1_cv2
stdout: cava.out
