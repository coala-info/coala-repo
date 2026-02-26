cwlVersion: v1.2
class: CommandLineTool
baseCommand: quasirecomb
label: quasirecomb
doc: "QuasiRecomb is a tool for the inference of viral quasispecies from next-generation
  sequencing data, accounting for recombination.\n\nTool homepage: https://github.com/cbg-ethz/QuasiRecomb"
inputs:
  - id: clusters
    type:
      - 'null'
      - int
    doc: The number of clusters (generators) to use in the model.
    inputBinding:
      position: 101
      prefix: -K
  - id: coverage
    type:
      - 'null'
      - int
    doc: Downsample to a specific coverage.
    inputBinding:
      position: 101
      prefix: -c
  - id: input_file
    type: File
    doc: Input file in BAM or SAM format.
    inputBinding:
      position: 101
      prefix: -i
  - id: max_iterations
    type:
      - 'null'
      - int
    doc: Maximum number of EM iterations.
    inputBinding:
      position: 101
      prefix: -max_iter
  - id: no_recombination
    type:
      - 'null'
      - boolean
    doc: Disable the recombination part of the model.
    inputBinding:
      position: 101
      prefix: -no_recomb
  - id: quality_format
    type:
      - 'null'
      - string
    doc: Quality score format (Phred33 or Phred64).
    inputBinding:
      position: 101
      prefix: -q
  - id: region
    type:
      - 'null'
      - string
    doc: The genomic region to be analyzed (e.g., 'chr1:100-200').
    inputBinding:
      position: 101
      prefix: -r
  - id: threshold
    type:
      - 'null'
      - float
    doc: Threshold for reporting a haplotype.
    inputBinding:
      position: 101
      prefix: -t
  - id: unpaired
    type:
      - 'null'
      - boolean
    doc: Treat paired-end reads as single-end reads.
    inputBinding:
      position: 101
      prefix: -unpaired
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Directory where the output files will be written.
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quasirecomb:1.2--0
