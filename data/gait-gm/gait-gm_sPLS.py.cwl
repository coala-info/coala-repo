cwlVersion: v1.2
class: CommandLineTool
baseCommand: gait-gm_sPLS.py
label: gait-gm_sPLS.py
doc: "Sparse Partial Least Squares (sPLS) analysis tool. (Note: The provided text
  contains system error messages regarding container execution and does not include
  usage or argument details.)\n\nTool homepage: https://github.com/secimTools/gait-gm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gait-gm:21.7.22--pyhdfd78af_0
stdout: gait-gm_sPLS.py.out
