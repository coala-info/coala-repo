cwlVersion: v1.2
class: CommandLineTool
baseCommand: demultiplex match
label: demultiplex_match
doc: "Demultiplex reads based on barcode matching.\n\nTool homepage: https://github.com/jfjlaros/demultiplex"
inputs:
  - id: barcodes
    type: File
    doc: File containing barcodes
    inputBinding:
      position: 1
  - id: input
    type:
      type: array
      items: File
    doc: Input FASTQ files
    inputBinding:
      position: 2
  - id: deduplicate
    type:
      - 'null'
      - boolean
    doc: Deduplicate reads after demultiplexing
    inputBinding:
      position: 103
      prefix: --deduplicate
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing output files
    inputBinding:
      position: 103
      prefix: --force
  - id: mismatch
    type:
      - 'null'
      - int
    doc: Maximum allowed mismatches in barcode matching
    inputBinding:
      position: 103
      prefix: --mismatch
outputs:
  - id: output_path
    type:
      - 'null'
      - Directory
    doc: Path to save demultiplexed files
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/demultiplex:1.2.2--pyhdfd78af_1
