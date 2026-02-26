cwlVersion: v1.2
class: CommandLineTool
baseCommand: trycycler subsample
label: trycycler_subsample
doc: "subsample a long-read set\n\nTool homepage: https://github.com/rrwick/Trycycler"
inputs:
  - id: count
    type:
      - 'null'
      - int
    doc: Number of subsampled read sets to output
    default: 12
    inputBinding:
      position: 101
      prefix: --count
  - id: genome_size
    type:
      - 'null'
      - string
    doc: Approximate genome size
    default: auto
    inputBinding:
      position: 101
      prefix: --genome_size
  - id: min_read_depth
    type:
      - 'null'
      - float
    doc: Minimum allowed read depth
    default: 25.0
    inputBinding:
      position: 101
      prefix: --min_read_depth
  - id: out_dir
    type: Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --out_dir
  - id: reads
    type: File
    doc: Input long reads (FASTQ format)
    inputBinding:
      position: 101
      prefix: --reads
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for alignment
    default: 16
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trycycler:0.5.6--pyhdfd78af_0
stdout: trycycler_subsample.out
