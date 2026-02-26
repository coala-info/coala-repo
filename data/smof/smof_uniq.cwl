cwlVersion: v1.2
class: CommandLineTool
baseCommand: smof_uniq
label: smof_uniq
doc: "Emulates the GNU uniq command. Two entries are considered equivalent only if
  their sequences AND headers are exactly equal. Newlines are ignored but all comparisons
  are case-sensitive. The pack/unpack option is designed to be compatible with the
  conventions used in the NCBI-BLAST non-redundant databases: entries with identical
  sequences are merged and their headers are joined with SOH (0x01) as a delimiter
  (by default).\n\nTool homepage: https://github.com/incertae-sedis/smof"
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: input fasta sequence
    default: stdin
    inputBinding:
      position: 1
  - id: count
    type:
      - 'null'
      - boolean
    doc: writes (count|header) in tab-delimited format
    inputBinding:
      position: 102
      prefix: --count
  - id: first_header
    type:
      - 'null'
      - boolean
    doc: remove entries with duplicate headers (keep only the first)
    inputBinding:
      position: 102
      prefix: --first-header
  - id: pack
    type:
      - 'null'
      - boolean
    doc: combine redundant sequences by concatenating the headers
    inputBinding:
      position: 102
      prefix: --pack
  - id: pack_sep
    type:
      - 'null'
      - string
    doc: set delimiting string for pack/unpack operations (SOH, 0x01, by 
      default)
    default: SOH, 0x01
    inputBinding:
      position: 102
      prefix: --pack-sep
  - id: repeated
    type:
      - 'null'
      - boolean
    doc: print only repeated entries
    inputBinding:
      position: 102
      prefix: --repeated
  - id: uniq
    type:
      - 'null'
      - boolean
    doc: print only unique entries
    inputBinding:
      position: 102
      prefix: --uniq
  - id: unpack
    type:
      - 'null'
      - boolean
    doc: reverse the pack operation
    inputBinding:
      position: 102
      prefix: --unpack
outputs:
  - id: removed_file
    type:
      - 'null'
      - File
    doc: With -f, store removed sequences in FILE
    outputBinding:
      glob: $(inputs.removed_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
