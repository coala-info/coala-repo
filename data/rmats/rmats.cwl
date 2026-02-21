cwlVersion: v1.2
class: CommandLineTool
baseCommand: rmats
label: rmats
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container build/execution attempt.\n\nTool homepage:
  http://rnaseq-mats.sourceforge.net"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rmats:4.3.0--py311hf2f0b74_5
stdout: rmats.out
