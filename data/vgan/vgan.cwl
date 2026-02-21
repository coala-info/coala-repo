cwlVersion: v1.2
class: CommandLineTool
baseCommand: vgan
label: vgan
doc: "Viral Genome Assembly and Net (vgan) - A tool for viral genome analysis. Note:
  The provided text is a container build error log and does not contain CLI usage
  information or argument definitions.\n\nTool homepage: https://github.com/grenaud/vgan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vgan:3.1.0--h9ee0642_0
stdout: vgan.out
