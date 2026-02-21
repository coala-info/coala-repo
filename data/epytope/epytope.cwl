cwlVersion: v1.2
class: CommandLineTool
baseCommand: epytope
label: epytope
doc: "A framework for immunoinformatics\n\nTool homepage: https://github.com/KohlbacherLab/epytope"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/epytope:3.3.1--pyh7cba7a3_0
stdout: epytope.out
