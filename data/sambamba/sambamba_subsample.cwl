cwlVersion: v1.2
class: CommandLineTool
baseCommand: sambamba_subsample
label: sambamba_subsample
doc: "Subsample BAM files\n\nTool homepage: https://github.com/biod/sambamba"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: compress
    type:
      - 'null'
      - int
    doc: Compression level for output BAM (0-9)
    default: 6
    inputBinding:
      position: 102
      prefix: --compress
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite output file if it exists
    inputBinding:
      position: 102
      prefix: --force
  - id: fraction
    type:
      - 'null'
      - float
    doc: Fraction of reads to keep (e.g., 0.1 for 10%)
    inputBinding:
      position: 102
      prefix: --fraction
  - id: nreads
    type:
      - 'null'
      - int
    doc: Number of reads to keep
    inputBinding:
      position: 102
      prefix: --nreads
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed for subsampling
    default: 0
    inputBinding:
      position: 102
      prefix: --seed
outputs:
  - id: output_bam
    type: File
    doc: Output BAM file
    outputBinding:
      glob: $(inputs.output_bam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sambamba:1.0.1--he614052_4
