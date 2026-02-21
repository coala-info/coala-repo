cwlVersion: v1.2
class: CommandLineTool
baseCommand: mira-moods
label: mira-moods
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log regarding a container build failure due to insufficient
  disk space.\n\nTool homepage: https://www.cs.helsinki.fi/group/pssmfind/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mira-moods:1.9.4.2--py39he88f293_2
stdout: mira-moods.out
