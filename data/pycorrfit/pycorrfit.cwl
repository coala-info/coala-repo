cwlVersion: v1.2
class: CommandLineTool
baseCommand: pycorrfit
label: pycorrfit
doc: "A tool for Fluorescence Correlation Spectroscopy (FCS) data analysis.\n\nTool
  homepage: https://github.com/FCS-analysis/PyCorrFit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pycorrfit:v1.1.5dfsg-1-deb_cv1
stdout: pycorrfit.out
