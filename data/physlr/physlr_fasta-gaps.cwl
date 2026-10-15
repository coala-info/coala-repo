cwlVersion: v1.2
class: CommandLineTool
baseCommand: [/usr/local/bin/share/physlr-1.0.4-0/bin/physlr, fasta-gaps]
label: physlr_fasta-gaps
doc: "Print the coordinates in BED format of the gaps (runs of N) in a FASTA file.\n\nTool homepage: https://github.com/BirolLab/physlr"
inputs:
  - id: min_score
    type: ['null', int]
    doc: "report only gaps of at least this length [0]"
    inputBinding:
      position: 1
      prefix: -n
  - id: verbose
    type: ['null', int]
    doc: "the level of verbosity: 0 silent, 1 periodic, 2 progress, 3 verbose [2]"
    inputBinding:
      position: 2
      prefix: -V
  - id: fasta_files
    type: File[]
    doc: "Sequences in FASTA format"
    inputBinding:
      position: 100
outputs:
  - id: result
    type: File
    doc: "BED with the columns sequence name, gap start, gap end and gap name"
    outputBinding:
      glob: physlr_fasta-gaps.bed
stdout: physlr_fasta-gaps.bed
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: PYTHONPATH
        envValue: /usr/local/bin/share/physlr-1.0.4-0
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
