cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wbuild
  - demo
label: wbuild_demo
doc: "Setup a demo wBuild demo project in the current folder (Scripts, Data, readme.md,
  Snakefile, wbuild.yaml and .wBuild).\n\nTool homepage: https://github.com/gagneurlab/wBuild"
inputs:
  - id: verbosity
    type:
      - 'null'
      - string
    doc: Either CRITICAL, ERROR, WARNING, INFO or DEBUG
    inputBinding:
      position: 0
      prefix: --verbosity
outputs:
  - id: scripts
    type: Directory
    doc: Demo analysis scripts
    outputBinding:
      glob: Scripts
  - id: data
    type: Directory
    doc: Demo data
    outputBinding:
      glob: Data
  - id: wbuild_folder
    type: Directory
    doc: The .wBuild folder
    outputBinding:
      glob: .wBuild
  - id: snakefile
    type: File
    doc: Snakefile of the demo project
    outputBinding:
      glob: Snakefile
  - id: wbuild_config
    type: File
    doc: wbuild.yaml project configuration
    outputBinding:
      glob: wbuild.yaml
  - id: readme
    type: File
    doc: Demo readme.md
    outputBinding:
      glob: readme.md
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wbuild:1.8.2--pyhdfd78af_0
stdout: wbuild_demo.out
