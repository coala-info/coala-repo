cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - harpy
  - align
label: harpy_align
doc: "Align sequences to a reference genome. Provide an additional subcommand bwa
  or strobe to get more information on using those aligners. Both have comparable
  performance, but strobe is typically faster. The aligners are not linked-read aware,
  but the workflows ensure linked-read information is carried over to the alignment
  records.\n\nTool homepage: https://github.com/pdimens/harpy/"
inputs:
  - id: command
    type: string
    doc: 'The subcommand to execute: bwa (Align sequences using BWA MEM2) or strobe
      (Align sequences using strobealign)'
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional arguments for the selected subcommand
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/harpy:3.1--pyhdfd78af_2
stdout: harpy_align.out
