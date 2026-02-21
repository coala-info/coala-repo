cwlVersion: v1.2
class: CommandLineTool
baseCommand: probe
label: probe
doc: "The provided text is a container execution log and does not contain help documentation
  or argument definitions for the 'probe' tool.\n\nTool homepage: http://kinemage.biochem.duke.edu/software/probe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/probe:2.18--h9948957_0
stdout: probe.out
