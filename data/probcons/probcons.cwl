cwlVersion: v1.2
class: CommandLineTool
baseCommand: probcons
label: probcons
doc: "Probabilistic Consistency-based Multiple Sequence Alignment\n\nTool homepage:
  http://probcons.stanford.edu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/probcons:v1.12-12-deb_cv1
stdout: probcons.out
