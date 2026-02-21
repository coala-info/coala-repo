cwlVersion: v1.2
class: CommandLineTool
baseCommand: sipros_sipros_psm_tabulating.py
label: sipros_sipros_psm_tabulating.py
doc: "Sipros PSM tabulating tool. (Note: The provided text contains container runtime
  error logs rather than the tool's help documentation, so no arguments could be extracted.)\n
  \nTool homepage: https://github.com/thepanlab/Sipros4"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sipros:5.0.1--hdfd78af_1
stdout: sipros_sipros_psm_tabulating.py.out
