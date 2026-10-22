cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - transcov
  - generate-coverage
label: transcov_generate-coverage
doc: "Generate a coverage matrix (one row per region) from a BAM file and a BED file\n\nTool homepage: https://github.com/hogfeldt/transcov"
inputs:
  - id: bam_file
    type: File
    secondaryFiles:
      - pattern: '.bai'
        required: true
    doc: "Sorted and indexed BAM file"
    inputBinding:
      position: 1
  - id: bed_file
    type: File
    doc: "BED file with the regions (for example transcription start sites)"
    inputBinding:
      position: 2
  - id: output_file
    type:
      - 'null'
      - string
    default: coverage_matrix.npy
    doc: "Output file name"
    inputBinding:
      prefix: --output-file
outputs:
  - id: output_matrix
    type: File
    secondaryFiles:
      - pattern: '^.index'
        required: true
    doc: "Coverage matrix (.npy) with its index file"
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transcov:1.1.3--py_0
