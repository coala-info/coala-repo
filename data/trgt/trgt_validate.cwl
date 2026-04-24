cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - trgt
  - validate
label: trgt_validate
doc: "Tandem Repeat Catalog Validator\n\nTool homepage: https://github.com/PacificBiosciences/trgt"
inputs:
  - id: color
    type:
      - 'null'
      - string
    doc: 'Enable or disable color output in logging [possible values: always, auto,
      never]'
    inputBinding:
      position: 101
      prefix: --color
  - id: flank_len
    type:
      - 'null'
      - int
    doc: Length of flanking regions
    inputBinding:
      position: 101
      prefix: --flank-len
  - id: genome
    type: File
    doc: Path to reference genome FASTA
    inputBinding:
      position: 101
      prefix: --genome
  - id: repeats
    type: File
    doc: BED file with repeat coordinates
    inputBinding:
      position: 101
      prefix: --repeats
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Specify multiple times to increase verbosity level (e.g., -vv for more verbosity)
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trgt:5.0.0--h9ee0642_0
stdout: trgt_validate.out
