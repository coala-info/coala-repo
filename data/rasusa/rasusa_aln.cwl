cwlVersion: v1.2
class: CommandLineTool
baseCommand: rasusa aln
label: rasusa_aln
doc: "Randomly subsample alignments to a specified depth of coverage\n\nTool homepage:
  https://github.com/mbhall88/rasusa"
inputs:
  - id: input_file
    type: File
    doc: Path to the input alignment file (SAM/BAM/CRAM) to subsample
    inputBinding:
      position: 1
  - id: batch_size
    type:
      - 'null'
      - int
    doc: '[Fetch] The size of the genomic window (bp) to cache into memory at once.'
    inputBinding:
      position: 102
      prefix: --batch-size
  - id: coverage
    type: int
    doc: The desired depth of coverage to subsample the alignment to
    inputBinding:
      position: 102
      prefix: --coverage
  - id: output_type
    type:
      - 'null'
      - string
    doc: Output format. Rasusa will attempt to infer the format from the output 
      file extension if not provided
    inputBinding:
      position: 102
      prefix: --output-type
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed to use
    inputBinding:
      position: 102
      prefix: --seed
  - id: step_size
    type:
      - 'null'
      - int
    doc: '[Fetch] When a region has less than the desired coverage, the step size
      to move along the chromosome to find more reads.'
    inputBinding:
      position: 102
      prefix: --step-size
  - id: strategy
    type:
      - 'null'
      - string
    doc: Subsampling strategy
    inputBinding:
      position: 102
      prefix: --strategy
  - id: swap_distance
    type:
      - 'null'
      - int
    doc: "[Stream] A maximum distance (bp) allowed between start position of new read
      and the worst read in the heap to consider them to be 'swappable'."
    inputBinding:
      position: 102
      prefix: --swap-distance
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Path to the output subsampled alignment file. Defaults to stdout (same 
      format as input)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rasusa:3.0.0--h54198d6_0
