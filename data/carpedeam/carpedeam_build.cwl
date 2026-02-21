cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - carpedeam
  - build
label: carpedeam_build
doc: "Build tool for carpedeam (Comparative Analysis of Regulatory Elements). Note:
  The provided text appears to be a log of a container build process rather than the
  tool's help text.\n\nTool homepage: https://github.com/LouisPwr/CarpeDeam"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/carpedeam:1.0.1--hd6d6fdc_0
stdout: carpedeam_build.out
