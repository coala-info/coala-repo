cwlVersion: v1.2
class: CommandLineTool
baseCommand: variabel
label: variabel
doc: "Variant calling from long-read sequencing data\n\nTool homepage: https://gitlab.com/treangenlab/variabel"
inputs:
  - id: input
    type: File
    doc: Input BAM file
    inputBinding:
      position: 101
      prefix: --input
  - id: model
    type:
      - 'null'
      - File
    doc: Model file
    inputBinding:
      position: 101
      prefix: --model
  - id: parameters
    type:
      - 'null'
      - File
    doc: Parameters file
    inputBinding:
      position: 101
      prefix: --parameters
  - id: reference
    type: File
    doc: Reference FASTA file
    inputBinding:
      position: 101
      prefix: --ref
  - id: sample
    type:
      - 'null'
      - string
    doc: Sample name
    inputBinding:
      position: 101
      prefix: --sample
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/variabel:1.0.0--hdfd78af_0
