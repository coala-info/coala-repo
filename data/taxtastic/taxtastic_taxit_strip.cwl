cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxit
  - strip
label: taxtastic_taxit_strip
doc: "Remove rollback and rollforward information from a reference package\n\nTool homepage: https://github.com/fhcrc/taxtastic"
inputs:
  - id: refpkg
    type: Directory
    doc: 'The reference package to operate on; it is copied and the copy is stripped'
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stripped_refpkg
    type:
      - 'null'
      - Directory
    doc: 'The stripped reference package'
    outputBinding:
      glob: $(inputs.refpkg.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.refpkg)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxtastic:0.12.0--pyhdfd78af_0
stdout: taxtastic_taxit_strip.out
