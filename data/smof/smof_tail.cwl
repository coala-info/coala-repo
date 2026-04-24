cwlVersion: v1.2
class: CommandLineTool
baseCommand: smof_tail
label: smof_tail
doc: "`smof tail` is modeled after GNU tail and follows the same basic conventions
  except it is entry-based rather than line-based. `smof tail` will output ONE sequence
  (rather than the 10 line default for `tail`)\n\nTool homepage: https://github.com/incertae-sedis/smof"
inputs:
  - id: k_positional
    type:
      - 'null'
      - int
    doc: print last K entries
    inputBinding:
      position: 1
  - id: input
    type:
      - 'null'
      - File
    doc: input fasta sequence
    inputBinding:
      position: 2
  - id: entries
    type:
      - 'null'
      - int
    doc: print last K entries; or use -n +K to output starting with the Kth
    inputBinding:
      position: 103
      prefix: --entries
  - id: first
    type:
      - 'null'
      - int
    doc: print first K letters of each sequence
    inputBinding:
      position: 103
      prefix: --first
  - id: last
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
stdout: smof_tail.out
