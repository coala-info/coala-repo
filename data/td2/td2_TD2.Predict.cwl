cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - td2
  - TD2.Predict
label: td2_TD2.Predict
doc: "Predict tandem duplications using TD2. (Note: The provided help text contains
  system error messages regarding disk space and container extraction rather than
  tool usage instructions.)\n\nTool homepage: https://github.com/Markusjsommer/TD2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/td2:1.0.7--pyhdfd78af_0
stdout: td2_TD2.Predict.out
