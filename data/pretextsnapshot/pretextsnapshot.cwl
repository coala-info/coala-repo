cwlVersion: v1.2
class: CommandLineTool
baseCommand: PretextSnapshot
label: pretextsnapshot
doc: "PretextSnapshot is a tool for generating image snapshots from Pretext contact
  maps.\n\nTool homepage: https://github.com/wtsi-hpag/PretextSnapshot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pretextsnapshot:0.0.5--h9948957_0
stdout: pretextsnapshot.out
