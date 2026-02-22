cwlVersion: v1.2
class: CommandLineTool
baseCommand: ancestry_hmm-s
label: ancestry_hmm-s
doc: "The provided text does not contain help information or documentation for the
  tool. It appears to be a system error log indicating a failure to build a container
  image due to insufficient disk space ('no space left on device').\n\nTool homepage:
  https://github.com/jesvedberg/Ancestry_HMM-S"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ancestry_hmm-s:0.9.0.2--h9948957_6
stdout: ancestry_hmm-s.out
