cwlVersion: v1.2
class: CommandLineTool
baseCommand: cobra
label: python3-cobra_cobra
doc: "Constraint-Based Reconstruction and Analysis (COBRA) for metabolic networks\n
  \nTool homepage: https://github.com/machinezone/cobra"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/python3-cobra:v0.5.9-1-deb_cv1
stdout: python3-cobra_cobra.out
