cwlVersion: v1.2
class: CommandLineTool
baseCommand: chromap
label: chromap
doc: "A fast, accurate and memory-efficient tool for aligning and preprocessing chromatin
  profiles (Note: The provided text is an error log and does not contain help information).\n
  \nTool homepage: https://github.com/haowenz/chromap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chromap:0.3.2--h077b44d_0
stdout: chromap.out
