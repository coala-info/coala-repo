cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wbuild
  - init
label: wbuild_init
doc: "Initialize the repository with wbuild. This prepares wBuild in the current
  project (creates the .wBuild folder, Snakefile and wbuild.yaml). wBuild needs
  a readme.md in the project root.\n\nTool homepage: https://github.com/gagneurlab/wBuild"
inputs:
  - id: readme
    type: File
    doc: Project readme.md that wBuild requires in the root folder (staged as 
      readme.md; without it wbuild asks interactively whether to create one)
  - id: verbosity
    type:
      - 'null'
      - string
    doc: Either CRITICAL, ERROR, WARNING, INFO or DEBUG
    inputBinding:
      position: 0
      prefix: --verbosity
outputs:
  - id: wbuild_folder
    type: Directory
    doc: The initialized .wBuild folder
    outputBinding:
      glob: .wBuild
  - id: snakefile
    type: File
    doc: Snakefile created for the project
    outputBinding:
      glob: Snakefile
  - id: wbuild_config
    type: File
    doc: wbuild.yaml project configuration
    outputBinding:
      glob: wbuild.yaml
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: readme.md
        entry: $(inputs.readme)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wbuild:1.8.2--pyhdfd78af_0
stdout: wbuild_init.out
