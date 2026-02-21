cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - autocycler
  - subsample
label: autocycler_subsample
doc: "subsample a long-read set\n\nTool homepage: https://github.com/rrwick/Autocycler"
inputs:
  - id: count
    type:
      - 'null'
      - int
    doc: Number of subsampled read sets to output
    default: 4
    inputBinding:
      position: 101
      prefix: --count
  - id: genome_size
    type: string
    doc: Estimated genome size (required)
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
  - id: reads
    type: File
    doc: Input long reads in FASTQ format (required)
    inputBinding:
      position: 101
      prefix: --reads
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed for random number generator
    default: 0
    inputBinding:
      position: 101
      prefix: --seed
outputs:
  - id: out_dir
    type: Directory
    doc: Output directory (required)
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/autocycler:0.5.2--h3ab6199_0
