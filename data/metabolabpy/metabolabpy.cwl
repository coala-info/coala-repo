cwlVersion: v1.2
class: CommandLineTool
baseCommand: metabolabpy
label: metabolabpy
doc: "A tool for metabolomics data analysis. (Note: The provided text contains system
  error messages regarding a container build failure and does not include the actual
  help documentation or argument definitions.)\n\nTool homepage: https://github.com/ludwigc/metabolabpy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabolabpy:0.9.85--pyhdfd78af_0
stdout: metabolabpy.out
