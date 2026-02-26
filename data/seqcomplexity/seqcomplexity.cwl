cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqcomplexity
label: seqcomplexity
doc: "Calculates Per-Read and Total Sequence Complexity from FastQ file.\n\nTool homepage:
  https://github.com/stevenweaver/seqcomplexity"
inputs:
  - id: fastq
    type: File
    doc: The input FASTQ file (gzip acceptable).
    inputBinding:
      position: 101
      prefix: --fastq
  - id: per_read
    type:
      - 'null'
      - boolean
    doc: Report complexity per read.
    inputBinding:
      position: 101
      prefix: --per-read
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqcomplexity:0.1.2--he734ae2_2
stdout: seqcomplexity.out
