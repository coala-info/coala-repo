cwlVersion: v1.2
class: CommandLineTool
baseCommand: srf-n-trf motifs
label: srf-n-trf_motifs
doc: "Fasta file of srf detected motifs\n\nTool homepage: https://github.com/koisland/srf-n-trf"
inputs:
  - id: diff
    type:
      - 'null'
      - float
    doc: 'Percent difference in monomer period length allowed. ex. `0.02` results
      in valid periods for `170`: `167 < 170 < 173`'
    inputBinding:
      position: 101
      prefix: --diff
  - id: fa
    type: File
    doc: Fasta file of srf detected motifs
    inputBinding:
      position: 101
      prefix: --fa
  - id: monomers
    type: File
    doc: '`trf` monomers TSV file on `srf` monomers with columns: `chrom (query),
      motif (target), st, end, period, copyNum, fracMatch, fracGap, score, entropy,
      pattern`'
    inputBinding:
      position: 101
      prefix: --monomers
  - id: require_all
    type:
      - 'null'
      - boolean
    doc: Require all monomers to be within size range
    inputBinding:
      position: 101
      prefix: --require-all
  - id: sizes
    type:
      - 'null'
      - type: array
        items: int
    doc: Monomer size in base pairs to search for
      - 170
      - 340
      - 510
      - 680
      - 850
      - 1020
    inputBinding:
      position: 101
      prefix: --sizes
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output fasta file filtered to only motifs composed of monomers of given
      size
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/srf-n-trf:0.1.2--h4349ce8_0
