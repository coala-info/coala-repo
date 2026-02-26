cwlVersion: v1.2
class: CommandLineTool
baseCommand: swga
label: swga_init
doc: "Initialize the current directory as an swga workspace.\n\nTool homepage: https://github.com/eclarke/swga"
inputs:
  - id: bg_genome_fp
    type:
      - 'null'
      - File
    doc: Path to background genome/sequences (in FASTA format)
    inputBinding:
      position: 101
      prefix: --bg_genome_fp
  - id: exclude_fp
    type:
      - 'null'
      - File
    doc: Path to sequences to exclude from analysis (in FASTA format)
    inputBinding:
      position: 101
      prefix: --exclude_fp
  - id: fg_genome_fp
    type:
      - 'null'
      - File
    doc: Path to foreground genome/sequences (in FASTA format)
    inputBinding:
      position: 101
      prefix: --fg_genome_fp
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite any existing data in the directory without prompts
    inputBinding:
      position: 101
      prefix: --force
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/swga:0.4.4--py27hd28b015_1
stdout: swga_init.out
