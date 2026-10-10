cwlVersion: v1.2
class: CommandLineTool
baseCommand: [mumemto, lengths]
label: mumemto_lengths
doc: "Compute lengths of sequences in FASTA files.\n\nTool homepage: https://github.com/vikshiv/mumemto"
inputs:
  - id: input_fastas
    type:
      - 'null'
      - type: array
        items: File
    doc: Input FASTA files
    inputBinding:
      position: 1
  - id: input_list
    type:
      - 'null'
      - File
    doc: Path to a file list of genomes to use (overrides the positional files)
    inputBinding:
      position: 100
      prefix: --input
  - id: output
    type:
      - 'null'
      - string
    doc: Output prefix path
    inputBinding:
      position: 100
      prefix: --output
  - id: print_fasta
    type:
      - 'null'
      - boolean
    doc: "Write concatenated FASTA files (fwd$rc$)"
    inputBinding:
      position: 100
      prefix: --print-fasta
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: lengths_files
    type:
      type: array
      items: File
    doc: Files written with the output prefix
    outputBinding:
      glob: "$(inputs.output)*"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mumemto:1.3.4--py310h275bdba_0
stdout: mumemto_lengths.out
