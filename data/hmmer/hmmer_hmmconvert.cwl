cwlVersion: v1.2
class: CommandLineTool
baseCommand: hmmconvert
label: hmmer_hmmconvert
doc: "convert profile file to a HMMER format\n\nTool homepage: http://hmmer.org/"
inputs:
  - id: hmmfile
    type: File
    doc: Input profile HMM file
    inputBinding:
      position: 201
  - id: ascii
    type:
      - 'null'
      - boolean
    doc: 'ascii: output models in HMMER3 ASCII format [default]'
    inputBinding:
      position: 103
      prefix: '-a'
  - id: binary
    type:
      - 'null'
      - boolean
    doc: 'binary: output models in HMMER3 binary format'
    inputBinding:
      position: 103
      prefix: '-b'
  - id: hmmer2
    type:
      - 'null'
      - boolean
    doc: 'HMMER2: output backward compatible HMMER2 ASCII format (ls mode)'
    inputBinding:
      position: 103
      prefix: '-2'
  - id: outfmt
    type:
      - 'null'
      - string
    doc: "choose output legacy 3.x file formats by name, such as '3/a'"
    inputBinding:
      position: 103
      prefix: '--outfmt'
outputs:
  - id: converted
    type: stdout
    doc: Converted profile HMM(s) written to standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmmer:3.4--hb6cb901_4
stdout: hmmer_hmmconvert.out
