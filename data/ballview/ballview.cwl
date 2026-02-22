cwlVersion: v1.2
class: CommandLineTool
baseCommand: ballview
label: ballview
doc: "BALLView is a molecular modeling and visualization application based on the
  BALL (Biochemical Algorithms Library) framework.\n\nTool homepage: https://github.com/LaxusJie/BallViewDemo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ballview:v1.5.0git20180813.37fc53c-3-deb_cv1
stdout: ballview.out
