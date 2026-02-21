cwlVersion: v1.2
class: CommandLineTool
baseCommand: pggb_wfmash
label: pggb_wfmash
doc: "The provided text is an error log regarding a container build failure and does
  not contain help information or usage instructions for the tool.\n\nTool homepage:
  https://github.com/pangenome/pggb"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pggb:0.7.4--h9ee0642_0
stdout: pggb_wfmash.out
