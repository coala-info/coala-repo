cwlVersion: v1.2
class: CommandLineTool
baseCommand: insurveyor.py
label: insurveyor_insurveyor.py
doc: "A tool for detecting insertions from NGS data (Note: The provided text contains
  only system error logs and no help documentation; therefore, arguments could not
  be extracted).\n\nTool homepage: https://github.com/kensung-lab/INSurVeyor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/insurveyor:1.1.3--h077b44d_2
stdout: insurveyor_insurveyor.py.out
