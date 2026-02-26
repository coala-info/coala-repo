cwlVersion: v1.2
class: CommandLineTool
baseCommand: protk_make_decoy.rb
label: protk_make_decoy.rb
doc: "Create a decoy database from real protein sequences.\n\nTool homepage: https://github.com/iracooke/protk"
inputs:
  - id: real_db
    type: File
    doc: Input real protein sequences database in FASTA format
    inputBinding:
      position: 1
  - id: append
    type:
      - 'null'
      - boolean
    doc: Append input sequences to the generated database
    default: false
    inputBinding:
      position: 102
      prefix: --append
  - id: db_length
    type:
      - 'null'
      - int
    doc: Number of sequences to generate
    default: 0
    inputBinding:
      position: 102
      prefix: --db-length
  - id: id_regex
    type:
      - 'null'
      - string
    doc: Regex for finding IDs. If reverse-only is used then this will be used 
      to find ids and prepend with the decoy string.
    default: .*?\|(.*?)[ \|]
    inputBinding:
      position: 102
      prefix: --id-regex
  - id: prefix_string
    type:
      - 'null'
      - string
    doc: String to prepend to sequence ids
    default: decoy_
    inputBinding:
      position: 102
      prefix: --prefix-string
  - id: reverse_only
    type:
      - 'null'
      - boolean
    doc: Just reverse sequences. Dont try to randomize. Ignores -L
    default: false
    inputBinding:
      position: 102
      prefix: --reverse-only
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: An explicitly named output file.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
