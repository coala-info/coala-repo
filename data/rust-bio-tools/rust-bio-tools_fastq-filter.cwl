cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rbt
  - fastq-filter
label: rust-bio-tools_fastq-filter
doc: "Remove records from a FASTQ file (from STDIN), output to STDOUT.\n\nTool homepage:
  https://github.com/rust-bio/rust-bio-tools"
inputs:
  - id: fastq
    type: File
    doc: FASTQ file to filter (read from STDIN)
  - id: ids
    type: File
    doc: File with list of record IDs to remove, one per line
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-bio-tools:0.42.2--h4458251_0
stdin: $(inputs.fastq.path)
stdout: filtered.fastq
