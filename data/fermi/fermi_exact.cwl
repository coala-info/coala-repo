cwlVersion: v1.2
class: CommandLineTool
baseCommand: fermi exact
label: fermi_exact
doc: "Exact algorithm for sequence alignment\n\nTool homepage: https://github.com/quantumlib/OpenFermion"
inputs:
  - id: idxbase_bwt
    type: File
    doc: Index base file (BWT)
    inputBinding:
      position: 1
  - id: src_fa
    type: File
    doc: Source FASTA file
    inputBinding:
      position: 2
  - id: mismatch
    type:
      - 'null'
      - boolean
    doc: Allow mismatches
    inputBinding:
      position: 103
      prefix: -M
  - id: skip_reads
    type:
      - 'null'
      - boolean
    doc: Skip reads that have already been aligned
    inputBinding:
      position: 103
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
stdout: fermi_exact.out
