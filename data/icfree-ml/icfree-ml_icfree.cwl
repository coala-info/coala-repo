cwlVersion: v1.2
class: CommandLineTool
baseCommand: icfree-ml
label: icfree-ml_icfree
doc: "A tool for machine learning in cell-free systems. (Note: The provided text contains
  only container runtime error messages and no specific help documentation for the
  tool's arguments.)\n\nTool homepage: https://github.com/brsynth/icfree-ml"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/icfree-ml:2.9.1--pyhdfd78af_0
stdout: icfree-ml_icfree.out
