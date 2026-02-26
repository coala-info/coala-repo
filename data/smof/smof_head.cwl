cwlVersion: v1.2
class: CommandLineTool
baseCommand: smof_head
label: smof_head
doc: "`smof head` is modeled after GNU tail and follows the same basic conventions
  except it is entry-based rather than line-based. By default, `smof head` outputs
  ONE sequence (rather than the 10 line default for `head`)\n\nTool homepage: https://github.com/incertae-sedis/smof"
inputs:
  - id: k_entries
    type:
      - 'null'
      - int
    doc: print first K entries
    inputBinding:
      position: 1
  - id: input_fasta
    type:
      - 'null'
      - File
    doc: input fasta sequence
    default: stdin
    inputBinding:
      position: 2
  - id: entries
    type:
      - 'null'
      - int
    doc: print first K entries; or use -n -K to print all but the last K entries
    inputBinding:
      position: 103
      prefix: --entries
  - id: first_letters
    type:
      - 'null'
      - int
    doc: print first K letters of each sequence
    inputBinding:
      position: 103
      prefix: --first
  - id: last_letters
    type:
      - 'null'
      - int
    doc: print last K letters of each sequence
    inputBinding:
      position: 103
      prefix: --last
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
stdout: smof_head.out
