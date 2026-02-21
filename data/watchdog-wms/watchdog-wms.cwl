cwlVersion: v1.2
class: CommandLineTool
baseCommand: watchdog-wms
label: watchdog-wms
doc: "Watchdog Workflow Management System (Note: The provided text contained only
  container runtime error logs and no help documentation).\n\nTool homepage: https://www.bio.ifi.lmu.de/watchdog
  https://github.com/klugem/watchdog"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/watchdog-wms:2.0.8--hdfd78af_0
stdout: watchdog-wms.out
