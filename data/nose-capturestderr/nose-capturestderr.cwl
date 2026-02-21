cwlVersion: v1.2
class: CommandLineTool
baseCommand: nose-capturestderr
label: nose-capturestderr
doc: "A nose plugin to capture stderr during testing. (Note: The provided text appears
  to be a container execution error log rather than help text, so no arguments could
  be extracted.)\n\nTool homepage: http://github.com/sio2project/nose-capturestderr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nose-capturestderr:1.2--py27_0
stdout: nose-capturestderr.out
