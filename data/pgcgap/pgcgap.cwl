cwlVersion: v1.2
class: CommandLineTool
baseCommand: pgcgap
label: pgcgap
doc: "The provided text is a system error log related to a container build failure
  (no space left on device) and does not contain CLI help information or argument
  definitions.\n\nTool homepage: https://github.com/liaochenlanruo/pgcgap/blob/master/README.md"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgcgap:1.0.35--pl5321hdfd78af_1
stdout: pgcgap.out
