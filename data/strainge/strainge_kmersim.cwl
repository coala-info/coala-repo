cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - strainge
  - kmersim
label: strainge_kmersim
doc: "Compare k-mer sets with each other. Both all-vs-all and one-vs-all is supported.\n\
  \nTool homepage: The package home page"
inputs:
  - id: strains
    type:
      type: array
      items: File
    doc: Filenames of k-mer set HDF5 files.
    inputBinding:
      position: 1
  - id: all_vs_all
    type: boolean
    doc: Perform all-vs-all comparisons for the given k-mer sets. Either 
      --all-vs-all is required or --sample.
    inputBinding:
      position: 102
      prefix: --all-vs-all
  - id: full_db
    type:
      - 'null'
      - boolean
    doc: Use full k-mer set instead of min-hash fingerprint.
    inputBinding:
      position: 102
      prefix: --full-db
  - id: sample_file
    type: File
    doc: Perform one-vs-all comparisons with the given filename as sample. 
      Either --all-vs-all is required or --sample.
    inputBinding:
      position: 102
      prefix: --sample
  - id: scoring
    type:
      - 'null'
      - type: array
        items: string
    doc: 'The scoring metric to use (default: jaccard). Can be used multiple times
      to include multiple scoring metrics. Choices: jaccard, minsize, meansize, maxsize,
      subset, reference.'
    default: jaccard
    inputBinding:
      position: 102
      prefix: --scoring
  - id: threads
    type:
      - 'null'
      - int
    doc: Use multiple processes the compute the similarity scores (default 1).
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'File to write the results (default: standard output).'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
