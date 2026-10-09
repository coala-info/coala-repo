cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kmertools
  - comp
  - oligo
label: kmertools_comp_oligo
doc: "Generate oligonucleotide frequency vectors\n\nTool homepage: https://github.com/anuradhawick/kmertools"
inputs:
  - id: input
    type: File
    doc: Input file path
    inputBinding:
      position: 101
      prefix: --input
  - id: counts
    type:
      - 'null'
      - boolean
    doc: Disable normalisation and output raw counts
    inputBinding:
      position: 101
      prefix: --counts
  - id: k_size
    type:
      - 'null'
      - int
    doc: Set k-mer size
    inputBinding:
      position: 101
      prefix: --k-size
  - id: raw_count
    type:
      - 'null'
      - boolean
    doc: Raw counts
    inputBinding:
      position: 101
      prefix: --raw-count
  - id: preset
    type:
      - 'null'
      - string
    doc: "Output type to write (possible values: csv, tsv, spc)"
    inputBinding:
      position: 101
      prefix: --preset
  - id: header
    type:
      - 'null'
      - boolean
    doc: Include header (with k-mer in ACGT format)
    inputBinding:
      position: 101
      prefix: --header
  - id: threads
    type:
      - 'null'
      - int
    doc: Thread count for computations 0=auto
    inputBinding:
      position: 101
      prefix: --threads
  - id: output_path
    type: string
    doc: Output vectors path
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: File
    doc: Output vectors file
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmertools:0.2.1--h5e00ca1_0
