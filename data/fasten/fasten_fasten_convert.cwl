cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasten_convert
label: fasten_fasten_convert
doc: "Converts between sequence formats.\n\nTool homepage: https://github.com/lskatz/fasten"
inputs:
  - id: reads
    type: File
    doc: Reads in FASTQ format, read from standard input
  - id: in_format
    type:
      - 'null'
      - string
    doc: 'The input format for stdin. FORMAT can be: fastq, fasta, sam.'
    inputBinding:
      position: 101
      prefix: --in-format
  - id: out_format
    type:
      - 'null'
      - string
    doc: The output format for stdout. See in_format for FORMAT options.
    inputBinding:
      position: 101
      prefix: --out-format
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
stdout: fasten_fasten_convert.out
