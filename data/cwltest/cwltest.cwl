cwlVersion: v1.2
class: CommandLineTool
baseCommand: cwltest
label: cwltest
doc: "Common Workflow Language test runner\n\nTool homepage: https://github.com/common-workflow-language/cwltest"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cwltest:2.2.20220521103021--pyhdfd78af_0
stdout: cwltest.out
