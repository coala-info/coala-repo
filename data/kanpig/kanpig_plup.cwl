cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kanpig
  - plup
label: kanpig_plup
doc: "BAM/CRAM to Pileup Index\n\nTool homepage: https://github.com/ACEnglish/kanpig"
inputs:
  - id: bam
    type: File
    doc: Input BAM/CRAM file
    inputBinding:
      position: 101
      prefix: --bam
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: Chunksize in Mbp
    inputBinding:
      position: 101
      prefix: --chunk-size
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Verbose logging
    inputBinding:
      position: 101
      prefix: --debug
  - id: mapflag
    type:
      - 'null'
      - int
    doc: Ignore alignments matching flag
    inputBinding:
      position: 101
      prefix: --mapflag
  - id: mapq
    type:
      - 'null'
      - int
    doc: Minimum mapq of reads to consider
    inputBinding:
      position: 101
      prefix: --mapq
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference file for CRAMs
    inputBinding:
      position: 101
      prefix: --reference
  - id: sizemax
    type:
      - 'null'
      - int
    doc: Maximum size of variant to index
    inputBinding:
      position: 101
      prefix: --sizemax
  - id: sizemin
    type:
      - 'null'
      - int
    doc: Minimum size of variant to index
    inputBinding:
      position: 101
      prefix: --sizemin
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output plup (unsorted, uncompressed)
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kanpig:2.0.2--ha6fb395_0
