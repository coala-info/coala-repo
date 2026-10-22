cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - smof
  - uniq
label: smof_uniq
doc: "Count, omit, or merge repeated entries (emulates GNU uniq).\n\nTool homepage: https://github.com/incertae-sedis/smof"
inputs:
  - id: count
    type:
      - 'null'
      - boolean
    doc: "Write (count|header) in tab-delimited format"
    inputBinding:
      position: 100
      prefix: --count
  - id: repeated
    type:
      - 'null'
      - boolean
    doc: "Print only repeated entries"
    inputBinding:
      position: 101
      prefix: --repeated
  - id: uniq
    type:
      - 'null'
      - boolean
    doc: "Print only unique entries"
    inputBinding:
      position: 102
      prefix: --uniq
  - id: pack
    type:
      - 'null'
      - boolean
    doc: "Combine redundant sequences by concatenating the headers"
    inputBinding:
      position: 103
      prefix: --pack
  - id: unpack
    type:
      - 'null'
      - boolean
    doc: "Reverse the pack operation"
    inputBinding:
      position: 104
      prefix: --unpack
  - id: pack_sep
    type:
      - 'null'
      - string
    doc: "Set delimiting string for pack/unpack operations (SOH, 0x01, by default)"
    inputBinding:
      position: 105
      prefix: --pack-sep
  - id: first_header
    type:
      - 'null'
      - boolean
    doc: "Remove entries with duplicate headers (keep only the first)"
    inputBinding:
      position: 106
      prefix: --first-header
  - id: removed_path
    type:
      - 'null'
      - string
    doc: "With --first-header, store removed sequences in this file"
    inputBinding:
      position: 107
      prefix: --removed
  - id: input_file
    type: File
    doc: "Input FASTA file (smof reads standard input by default)"
    inputBinding:
      position: 200
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
  - id: removed
    type: ['null', File]
    doc: Removed sequences (with --first-header and --removed)
    outputBinding:
      glob: $(inputs.removed_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
stdout: smof_uniq.out
