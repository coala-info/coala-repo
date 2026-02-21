cwlVersion: v1.2
class: CommandLineTool
baseCommand: sincei
label: sincei
doc: "A tool for single-cell chromatin data analysis (Note: The provided text contains
  only environment logs and a fatal error, no help documentation was found in the
  input).\n\nTool homepage: https://github.com/bhardwaj-lab/sincei"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sincei:0.5.2--pyhdfd78af_0
stdout: sincei.out
