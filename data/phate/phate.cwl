cwlVersion: v1.2
class: CommandLineTool
baseCommand: phate
label: phate
doc: "PHATE (Potential of Heat-diffusion for Affinity-based Transition Embedding)
  is a tool for visualizing high-dimensional data.\n\nTool homepage: https://github.com/KrishnaswamyLab/PHATE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phate:2.0.0--pyhdfd78af_0
stdout: phate.out
