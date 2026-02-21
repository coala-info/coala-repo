cwlVersion: v1.2
class: CommandLineTool
baseCommand: hmmlearn
label: hmmlearn
doc: "Hidden Markov Models in Python, with scikit-learn like API (Note: The provided
  text contains only system error messages and no help documentation).\n\nTool homepage:
  https://github.com/hmmlearn/hmmlearn"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmmlearn:20151031--py27h24bf2e0_2
stdout: hmmlearn.out
