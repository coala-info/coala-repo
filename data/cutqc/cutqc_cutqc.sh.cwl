cwlVersion: v1.2
class: CommandLineTool
baseCommand: cutqc_cutqc.sh
label: cutqc_cutqc.sh
doc: "The provided text does not contain help information or usage instructions. It
  consists of system log messages and a fatal error regarding a container build failure
  (no space left on device).\n\nTool homepage: https://github.com/obenno/cutqc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cutqc:0.07--hdfd78af_0
stdout: cutqc_cutqc.sh.out
