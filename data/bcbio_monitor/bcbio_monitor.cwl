cwlVersion: v1.2
class: CommandLineTool
baseCommand: bcbio_monitor
label: bcbio_monitor
doc: "A tool for monitoring bcbio-nextgen runs.\n\nTool homepage: https://github.com/guillermo-carrasco/bcbio-nextgen-monitor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcbio_monitor:1.0.6--py27_0
stdout: bcbio_monitor.out
