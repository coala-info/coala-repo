cwlVersion: v1.2
class: CommandLineTool
baseCommand: liftofftools
label: liftofftools
doc: "The provided text does not contain help information or a description of the
  tool; it contains system log messages and a fatal error regarding container execution
  (no space left on device).\n\nTool homepage: https://github.com/agshumate/LiftoffTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/liftofftools:0.4.4--pyhdfd78af_0
stdout: liftofftools.out
