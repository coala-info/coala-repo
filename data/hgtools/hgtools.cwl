cwlVersion: v1.2
class: CommandLineTool
baseCommand: hgtools
label: hgtools
doc: "A tool for managing Mercurial repositories and related tasks.\n\nTool homepage:
  https://github.com/jaraco/hgtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hgtools:10.1.0--pyhdfd78af_0
stdout: hgtools.out
