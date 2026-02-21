cwlVersion: v1.2
class: CommandLineTool
baseCommand: smcounter2
label: smcounter2
doc: "smcounter2 (Note: The provided text contains system error logs rather than help
  documentation; no arguments could be extracted.)\n\nTool homepage: https://github.com/qiaseq/qiaseq-smcounter-v2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smcounter2:0.1.2018.08.28--py27r351_0
stdout: smcounter2.out
