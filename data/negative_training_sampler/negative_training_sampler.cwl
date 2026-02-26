cwlVersion: v1.2
class: CommandLineTool
baseCommand: negative_training_sampler
label: negative_training_sampler
doc: "A simple script that takes a tsv file with positive and negative labels\n  and
  a reference file. Generates negative samples with the same GC\n  distribution as
  the positive samples per chromosome.\n\nTool homepage: https://github.com/kircherlab/negative_training_sampler"
inputs:
  - id: bgzip
    type:
      - 'null'
      - boolean
    doc: Output will be bgzipped.
    inputBinding:
      position: 101
      prefix: --bgzip
  - id: cores
    type:
      - 'null'
      - int
    doc: number of used cores
    default: 1
    inputBinding:
      position: 101
      prefix: --cores
  - id: genome_file
    type: File
    doc: Input genome file of reference
    inputBinding:
      position: 101
      prefix: --genome-file
  - id: label_file
    type: File
    doc: Input bed file with labeled regions
    inputBinding:
      position: 101
      prefix: --label-file
  - id: label_num
    type:
      - 'null'
      - int
    doc: Number of separate label columns.
    inputBinding:
      position: 101
      prefix: --label_num
  - id: log
    type:
      - 'null'
      - File
    doc: Write logging to this file.
    inputBinding:
      position: 101
      prefix: --log
  - id: memory
    type:
      - 'null'
      - string
    doc: "amount of memory per core (e.g. 2 cores * 2GB =\n                      \
      \       4GB)"
    default: 2GB
    inputBinding:
      position: 101
      prefix: --memory
  - id: precision
    type:
      - 'null'
      - int
    doc: "Precision of decimals when computing the\n                             attributes
      like GC content."
    inputBinding:
      position: 101
      prefix: --precision
  - id: reference_file
    type: File
    doc: Input genome reference in fasta format
    inputBinding:
      position: 101
      prefix: --reference-file
  - id: seed
    type:
      - 'null'
      - int
    doc: Sets the seed for sampling.
    inputBinding:
      position: 101
      prefix: --seed
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Will print verbose messages.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Path to output file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/negative_training_sampler:0.3.1--py_0
