cwlVersion: v1.2
class: CommandLineTool
baseCommand: tir-learner
label: tir-learner
doc: "TIR-Learner is a tool for genome-wide identification of Terminal Inverted Repeat
  (TIR) transposable elements. (Note: The provided text is a container runtime error
  log and does not contain the tool's help documentation or argument definitions.)\n
  \nTool homepage: https://github.com/lutianyu2001/TIR-Learner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tir-learner:3.0.7--hdfd78af_0
stdout: tir-learner.out
