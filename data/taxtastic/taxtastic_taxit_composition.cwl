cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxit
  - composition
label: taxtastic_taxit_composition
doc: "Show taxonomic composition of a reference package\n\nTool homepage: https://github.com/fhcrc/taxtastic"
inputs:
  - id: taxonomy
    type:
      - 'null'
      - File
    doc: "Path to taxtable (ignored if refpkg is provided, required otherwise)"
    inputBinding:
      position: 1
      prefix: "--taxonomy"
  - id: seq_info
    type:
      - 'null'
      - File
    doc: "Path to seq_info (ignored if refpkg is provided, required otherwise)"
    inputBinding:
      position: 1
      prefix: "--seq_info"
  - id: rank
    type:
      - 'null'
      - string
    doc: "show composition at RANK [species]"
    inputBinding:
      position: 1
      prefix: "--rank"
  - id: out
    type:
      - 'null'
      - string
    doc: "rank at which to show composition. Use --rank=tax_id to show original classifications [stdout]"
    inputBinding:
      position: 1
      prefix: "--out"
  - id: refpkg
    type:
      - 'null'
      - Directory
    doc: "the reference package to operate on"
    inputBinding:
      position: 101
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: "Composition table (only with --out)"
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
stdout: taxtastic_taxit_composition.out
