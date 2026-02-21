cwlVersion: v1.2
class: CommandLineTool
baseCommand: freddie_freddie_cluster.py
label: freddie_freddie_cluster.py
doc: "Freddie cluster tool (Note: The provided text contains container runtime error
  logs rather than tool help documentation)\n\nTool homepage: https://github.com/vpc-ccg/freddie"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/freddie:0.4--hdfd78af_0
stdout: freddie_freddie_cluster.py.out
