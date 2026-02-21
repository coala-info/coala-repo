cwlVersion: v1.2
class: CommandLineTool
baseCommand: upd
label: upd
doc: "A tool for detecting Uniparental Disomy (UPD) from NGS data.\n\nTool homepage:
  https://github.com/bjhall/upd"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/upd:0.1.1--pyhdfd78af_0
stdout: upd.out
