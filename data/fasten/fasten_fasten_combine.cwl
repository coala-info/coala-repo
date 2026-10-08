cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasten_combine
label: fasten_fasten_combine
doc: "Collapse identical reads into single reads, recalculating quality values. If paired end, then each set of reads must be identical to be collapsed.\n\nTool homepage: https://github.com/lskatz/fasten"
inputs:
  - id: reads
    type: File
    doc: Reads in FASTQ format, read from standard input
  - id: max_qual_char
    type:
      - 'null'
      - string
    doc: 'Maximum quality character (default: I)'
    inputBinding:
      position: 101
      prefix: --max-qual-char
  - id: min_qual_char
    type:
      - 'null'
      - string
    doc: 'Minimum quality character (default: !)'
    inputBinding:
      position: 101
      prefix: --min-qual-char
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
stdout: fasten_fasten_combine.out
