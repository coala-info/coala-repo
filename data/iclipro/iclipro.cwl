cwlVersion: v1.2
class: CommandLineTool
baseCommand: iclipro
label: iclipro
doc: "The provided help text contains a fatal error (no space left on device) and
  does not contain usage information or argument descriptions. As a result, no arguments
  can be extracted.\n\nTool homepage: http://www.biolab.si/iCLIPro/doc/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iclipro:0.1.1--py27_0
stdout: iclipro.out
