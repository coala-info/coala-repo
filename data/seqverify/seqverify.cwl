cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqverify
label: seqverify
doc: "A tool for sequence verification (Note: The provided text contains system error
  logs rather than help documentation, so specific arguments could not be extracted).\n
  \nTool homepage: https://github.com/mpiersonsmela/SeqVerify"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqverify:1.3.0--hdfd78af_0
stdout: seqverify.out
