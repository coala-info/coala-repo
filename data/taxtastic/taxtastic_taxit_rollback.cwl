cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxit
  - rollback
label: taxtastic_taxit_rollback
doc: "Undo an operation performed on a refpkg\n\nTool homepage: https://github.com/fhcrc/taxtastic"
inputs:
  - id: n
    type:
      - 'null'
      - int
    doc: "Number of operations to roll back"
    inputBinding:
      position: 1
      prefix: "-n"
  - id: refpkg
    type: Directory
    doc: "the reference package to operate on"
    inputBinding:
      position: 101
outputs:
  - id: refpkg_out
    type: Directory
    doc: "The reference package after the rollback"
    outputBinding:
      glob: "$(inputs.refpkg.basename)"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.refpkg)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxtastic:0.12.0--pyhdfd78af_0
stdout: taxtastic_taxit_rollback.out
