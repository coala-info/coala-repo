cwlVersion: v1.2
class: CommandLineTool
baseCommand: ale
label: ale
doc: "The provided text does not contain help information or a description of the
  tool; it is a system error log regarding a failed container build (no space left
  on device).\n\nTool homepage: https://github.com/sc932/ALE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ale:20180904--py27ha92aebf_0
stdout: ale.out
