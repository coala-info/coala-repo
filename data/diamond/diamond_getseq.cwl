cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - diamond
  - getseq
label: diamond_getseq
doc: Retrieve sequences from a DIAMOND database file.
inputs:
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPU threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: log
    type:
      - 'null'
      - boolean
    doc: enable debug log
    inputBinding:
      position: 101
      prefix: --log
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: disable console output
    inputBinding:
      position: 101
      prefix: --quiet
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: directory for temporary files
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: db
    type: File
    doc: database file
    inputBinding:
      position: 101
      prefix: --db
  - id: out
    type: string
    doc: output file
    inputBinding:
      position: 101
      prefix: --out
  - id: seq
    type:
      - 'null'
      - type: array
        items: int
    doc: Space-separated list of sequence numbers to display.
    inputBinding:
      position: 101
      prefix: --seq
outputs:
  - id: output_out
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.out)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/diamond:2.1.24--hf93d47f_0
s:url: https://github.com/bbuchfink/diamond
$namespaces:
  s: https://schema.org/
