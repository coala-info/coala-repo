cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wbuild
  - update
label: wbuild_update
doc: "Update the .wBuild folder to the most recent version of wBuild.\n\nTool homepage:
  https://github.com/gagneurlab/wBuild"
inputs:
  - id: wbuild_folder
    type: Directory
    doc: Existing .wBuild folder of a wBuild project (staged as .wBuild)
  - id: verbosity
    type:
      - 'null'
      - string
    doc: Either CRITICAL, ERROR, WARNING, INFO or DEBUG
    inputBinding:
      position: 0
      prefix: --verbosity
outputs:
  - id: updated_wbuild_folder
    type: Directory
    doc: The updated .wBuild folder
    outputBinding:
      glob: .wBuild
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: .wBuild
        entry: $(inputs.wbuild_folder)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wbuild:1.8.2--pyhdfd78af_0
stdout: wbuild_update.out
