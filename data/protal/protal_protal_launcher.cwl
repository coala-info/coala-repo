cwlVersion: v1.2
class: CommandLineTool
baseCommand: protal_protal_launcher
label: protal_protal_launcher
doc: "Protal launcher (Note: The provided text appears to be a container engine error
  log rather than help text, so no arguments could be extracted).\n\nTool homepage:
  https://github.com/4less/protal"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protal:0.2.0a--h5ca1c30_0
stdout: protal_protal_launcher.out
