cwlVersion: v1.2
class: CommandLineTool
baseCommand: tr
label: ptgaul_tr
doc: "Translate, squeeze, or delete characters from stdin, writing to stdout\n\nTool
  homepage: https://github.com/Bean061/ptgaul"
inputs:
  - id: string1
    type: string
    doc: Characters to translate, delete, or complement
    inputBinding:
      position: 1
  - id: string2
    type:
      - 'null'
      - string
    doc: Characters to translate to or squeeze
    inputBinding:
      position: 2
  - id: complement
    type:
      - 'null'
      - boolean
    doc: Take complement of STRING1
    inputBinding:
      position: 103
      prefix: -c
  - id: delete
    type:
      - 'null'
      - boolean
    doc: Delete input characters coded STRING1
    inputBinding:
      position: 103
      prefix: -d
  - id: squeeze
    type:
      - 'null'
      - boolean
    doc: Squeeze multiple output characters of STRING2 into one character
    inputBinding:
      position: 103
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ptgaul:1.0.5--pyhdfd78af_1
stdout: ptgaul_tr.out
