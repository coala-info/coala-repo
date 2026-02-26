cwlVersion: v1.2
class: CommandLineTool
baseCommand: rustybam seq-stats
label: rustybam_seq-stats
doc: "Calculate summary statistics from fasta/q, sam, bam, or bed files. e.g. N50,
  mean, quantiles\n\nTool homepage: https://github.com/mrvollger/rustybam"
inputs:
  - id: infiles
    type:
      type: array
      items: File
    doc: Input files (fast{a,q}(.gz), sam, bam, bed)
    inputBinding:
      position: 1
  - id: genome_size
    type:
      - 'null'
      - int
    doc: Genome size for NG50 calculation
    inputBinding:
      position: 102
      prefix: --genome-size
  - id: human
    type:
      - 'null'
      - boolean
    doc: Print human-readable output
    inputBinding:
      position: 102
      prefix: --human
  - id: quantiles
    type:
      - 'null'
      - float
    doc: Quantiles to calculate
    default: 0.5
    inputBinding:
      position: 102
      prefix: --quantiles
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 4
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
stdout: rustybam_seq-stats.out
