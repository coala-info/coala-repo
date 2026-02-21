cwlVersion: v1.2
class: CommandLineTool
baseCommand: mosaik_run.sh
label: mosaik_run.sh
doc: "The provided text does not contain help information or usage instructions. It
  contains system log messages and a fatal error regarding a container build failure
  (no space left on device).\n\nTool homepage: https://github.com/Global-Policy-Lab/mosaiks-paper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mosaik:2.2.26--3
stdout: mosaik_run.sh.out
