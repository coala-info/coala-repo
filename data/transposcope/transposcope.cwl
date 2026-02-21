cwlVersion: v1.2
class: CommandLineTool
baseCommand: transposcope
label: transposcope
doc: "A tool for the analysis and visualization of transposable element integrations
  (Note: Help text provided was an error log and did not contain argument details).\n
  \nTool homepage: https://github.com/FenyoLab/transposcope"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transposcope:2.0.1--py_0
stdout: transposcope.out
