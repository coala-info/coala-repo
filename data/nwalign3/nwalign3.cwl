cwlVersion: v1.2
class: CommandLineTool
baseCommand: nwalign3
label: nwalign3
doc: "A tool for sequence alignment (Note: The provided text is a container runtime
  error log and does not contain help documentation or argument definitions).\n\n
  Tool homepage: https://github.com/briney/nwalign3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nwalign3:0.1.6--py39hff726c5_0
stdout: nwalign3.out
