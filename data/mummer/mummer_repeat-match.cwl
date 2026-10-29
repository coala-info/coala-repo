cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - repeat-match
label: mummer_repeat-match
doc: "Find all maximal exact matches (repeats) in a genome FASTA file.\n\nTool homepage: https://github.com/mummer4/mummer"
inputs:
  - id: exhaustive
    type:
      - 'null'
      - boolean
    doc: "Use exhaustive (slow) search to find matches"
    inputBinding:
      position: 1
      prefix: "-E"
  - id: forward_only
    type:
      - 'null'
      - boolean
    doc: "Forward strand only, don't use reverse complement"
    inputBinding:
      position: 1
      prefix: "-f"
  - id: min_length
    type:
      - 'null'
      - int
    doc: "Set minimum exact match length to this value"
    inputBinding:
      position: 1
      prefix: "-n"
  - id: tandem_only
    type:
      - 'null'
      - boolean
    doc: "Only output tandem repeats"
    inputBinding:
      position: 1
      prefix: "-t"
  - id: verbose_level
    type:
      - 'null'
      - int
    doc: "Set level of verbose (debugging) printing to this value"
    inputBinding:
      position: 1
      prefix: "-V"
  - id: genome_file
    type: File
    doc: "Genome FASTA file"
    inputBinding:
      position: 100
outputs:
  - id: stdout_out
    type: stdout
    doc: "List of repeats: start 1, start 2, length"
  - id: log
    type: stderr
    doc: "Progress and warning messages"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer:3.23--pl5321hdbdd923_18
stdout: mummer_repeat-match.out
stderr: mummer_repeat-match.log
