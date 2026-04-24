cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasten_regex
label: fasten_fasten_regex
doc: "Filter reads based on a regular expression.\n\nTool homepage: https://github.com/lskatz/fasten"
inputs:
  - id: numcpus
    type:
      - 'null'
      - int
    doc: Number of CPUs
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
  - id: regex
    type:
      - 'null'
      - string
    doc: Regular expression
    inputBinding:
      position: 101
      prefix: --regex
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print more status messages
    inputBinding:
      position: 101
      prefix: --verbose
  - id: which
    type:
      - 'null'
      - string
    doc: Which field to match on? ID, SEQ, QUAL.
    inputBinding:
      position: 101
      prefix: --which
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fasten:0.9.0--hc1c3326_0
stdout: fasten_fasten_regex.out
