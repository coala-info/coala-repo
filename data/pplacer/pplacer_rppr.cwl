cwlVersion: v1.2
class: CommandLineTool
baseCommand: rppr
label: pplacer_rppr
doc: "The provided text does not contain help information or a description of the
  tool; it appears to be a container execution error log.\n\nTool homepage: http://matsen.fredhutch.org/pplacer/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pplacer:1.1.alpha17--0
stdout: pplacer_rppr.out
