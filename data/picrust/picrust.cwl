cwlVersion: v1.2
class: CommandLineTool
baseCommand: picrust
label: picrust
doc: "The provided text does not contain help information for the tool. It consists
  of system error messages indicating a failure to pull or run the picrust container
  due to lack of disk space ('no space left on device').\n\nTool homepage: http://picrust.github.com"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picrust:1.1.4--pyh24bf2e0_0
stdout: picrust.out
