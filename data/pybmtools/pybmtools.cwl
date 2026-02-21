cwlVersion: v1.2
class: CommandLineTool
baseCommand: pybmtools
label: pybmtools
doc: "The provided text appears to be a container build error log rather than CLI
  help text. No usage information or arguments could be extracted.\n\nTool homepage:
  https://github.com/ZhouQiangwei/pybmtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pybmtools:0.1.3--py38h5df1436_1
stdout: pybmtools.out
