cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - find_indels
label: pomoxis_find_indels
doc: "Parse a bamfile and document indels.\n\nTool homepage: https://github.com/nanoporetech/pomoxis"
inputs:
  - id: bam
    type: File
    doc: Input bam file (indexed).
    inputBinding:
      position: 1
    secondaryFiles:
      - pattern: .bai
        required: false
  - id: min_indel_length
    type:
      - 'null'
      - int
    doc: Filter out indels shorter than this length (default 0).
    inputBinding:
      position: 102
      prefix: --min_indel_length
  - id: all_alignments
    type:
      - 'null'
      - boolean
    doc: Include secondary and supplementary alignments.
    inputBinding:
      position: 102
      prefix: --all_alignments
  - id: output
    type:
      - 'null'
      - string
    default: indels.txt
    doc: Output indels to this file instead of stdout.
    inputBinding:
      position: 102
      prefix: --output
  - id: bed
    type:
      - 'null'
      - string
    doc: Additionally output a .bed file with this name.
    inputBinding:
      position: 102
      prefix: --bed
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for parallel processing (default 1).
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: indels
    type: File
    doc: Table of indels.
    outputBinding:
      glob: $(inputs.output)
  - id: indels_bed
    type:
      - 'null'
      - File
    doc: Indels as a bed file.
    outputBinding:
      glob: $(inputs.bed)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
