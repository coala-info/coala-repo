cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasten_clean
label: fasten_fasten_clean
doc: "Trims and filters reads\n\nTool homepage: https://github.com/lskatz/fasten"
inputs:
  - id: min_avg_quality
    type:
      - 'null'
      - float
    doc: Minimum average quality for each read
    inputBinding:
      position: 101
      prefix: --min-avg-quality
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length for each read in bp
    inputBinding:
      position: 101
      prefix: --min-length
  - id: min_trim_quality
    type:
      - 'null'
      - int
    doc: Trim the edges of each read until a nucleotide of at least X quality is
      found
    inputBinding:
      position: 101
      prefix: --min-trim-quality
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
stdout: fasten_fasten_clean.out
