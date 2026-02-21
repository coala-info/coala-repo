cwlVersion: v1.2
class: CommandLineTool
baseCommand: ale-core_ale2wiggle.py
label: ale-core_ale2wiggle.py
doc: "The provided text does not contain help information for the tool, but rather
  a system error log indicating a failure to build a container image due to lack of
  disk space.\n\nTool homepage: https://github.com/sc932/ALE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ale-core:20220503--h577a1d6_1
stdout: ale-core_ale2wiggle.py.out
