cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fasten_shuffle
  - --deshuffle
label: fasten_fasten_deshuffle
doc: "Deshuffle interleaved reads from stdin into two FASTQ files (fasten_shuffle --deshuffle).\n\nTool homepage: https://github.com/lskatz/fasten"
inputs:
  - id: reads
    type: File
    doc: Reads in FASTQ format, read from standard input
  - id: forward_reads_file
    type: string
    doc: Forward reads. Output file that receives the forward reads.
    inputBinding:
      position: 101
      prefix: '-1'
  - id: reverse_reads_file
    type: string
    doc: Reverse reads. Output file that receives the reverse reads.
    inputBinding:
      position: 101
      prefix: '-2'
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
  - id: forward_reads
    type: File
    doc: Forward reads
    outputBinding:
      glob: $(inputs.forward_reads_file)
  - id: reverse_reads
    type: File
    doc: Reverse reads
    outputBinding:
      glob: $(inputs.reverse_reads_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fasten:0.9.0--hc1c3326_0
stdin: $(inputs.reads.path)
