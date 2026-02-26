cwlVersion: v1.2
class: CommandLineTool
baseCommand: chromsize
label: chromsize
doc: "just get your chrom sizes\n\nTool homepage: https://github.com/alejandrogzi/chromsize"
inputs:
  - id: accession_only
    type:
      - 'null'
      - boolean
    doc: only keep the accession id part of the header (stop after blank)
    inputBinding:
      position: 101
      prefix: --accession-only
  - id: input
    type: File
    doc: Path to FASTA/2bit file
    inputBinding:
      position: 101
      prefix: --input
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 20
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type: File
    doc: Path to output chrom sizes
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chromsize:0.0.32--ha6fb395_0
