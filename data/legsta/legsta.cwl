cwlVersion: v1.2
class: CommandLineTool
baseCommand: legsta
label: legsta
doc: "Legionella in silico SBT typing of contig sequences\n\nTool homepage: https://github.com/tseemann/legsta"
inputs:
  - id: contigs_fa
    type:
      type: array
      items: File
    doc: Contig sequences file in FASTA format
    inputBinding:
      position: 1
  - id: csv
    type:
      - 'null'
      - boolean
    doc: Output CSV instead of TSV (default '0').
    inputBinding:
      position: 102
      prefix: --csv
  - id: dbdir
    type:
      - 'null'
      - Directory
    doc: SBT database folder (default '/usr/local/db').
    inputBinding:
      position: 102
      prefix: --dbdir=s
  - id: debug
    type:
      - 'null'
      - string
    doc: Verbose debug output to stderr (default '0').
    inputBinding:
      position: 102
      prefix: --debug+
  - id: noheader
    type:
      - 'null'
      - boolean
    doc: Don't print header row (default '0').
    inputBinding:
      position: 102
      prefix: --noheader
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't print anything to stderr.
    inputBinding:
      position: 102
      prefix: --quiet
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/legsta:0.5.2--hdfd78af_0
stdout: legsta.out
