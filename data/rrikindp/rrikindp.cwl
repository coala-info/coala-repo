cwlVersion: v1.2
class: CommandLineTool
baseCommand: rrikindp
label: rrikindp
doc: "RNA-RNA interaction kinematics and dynamics prediction\n\nTool homepage: https://github.com/mwaldl/RRIkinDP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rrikindp:0.0.2--py39h9e0f934_1
stdout: rrikindp.out
