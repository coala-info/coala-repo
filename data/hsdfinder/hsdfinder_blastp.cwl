cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hsdfinder
  - blastp
label: hsdfinder_blastp
doc: "HSDfinder blastp (Note: The provided text contains system error messages regarding
  container execution and does not include tool-specific help or usage information.)\n
  \nTool homepage: https://github.com/zx0223winner/HSDFinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hsdfinder:1.1.1--hdfd78af_0
stdout: hsdfinder_blastp.out
