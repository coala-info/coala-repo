cwlVersion: v1.2
class: CommandLineTool
baseCommand: fermi2_count
label: fermi2_count
doc: "Count k-mers in an FMD index\n\nTool homepage: https://github.com/lh3/fermi2"
inputs:
  - id: input_fmd
    type: File
    doc: Input FMD index file
    inputBinding:
      position: 1
  - id: bidirectional
    type:
      - 'null'
      - boolean
    doc: bidirectional counting
    inputBinding:
      position: 102
      prefix: '-2'
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: k-mer length
    default: 51
    inputBinding:
      position: 102
      prefix: -k
  - id: min_occurrence
    type:
      - 'null'
      - int
    doc: min occurence
    default: 1
    inputBinding:
      position: 102
      prefix: -o
  - id: only_bifurcating
    type:
      - 'null'
      - boolean
    doc: only print bifurcating k-mers (force -2)
    inputBinding:
      position: 102
      prefix: -b
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: 1
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermi2:r193--h577a1d6_10
stdout: fermi2_count.out
