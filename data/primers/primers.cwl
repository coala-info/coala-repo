cwlVersion: v1.2
class: CommandLineTool
baseCommand: primers
label: primers
doc: "A tool for primer analysis (Note: The provided text is a container build error
  log and does not contain usage instructions or argument definitions).\n\nTool homepage:
  https://github.com/Lattice-Automation/primers"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/primers:0.5.10--pyhdfd78af_0
stdout: primers.out
