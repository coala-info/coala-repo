cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rbt
  - sequence-stats
label: rust-bio-tools_sequence-stats
doc: "Tool to compute stats on sequence file (from STDIN), output is in YAML with
  fields: min, max, average, median, nb_reads, nb_bases, n50.\n\nTool homepage: https://github.com/rust-bio/rust-bio-tools"
inputs:
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: Flag to indicate the sequence in stdin is in fastq format.
    inputBinding:
      position: 101
      prefix: --fastq
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-bio-tools:0.42.2--h4458251_0
stdout: rust-bio-tools_sequence-stats.out
