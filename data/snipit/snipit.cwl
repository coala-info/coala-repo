cwlVersion: v1.2
class: CommandLineTool
baseCommand: snipit
label: snipit
doc: "A tool for visualizing genetic variation and creating snipit plots. (Note: The
  provided text is a container execution error log and does not contain the standard
  help documentation; therefore, no arguments could be extracted.)\n\nTool homepage:
  https://github.com/aineniamh/snipit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snipit:1.7--pyhdfd78af_0
stdout: snipit.out
