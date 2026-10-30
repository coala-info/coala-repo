cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - assess_homopolymers
  - count
label: pomoxis_assess_homopolymers_count
doc: "Count homopolymers starting from a bam.\n\nTool homepage: https://github.com/nanoporetech/pomoxis"
inputs:
  - id: bam
    type: File
    doc: Input bam file (indexed; MD tag required).
    inputBinding:
      position: 1
    secondaryFiles:
      - pattern: .bai
        required: false
  - id: output_dir
    type:
      - 'null'
      - string
    default: homopolymers
    doc: Output directory (will be created).
    inputBinding:
      position: 102
      prefix: --output_dir
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for parallel execution (default 1).
    inputBinding:
      position: 102
      prefix: --threads
  - id: homo_len
    type:
      - 'null'
      - int
    doc: Minimum homopolymer length (default 3).
    inputBinding:
      position: 102
      prefix: --homo_len
  - id: bed
    type:
      - 'null'
      - File
    doc: Bed file to limit search.
    inputBinding:
      position: 102
      prefix: --bed
outputs:
  - id: counts_dir
    type: Directory
    doc: Directory with the homopolymer counts (.pkl).
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
