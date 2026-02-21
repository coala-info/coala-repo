cwlVersion: v1.2
class: CommandLineTool
baseCommand: sshmm_train_seqstructhmm
label: sshmm_train_seqstructhmm
doc: "Train a Sequence-Structure Hidden Markov Model (sshmm). Note: The provided help
  text contains container execution errors and does not list specific arguments.\n
  \nTool homepage: https://github.molgen.mpg.de/heller/ssHMM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sshmm:1.0.7--py27_0
stdout: sshmm_train_seqstructhmm.out
