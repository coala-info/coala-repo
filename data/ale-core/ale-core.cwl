cwlVersion: v1.2
class: CommandLineTool
baseCommand: ale-core
label: ale-core
doc: "ALE (Assembly Likelihood Evaluation) is a tool for evaluating genome assemblies.
  (Note: The provided input text contains container runtime logs and error messages
  rather than the tool's help documentation, so no arguments could be extracted.)\n
  \nTool homepage: https://github.com/sc932/ALE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ale-core:20220503--h577a1d6_1
stdout: ale-core.out
