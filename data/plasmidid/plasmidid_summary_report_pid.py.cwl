cwlVersion: v1.2
class: CommandLineTool
baseCommand: plasmidid_summary_report_pid.py
label: plasmidid_summary_report_pid.py
doc: "The provided text is a system error log indicating a failure to build or extract
  a container image (no space left on device) and does not contain help text or usage
  information for the tool.\n\nTool homepage: https://github.com/BU-ISCIII/plasmidID"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plasmidid:1.6.5--hdfd78af_0
stdout: plasmidid_summary_report_pid.py.out
