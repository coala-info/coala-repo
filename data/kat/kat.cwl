cwlVersion: v1.2
class: CommandLineTool
baseCommand: kat
label: kat
doc: "K-mer Analysis Toolkit (Note: The provided text contains system error logs and
  does not include help documentation or argument details).\n\nTool homepage: https://github.com/TGAC/KAT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kat:2.4.2--py39he0b6574_5
stdout: kat.out
