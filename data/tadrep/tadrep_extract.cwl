cwlVersion: v1.2
class: CommandLineTool
baseCommand: tadrep_extract
label: tadrep_extract
doc: "Extracts sequences from input files based on specified criteria.\n\nTool homepage:
  https://github.com/oschwengers/tadrep"
inputs:
  - id: discard_longest
    type:
      - 'null'
      - int
    doc: Discard n longest sequences in output
    inputBinding:
      position: 101
      prefix: --discard-longest
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: File path
    inputBinding:
      position: 101
      prefix: --files
  - id: header
    type:
      - 'null'
      - string
    doc: 'Template for header description inside input files: e.g.: header: ">pl1234"
      --> --header "pl"'
    inputBinding:
      position: 101
      prefix: --header
  - id: max_length
    type:
      - 'null'
      - int
    doc: Max sequence length (default = 1000000 bp)
    inputBinding:
      position: 101
      prefix: --max-length
  - id: type
    type:
      - 'null'
      - string
    doc: Type of input files
    inputBinding:
      position: 101
      prefix: --type
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tadrep:0.9.2--pyhdfd78af_0
stdout: tadrep_extract.out
