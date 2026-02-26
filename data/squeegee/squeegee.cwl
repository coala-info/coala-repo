cwlVersion: v1.2
class: CommandLineTool
baseCommand: squeegee
label: squeegee
doc: "Scoring and final predictions.\n\nTool homepage: https://gitlab.com/treangenlab/squeegee"
inputs:
  - id: metadata
    type: string
    doc: input matadata in txt format
    inputBinding:
      position: 1
  - id: krakendb
    type: Directory
    doc: directory of kraken database
    inputBinding:
      position: 2
  - id: output
    type: Directory
    doc: squeegee output directory
    inputBinding:
      position: 3
  - id: min_abundance
    type:
      - 'null'
      - float
    doc: "Minimum abundance for a species to be consider as\n                    \
      \    truely present in a sample."
    inputBinding:
      position: 104
      prefix: --min-abundance
  - id: min_align
    type:
      - 'null'
      - float
    doc: "Minimum breadth of genome coverge threshold for a\n                    \
      \    species to be indentified as a contaminant species."
    inputBinding:
      position: 104
      prefix: --min-align
  - id: min_prevalence
    type:
      - 'null'
      - float
    doc: "Minimum prevalence threshold for a species to be\n                     \
      \   indentified as a contaminant species."
    inputBinding:
      position: 104
      prefix: --min-prevalence
  - id: min_reads
    type:
      - 'null'
      - int
    doc: "Minimum number of reads for a species to be consider\n                 \
      \       as truely present in a sample."
    inputBinding:
      position: 104
      prefix: --min-reads
  - id: min_score
    type:
      - 'null'
      - float
    doc: "Minimum contaminant score threshold for a species to\n                 \
      \       be indentified as a contaminant species."
    inputBinding:
      position: 104
      prefix: --min-score
  - id: numcore
    type:
      - 'null'
      - int
    doc: Number of threads.
    inputBinding:
      position: 104
      prefix: --numcore
  - id: stacked_idx
    type:
      - 'null'
      - string
    doc: "Index to determine whether or not aligned reads have\n                 \
      \       been stacked in small region."
    inputBinding:
      position: 104
      prefix: --stacked-idx
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/squeegee:0.2.0--hdfd78af_0
stdout: squeegee.out
