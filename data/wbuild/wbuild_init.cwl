cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wbuild
  - init
label: wbuild_init
doc: "Initialize the repository with wbuild.\n\nTool homepage: https://github.com/gagneurlab/wBuild"
inputs:
  - id: prepare_wbuild
    type:
      - 'null'
      - boolean
    doc: This will prepare wBuild in the current project
    inputBinding:
      position: 101
      prefix: --prepare-wbuild
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wbuild:1.8.2--pyhdfd78af_0
stdout: wbuild_init.out
