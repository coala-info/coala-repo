cwlVersion: v1.2
class: CommandLineTool
baseCommand: snp-dists
label: snp-dists
doc: "Pairwise SNP distance matrix from a FASTA sequence alignment\n\nTool homepage:
  https://github.com/tseemann/snp-dists"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA alignment file (may be gzipped)
    inputBinding:
      position: 2
  - id: threads
    type:
      - 'null'
      - int
    doc: Threads to use
    inputBinding:
      position: 1
      prefix: -j
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet mode; no progress messages
    inputBinding:
      position: 1
      prefix: -q
  - id: count_all
    type:
      - 'null'
      - boolean
    doc: Count all differences not just [AGTC]
    inputBinding:
      position: 1
      prefix: -a
  - id: keep_case
    type:
      - 'null'
      - boolean
    doc: Keep case, don't uppercase all letters
    inputBinding:
      position: 1
      prefix: -k
  - id: molten
    type:
      - 'null'
      - boolean
    doc: Output MOLTEN instead of TSV
    inputBinding:
      position: 1
      prefix: -m
  - id: lower_triangle
    type:
      - 'null'
      - boolean
    doc: Output lower-triangle only (unique pairs)
    inputBinding:
      position: 1
      prefix: -L
  - id: molten_header
    type:
      - 'null'
      - boolean
    doc: Add header to MOLTEN output
    inputBinding:
      position: 1
      prefix: -t
  - id: csv
    type:
      - 'null'
      - boolean
    doc: Use comma instead of tab in output
    inputBinding:
      position: 1
      prefix: -c
  - id: blank
    type:
      - 'null'
      - boolean
    doc: Blank top left corner cell
    inputBinding:
      position: 1
      prefix: -b
  - id: max_distance
    type:
      - 'null'
      - int
    doc: Stop counting distance beyond this value
    inputBinding:
      position: 1
      prefix: -x
outputs:
  - id: stdout
    type: stdout
    doc: Distance matrix
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snp-dists:1.2.0--h577a1d6_0
stdout: snp-dists.out
