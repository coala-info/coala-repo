cwlVersion: v1.2
class: CommandLineTool
baseCommand: ALE
label: ale-core_ale
doc: "Assembly Likelihood Evaluation (Note: The provided text is a system error log
  regarding a failed container build and does not contain CLI help information or
  argument definitions.)\n\nTool homepage: https://github.com/sc932/ALE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ale-core:20220503--h577a1d6_1
stdout: ale-core_ale.out
