cwlVersion: v1.2
class: CommandLineTool
baseCommand: viralFlye.py
label: viralflye_viralFlye.py
doc: "viralFlye: a tool for viral genome assembly (Note: The provided help text contains
  only system log errors and no argument definitions).\n\nTool homepage: https://github.com/Dmitry-Antipov/viralFlye/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viralflye:0.2--pyhdfd78af_0
stdout: viralflye_viralFlye.py.out
