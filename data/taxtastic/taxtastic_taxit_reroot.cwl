cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxit
  - reroot
label: taxtastic_taxit_reroot
doc: "Taxonomically reroots a reference package\n\nTool homepage: https://github.com/fhcrc/taxtastic"
inputs:
  - id: rppr
    type:
      - 'null'
      - string
    doc: "specify the rppr binary to call to perform the rerooting"
    inputBinding:
      position: 1
      prefix: "--rppr"
  - id: pretend
    type:
      - 'null'
      - boolean
    doc: "don't save the rerooted tree; just attempt the rerooting."
    inputBinding:
      position: 1
      prefix: "--pretend"
  - id: refpkg
    type: Directory
    doc: "the reference package to operate on"
    inputBinding:
      position: 101
outputs:
  - id: refpkg_out
    type: Directory
    doc: "The reference package after rerooting"
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
stdout: taxtastic_taxit_reroot.out
