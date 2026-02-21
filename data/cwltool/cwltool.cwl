cwlVersion: v1.2
class: CommandLineTool
baseCommand: cwltool
label: cwltool
doc: "Common Workflow Language reference implementation\n\nTool homepage: https://github.com/common-workflow-language/cwltool"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cwltool:1.0.20180225105849--py36_0
stdout: cwltool.out
