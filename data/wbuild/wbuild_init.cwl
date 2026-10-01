cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wbuild
  - init
label: wbuild_init
doc: "Initialize the repository with wbuild.\n\nTool homepage: https://github.com/gagneurlab/wBuild"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wbuild:1.8.2--pyhdfd78af_0
stdout: wbuild_init.out
