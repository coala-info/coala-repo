cwlVersion: v1.2
class: CommandLineTool
baseCommand: chromhmm
label: chromhmm_ChromHMM.jar
doc: "ChromHMM is a software for learning and characterizing chromatin states. (Note:
  The provided text contains system error logs and does not include help documentation;
  therefore, arguments could not be extracted.)\n\nTool homepage: https://github.com/jernst98/ChromHMM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chromhmm:1.27--hdfd78af_0
stdout: chromhmm_ChromHMM.jar.out
