cwlVersion: v1.2
class: CommandLineTool
baseCommand: porfast
label: porfast
doc: "Extract ORFs from Paired-End reads.\n\nTool homepage: https://github.com/telatin/porfast"
inputs:
  - id: join
    type:
      - 'null'
      - boolean
    doc: Try joining paired ends
    inputBinding:
      position: 101
      prefix: --join
  - id: max_overlap
    type:
      - 'null'
      - int
    doc: Maximum PE overlap
    default: 200
    inputBinding:
      position: 101
      prefix: --max-overlap
  - id: min_identity
    type:
      - 'null'
      - float
    doc: Minimum sequence identity in overlap
    default: 0.85
    inputBinding:
      position: 101
      prefix: --min-identity
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: Minimum PE overlap
    default: 12
    inputBinding:
      position: 101
      prefix: --min-overlap
  - id: min_size
    type:
      - 'null'
      - int
    doc: Minimum ORF size (aa)
    default: 26
    inputBinding:
      position: 101
      prefix: --min-size
  - id: pool_size
    type:
      - 'null'
      - int
    doc: Size of the batch of reads to process per thread
    default: 250
    inputBinding:
      position: 101
      prefix: --pool-size
  - id: prefix
    type:
      - 'null'
      - string
    doc: Rename reads using this prefix
    inputBinding:
      position: 101
      prefix: --prefix
  - id: r1
    type: File
    doc: FASTQ file, first pair
    inputBinding:
      position: 101
      prefix: --R1
  - id: r2
    type: File
    doc: FASTQ file, second pair
    inputBinding:
      position: 101
      prefix: --R2
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print verbose info
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/porfast:0.8.0--hbeb723e_0
stdout: porfast.out
