cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - muset
  - muset_pa
label: muset_muset_pa
doc: "MuSET (Mutation Somatic Evaluation Tool)\n\nTool homepage: https://github.com/CamilaDuitama/muset"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/muset:0.5.1--h22625ea_0
stdout: muset_muset_pa.out
