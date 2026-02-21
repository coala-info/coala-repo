cwlVersion: v1.2
class: CommandLineTool
baseCommand: viralverify
label: viralverify
doc: "No description available in the provided text.\n\nTool homepage: https://github.com/ablab/viralVerify"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viralverify:1.1--hdfd78af_0
stdout: viralverify.out
