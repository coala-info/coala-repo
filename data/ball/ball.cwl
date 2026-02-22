cwlVersion: v1.2
class: CommandLineTool
baseCommand: ball
label: ball
doc: "Biochemical Algorithms Library (extracted from container metadata)\n\nTool homepage:
  https://github.com/kazzkiq/balloon.css"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ball:v1.5.0git20180813.37fc53c-3-deb-py2_cv1
stdout: ball.out
