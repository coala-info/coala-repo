cwlVersion: v1.2
class: CommandLineTool
baseCommand: smartdenovo_run_dmo.sh
label: smartdenovo_run_dmo.sh
doc: "The provided text does not contain help information or usage instructions for
  smartdenovo_run_dmo.sh; it contains container runtime error logs. No arguments could
  be extracted.\n\nTool homepage: https://github.com/ruanjue/smartdenovo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smartdenovo:1.0.0--h7b50bb2_8
stdout: smartdenovo_run_dmo.sh.out
