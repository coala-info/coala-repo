cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasten_head
label: fasten_fasten_head
doc: "Keep first N reads or bases\n\nTool homepage: https://github.com/lskatz/fasten"
inputs:
  - id: reads
    type: File
    doc: Reads in FASTQ format, read from standard input
  - id: reads_to_keep
    type:
      - 'null'
      - int
    doc: 'Number of reads or pairs of reads to keep, default: 10'
    inputBinding:
      position: 101
      prefix: --reads
  - id: bases
    type:
      - 'null'
      - int
    doc: 'Number of bases to keep, default: 0 (zero for no limit).'
    inputBinding:
      position: 101
      prefix: --bases
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
stdout: fasten_fasten_head.out
