cwlVersion: v1.2
class: CommandLineTool
baseCommand: artex
label: artex
doc: "A tool for variant calling from sequencing data.\n\nTool homepage: https://github.com/JMencius/Artex"
inputs:
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: Size of chunks for processing.
    inputBinding:
      position: 101
      prefix: --chunk-size
  - id: config
    type:
      - 'null'
      - File
    doc: Configuration file for Artex.
    inputBinding:
      position: 101
      prefix: --config
  - id: input
    type: File
    doc: Input sequencing data file (e.g., BAM, CRAM).
    inputBinding:
      position: 101
      prefix: --input
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: Minimum coverage required for variant calling.
    inputBinding:
      position: 101
      prefix: --min-coverage
  - id: model
    type:
      - 'null'
      - File
    doc: Model file for variant calling.
    inputBinding:
      position: 101
      prefix: --model
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files.
    inputBinding:
      position: 101
      prefix: --prefix
  - id: ref
    type:
      - 'null'
      - File
    doc: Reference genome file (e.g., FASTA).
    inputBinding:
      position: 101
      prefix: --ref
  - id: test
    type:
      - 'null'
      - boolean
    doc: Run in test mode.
    inputBinding:
      position: 101
      prefix: --test
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 101
      prefix: --threads
  - id: work
    type:
      - 'null'
      - Directory
    doc: Working directory for intermediate files.
    inputBinding:
      position: 101
      prefix: --work
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file for variant calls (e.g., VCF).
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/artex:0.2.0--py39h9ee0642_0
