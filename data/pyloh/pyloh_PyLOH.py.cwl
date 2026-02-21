cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyloh_PyLOH.py
label: pyloh_PyLOH.py
doc: "PyLOH (Python tool for Deconvolution of tumor purity and profiling of copy number
  alterations). Note: The provided text contains execution logs and a fatal error
  rather than help documentation; therefore, no arguments could be extracted.\n\n
  Tool homepage: https://github.com/uci-cbcl/PyLOH"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyloh:1.4.3--py27_0
stdout: pyloh_PyLOH.py.out
