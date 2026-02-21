cwlVersion: v1.2
class: CommandLineTool
baseCommand: ghmm
label: ghmm
doc: "General Hidden Markov Model library\n\nTool homepage: https://github.com/ulfsauer0815/ghmm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ghmm:0.9--py27hc9114bc_1
stdout: ghmm.out
