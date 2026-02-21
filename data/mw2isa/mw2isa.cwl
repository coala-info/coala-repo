cwlVersion: v1.2
class: CommandLineTool
baseCommand: mw2isa
label: mw2isa
doc: "A tool for converting MetaboWorkflows/MetaboLights metadata to ISA-Tab format.\n
  \nTool homepage: https://github.com/bio-agents/container-mw2isa"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mw2isa:phenomenal-v0.9.4_cv0.5.34
stdout: mw2isa.out
