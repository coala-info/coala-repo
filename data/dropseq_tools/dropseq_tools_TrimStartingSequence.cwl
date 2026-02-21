cwlVersion: v1.2
class: CommandLineTool
baseCommand: TrimStartingSequence
label: dropseq_tools_TrimStartingSequence
doc: "The provided text does not contain help information for the tool, but rather
  a system error message indicating a failure to pull the container image (no space
  left on device). No arguments or tool descriptions could be extracted from the input.\n
  \nTool homepage: http://mccarrolllab.com/dropseq/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dropseq_tools:3.0.2--hdfd78af_0
stdout: dropseq_tools_TrimStartingSequence.out
