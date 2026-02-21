cwlVersion: v1.2
class: CommandLineTool
baseCommand: wfmash
label: wfmash
doc: "A tool for whole-genome alignment using the wavefront algorithm.\n\nTool homepage:
  https://github.com/ekg/wfmash"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wfmash:0.24.2--h27bdcc9_0
stdout: wfmash.out
