cwlVersion: v1.2
class: CommandLineTool
baseCommand: chromhmm
label: chromhmm
doc: "ChromHMM is a software for chromatin state discovery and characterization. (Note:
  The provided text contains system error logs regarding a failed container build
  and does not include CLI help documentation; therefore, no arguments could be extracted.)\n
  \nTool homepage: https://github.com/jernst98/ChromHMM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chromhmm:1.27--hdfd78af_0
stdout: chromhmm.out
