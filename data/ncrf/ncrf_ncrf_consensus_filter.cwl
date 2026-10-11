cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncrf_consensus_filter
label: ncrf_ncrf_consensus_filter
doc: "Filters NCRF alignments by repeat motif consensus (or reports the consensus of each alignment).\n\nTool homepage: https://github.com/makovalab-psu/NoiseCancellingRepeatFinder"
inputs:
  - id: ncrf_file
    type: File
    doc: "Output from ncrf_cat (or NCRF), read from standard input"
  - id: motifs
    type:
      - 'null'
      - type: array
        items: string
    doc: "dna repeat motif to process, as [<name>:]<motif>; if none are given all are processed"
    inputBinding:
      position: 1
  - id: consensusonly
    type:
      - 'null'
      - boolean
    doc: "just report the consensus motif(s) for each alignment, instead of filtering"
    inputBinding:
      position: 10
      prefix: "--consensusonly"
  - id: head
    type:
      - 'null'
      - int
    doc: "limit the number of input alignments"
    inputBinding:
      position: 10
      prefix: "--head="
      separate: false
  - id: progress
    type:
      - 'null'
      - int
    doc: "periodically report how many alignments have been tested"
    inputBinding:
      position: 10
      prefix: "--progress="
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncrf:1.01.02--h7b50bb2_6
stdin: $(inputs.ncrf_file.path)
stdout: ncrf_ncrf_consensus_filter.out
