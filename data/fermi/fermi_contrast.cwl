cwlVersion: v1.2
class: CommandLineTool
baseCommand: fermi contrast
label: fermi_contrast
doc: "Contrast two FMD-index based genomes.\n\nTool homepage: https://github.com/quantumlib/OpenFermion"
inputs:
  - id: idx1_fmd
    type: File
    doc: First FMD-index file
    inputBinding:
      position: 1
  - id: idx1_rank
    type: File
    doc: First rank file
    inputBinding:
      position: 2
  - id: idx1_to_idx2_sub
    type: File
    doc: Substitution file from index 1 to index 2
    inputBinding:
      position: 3
  - id: idx2_fmd
    type: File
    doc: Second FMD-index file
    inputBinding:
      position: 4
  - id: idx2_rank
    type: File
    doc: Second rank file
    inputBinding:
      position: 5
  - id: idx2_to_idx1_sub
    type: File
    doc: Substitution file from index 2 to index 1
    inputBinding:
      position: 6
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: k-mer length
    default: 55
    inputBinding:
      position: 107
      prefix: -k
  - id: min_occurrence
    type:
      - 'null'
      - int
    doc: minimum occurrence
    default: 3
    inputBinding:
      position: 107
      prefix: -o
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: 1
    inputBinding:
      position: 107
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
stdout: fermi_contrast.out
