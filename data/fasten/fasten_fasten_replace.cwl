cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasten_replace
label: fasten_fasten_replace
doc: "Streaming editor for fastq data using a find/replace.\n\nTool homepage: https://github.com/lskatz/fasten"
inputs:
  - id: reads
    type: File
    doc: Reads in FASTQ format, read from standard input
  - id: find
    type:
      - 'null'
      - string
    doc: 'Regular expression (default: ''.'')'
    inputBinding:
      position: 101
      prefix: --find
  - id: replace
    type:
      - 'null'
      - string
    doc: String to replace each match
    inputBinding:
      position: 101
      prefix: --replace
  - id: which
    type:
      - 'null'
      - string
    doc: 'Which field to match on? ID, SEQ, QUAL. Default: SEQ'
    inputBinding:
      position: 101
      prefix: --which
  - id: numcpus
    type:
      - 'null'
      - int
    doc: 'Number of CPUs (default: 1)'
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
stdin: $(inputs.reads.path)
stdout: fasten_fasten_replace.out
