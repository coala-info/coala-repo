cwlVersion: v1.2
class: CommandLineTool
baseCommand: gapcloser
label: gapcloser
doc: "The provided text does not contain a description of the tool; it appears to
  be a system error log regarding a container execution failure.\n\nTool homepage:
  https://github.com/BGI-Qingdao/TGS-GapCloser"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/gapcloser:v1.12-r6_cv3
stdout: gapcloser.out
