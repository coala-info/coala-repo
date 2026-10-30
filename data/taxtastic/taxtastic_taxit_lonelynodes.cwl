cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxit
  - lonelynodes
label: taxtastic_taxit_lonelynodes
doc: "Extracts tax ids of all lonely nodes in a taxtable\n\nTool homepage: https://github.com/fhcrc/taxtastic"
inputs:
  - id: out
    type:
      - 'null'
      - string
    doc: "Write output to given file [default: stdout]"
    inputBinding:
      position: 1
      prefix: "--out"
  - id: ranks
    type:
      - 'null'
      - string
    doc: "Comma separated list of ranks to consider [default: all ranks]"
    inputBinding:
      position: 1
      prefix: "--ranks"
  - id: taxtable_or_refpkg
    type: [File, Directory]
    doc: "A taxtable or a refpkg containing a taxtable"
    inputBinding:
      position: 101
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: "Lonely tax_ids (only with --out)"
    outputBinding:
      glob: "$(inputs.out)"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxtastic:0.12.0--pyhdfd78af_0
stdout: taxtastic_taxit_lonelynodes.out
