cwlVersion: v1.2
class: CommandLineTool
baseCommand: retropath2_wrapper
label: retropath2_wrapper
doc: "RetroPath2.0 is an automated pathway design tool that builds a reaction network
  from a set of metabolic rules and a set of source compounds.\n\nTool homepage: https://github.com/brsynth/retropath2-wrapper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/retropath2_wrapper:2.4.0
stdout: retropath2_wrapper.out
