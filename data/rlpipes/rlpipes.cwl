cwlVersion: v1.2
class: CommandLineTool
baseCommand: rlpipes
label: rlpipes
doc: "A tool for R-loop data analysis. (Note: The provided text appears to be a container
  build log rather than CLI help text; no arguments could be extracted.)\n\nTool homepage:
  https://github.com/Bishop-Laboratory/RLPipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rlpipes:0.9.4--pyh7cba7a3_0
stdout: rlpipes.out
