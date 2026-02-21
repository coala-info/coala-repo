cwlVersion: v1.2
class: CommandLineTool
baseCommand: ntedit
label: ntedit_run-ntedit
doc: "The provided text is an error log indicating a failure to pull or build the
  container image (no space left on device) and does not contain the help text or
  usage information for the tool. As a result, no arguments could be extracted from
  the source text.\n\nTool homepage: https://github.com/bcgsc/ntEdit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ntedit:2.1.1--pl5321h077b44d_0
stdout: ntedit_run-ntedit.out
