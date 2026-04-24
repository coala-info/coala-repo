cwlVersion: v1.2
class: CommandLineTool
baseCommand: kodoja_retrieve.py
label: kodoja_kodoja_retrieve.py
doc: "Kodoja Retrieve is used with the output of Kodoja Search to give subsets of
  your input sequencing reads matching viruses.\n\nTool homepage: https://github.com/abaizan/kodoja/"
inputs:
  - id: file_dir
    type: Directory
    doc: Path to directory of kodoja_search results, required
    inputBinding:
      position: 101
      prefix: --file_dir
  - id: genus
    type:
      - 'null'
      - boolean
    doc: Include sequences classified at genus
    inputBinding:
      position: 101
      prefix: --genus
  - id: read1
    type: File
    doc: Read 1 file path, required
    inputBinding:
      position: 101
      prefix: --read1
  - id: read2
    type:
      - 'null'
      - File
    doc: Read 2 file path
    inputBinding:
      position: 101
      prefix: --read2
  - id: stringent
    type:
      - 'null'
      - boolean
    doc: Only subset sequences identified by both tools
    inputBinding:
      position: 101
      prefix: --stringent
  - id: taxid
    type:
      - 'null'
      - string
    doc: Virus tax ID for subsetting
    inputBinding:
      position: 101
      prefix: --taxID
  - id: user_format
    type:
      - 'null'
      - string
    doc: Sequence data format
    inputBinding:
      position: 101
      prefix: --user_format
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kodoja:0.0.10--0
stdout: kodoja_kodoja_retrieve.py.out
