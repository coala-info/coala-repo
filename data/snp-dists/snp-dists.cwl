cwlVersion: v1.2
class: CommandLineTool
baseCommand: snp-dists
label: snp-dists
doc: "Pairwise SNP distance matrix from a FASTA sequence alignment\n\nTool homepage:
  https://github.com/tseemann/snp-dists"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA alignment file
    inputBinding:
      position: 1
  - id: blank
    type:
      - 'null'
      - boolean
    doc: Blank top-left corner (for PHYLIP compatibility)
    inputBinding:
      position: 102
      prefix: -b
  - id: csv
    type:
      - 'null'
      - boolean
    doc: Output CSV instead of TSV
    inputBinding:
      position: 102
      prefix: -c
  - id: keep_all_bases
    type:
      - 'null'
      - boolean
    doc: Keep all bases (don't ignore non-ACGT characters)
    inputBinding:
      position: 102
      prefix: -k
  - id: melt
    type:
      - 'null'
      - boolean
    doc: Melted format (sample1, sample2, distance)
    inputBinding:
      position: 102
      prefix: -m
  - id: pair
    type:
      - 'null'
      - boolean
    doc: Format as a list of pairs
    inputBinding:
      position: 102
      prefix: -p
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet mode; check if any SNPs, return 0 or 1
    inputBinding:
      position: 102
      prefix: -q
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 102
      prefix: -j
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snp-dists:1.2.0--h577a1d6_0
stdout: snp-dists.out
