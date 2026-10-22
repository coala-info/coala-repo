cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - swga
  - init
label: swga_init
doc: "Initialize the current directory as an swga workspace.\n\nTool homepage: https://github.com/eclarke/swga"
inputs:
  - id: bg_genome_fp
    type: File
    doc: Path to background genome/sequences (in FASTA format). swga init asks interactively when it is missing, so it is required here.
    inputBinding:
      position: 101
      prefix: --bg_genome_fp
      valueFrom: bg.fa
  - id: exclude_fp
    type: File
    doc: Path to sequences to exclude from analysis (in FASTA format). swga init asks interactively when it is missing, so it is required here.
    inputBinding:
      position: 101
      prefix: --exclude_fp
      valueFrom: ex.fa
  - id: fg_genome_fp
    type: File
    doc: Path to foreground genome/sequences (in FASTA format). swga init asks interactively when it is missing, so it is required here.
    inputBinding:
      position: 101
      prefix: --fg_genome_fp
      valueFrom: fg.fa
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite any existing data in the directory without prompts
    inputBinding:
      position: 101
      prefix: --force
outputs:
  - id: parameters_cfg
    type: File
    doc: Pre-filled swga parameters file
    outputBinding:
      glob: parameters.cfg
  - id: workspace_db
    type: File
    doc: swga workspace database
    outputBinding:
      glob: swga.db
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entryname: fg.fa
        entry: $(inputs.fg_genome_fp)
        writable: true
      - entryname: bg.fa
        entry: $(inputs.bg_genome_fp)
        writable: true
      - entryname: ex.fa
        entry: $(inputs.exclude_fp)
        writable: true
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/swga:0.4.4--py27hd28b015_1
    dockerOutputDirectory: /swga_work
stdout: swga_init.out
