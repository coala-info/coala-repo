cwlVersion: v1.2
class: CommandLineTool
baseCommand: mamotif
label: mamotif
doc: "MA-plot based Motif analysis (Note: The provided text contains container runtime
  error logs rather than the tool's help documentation).\n\nTool homepage: https://github.com/shao-lab/MAmotif"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mamotif:1.1.0--py_0
stdout: mamotif.out
