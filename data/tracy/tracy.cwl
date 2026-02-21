cwlVersion: v1.2
class: CommandLineTool
baseCommand: tracy
label: tracy
doc: "The provided text does not contain help information for the tool 'tracy'. It
  contains system log messages and a fatal error regarding a container build failure
  (no space left on device).\n\nTool homepage: https://github.com/gear-genomics/tracy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tracy:0.8.1--h4d20210_0
stdout: tracy.out
