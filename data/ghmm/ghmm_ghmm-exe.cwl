cwlVersion: v1.2
class: CommandLineTool
baseCommand: ghmm-exe
label: ghmm_ghmm-exe
doc: "General Hidden Markov Model library (GHMM) executable. Note: The provided help
  text contains only system error messages regarding container image creation and
  does not list specific command-line arguments.\n\nTool homepage: https://github.com/ulfsauer0815/ghmm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ghmm:0.9--py27hc9114bc_1
stdout: ghmm_ghmm-exe.out
