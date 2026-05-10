cwlVersion: v1.2
class: CommandLineTool
baseCommand: blastbesties
label: blastbesties
doc: "Finds reciprocal best BLAST pairs from BLAST output format 6 (tabular). Where
  hits are sorted by query name then descending match quality.\n\nTool homepage: https://github.com/Adamtaranto/blast-besties"
inputs:
  - id: bit_score
    type:
      - 'null'
      - float
    doc: Minimum bitscore to consider valid pair.
    inputBinding:
      position: 101
      prefix: --bitScore
  - id: blastAvB
    type: File
    doc: BLAST tab result file for fastaA query against fastaB subject.
    inputBinding:
      position: 101
      prefix: --blastAvB
  - id: blastBvA
    type: File
    doc: BLAST tab result file for fastaB query against fastaA subject.
    inputBinding:
      position: 101
      prefix: --blastBvA
  - id: e_val
    type:
      - 'null'
      - float
    doc: Maximum e-value to consider valid pair.
    inputBinding:
      position: 101
      prefix: --eVal
  - id: log_level
    type:
      - 'null'
      - string
    doc: Set logging level.
    inputBinding:
      position: 101
      prefix: --loglevel
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum length of hit to consider valid.
    inputBinding:
      position: 101
      prefix: --minLen
  - id: tui
    type:
      - 'null'
      - boolean
    doc: Open Textual UI.
    inputBinding:
      position: 101
      prefix: --tui
  - id: out_dir_path
    type:
      - 'null'
      - Directory
    doc: Output or path parameter `out_dir_path`
    inputBinding:
      position: 102
      prefix: --out-dir
  - id: out_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `out_file_path`
    inputBinding:
      position: 103
      prefix: --out-file
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: Write reciprocal BLAST pairs to this file.
    outputBinding:
      glob: $(inputs.out_file_path)
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Directory for new sequence files to be written to.
    outputBinding:
      glob: $(inputs.out_dir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blastbesties:1.2.0--pyhdfd78af_0
