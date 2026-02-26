cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasten_shuffle
label: fasten_fasten_shuffle
doc: "Interleaves reads from either stdin or file parameters\n\nTool homepage: https://github.com/lskatz/fasten"
inputs:
  - id: deshuffle
    type:
      - 'null'
      - boolean
    doc: Deshuffle reads from stdin
    inputBinding:
      position: 101
      prefix: --deshuffle
  - id: forward_reads_file
    type:
      - 'null'
      - File
    doc: Forward reads. If deshuffling, reads are written to this file.
    inputBinding:
      position: 101
      prefix: '-1'
  - id: numcpus
    type:
      - 'null'
      - int
    doc: Number of CPUs
    default: 1
    inputBinding:
      position: 101
      prefix: --numcpus
  - id: paired_end
    type:
      - 'null'
      - boolean
    doc: The input reads are interleaved paired-end
    inputBinding:
      position: 101
      prefix: --paired-end
  - id: reverse_reads_file
    type:
      - 'null'
      - File
    doc: Forward reads. If deshuffling, reads are written to this file.
    inputBinding:
      position: 101
      prefix: '-2'
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print more status messages
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fasten:0.9.0--hc1c3326_0
stdout: fasten_fasten_shuffle.out
