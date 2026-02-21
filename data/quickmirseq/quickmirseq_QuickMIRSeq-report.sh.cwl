cwlVersion: v1.2
class: CommandLineTool
baseCommand: QuickMIRSeq-report.sh
label: quickmirseq_QuickMIRSeq-report.sh
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system logs and a fatal error related to a container build
  process.\n\nTool homepage: https://sourceforge.net/projects/quickmirseq/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quickmirseq:1.0.0--hdfd78af_3
stdout: quickmirseq_QuickMIRSeq-report.sh.out
