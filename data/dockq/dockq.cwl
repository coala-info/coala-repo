cwlVersion: v1.2
class: CommandLineTool
baseCommand: dockq
label: dockq
doc: "DockQ is a tool for quality assessment of protein-protein docking models. Note:
  The provided help text contains only system error messages regarding container image
  conversion and disk space, and does not list specific command-line arguments.\n\n
  Tool homepage: https://github.com/bjornwallner/DockQ"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dockq:2.1.3--py312h031d066_0
stdout: dockq.out
