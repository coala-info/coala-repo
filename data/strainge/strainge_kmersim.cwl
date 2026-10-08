cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- strainge
- kmersim
label: strainge_kmersim
doc: 'Compare k-mer sets with each other. Both all-vs-all and one-vs-all is supported.


  Tool homepage: https://github.com/broadinstitute/strainge'
inputs:
- id: strains
  type: File[]
  doc: Filenames of k-mer set HDF5 files.
  inputBinding:
    position: 100
- id: all_vs_all
  type:
  - 'null'
  - boolean
  doc: Perform all-vs-all comparisons for the given k-mer sets. Either --all-vs-all is required or --sample.
  inputBinding:
    position: 1
    prefix: --all-vs-all
- id: sample
  type:
  - 'null'
  - File
  doc: Perform one-vs-all comparisons with the given filename as sample. Either --all-vs-all is required or --sample.
  inputBinding:
    position: 1
    prefix: --sample
- id: full_db
  type:
  - 'null'
  - boolean
  doc: Use full k-mer set instead of min-hash fingerprint.
  inputBinding:
    position: 1
    prefix: --full-db
- id: scoring
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --scoring
  doc: 'The scoring metric to use (default: jaccard). Can be used multiple times to include multiple scoring metrics. Choices: jaccard, minsize, meansize, maxsize, subset, reference.'
  inputBinding:
    position: 1
- id: threads
  type:
  - 'null'
  - int
  doc: Use multiple processes the compute the similarity scores (default 1).
  inputBinding:
    position: 1
    prefix: --threads
- id: output
  type:
  - 'null'
  - string
  doc: 'File to write the results (default: standard output).'
  inputBinding:
    position: 1
    prefix: --output
outputs:
- id: output_result
  type:
  - 'null'
  - File
  doc: 'File to write the results (default: standard output).'
  outputBinding:
    glob: $(inputs.output)
- id: stdout
  type: stdout
  doc: Standard output
stdout: strainge_kmersim.stdout.txt
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
