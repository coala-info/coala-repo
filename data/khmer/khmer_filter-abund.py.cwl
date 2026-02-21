cwlVersion: v1.2
class: CommandLineTool
baseCommand: filter-abund.py
label: khmer_filter-abund.py
doc: "Filter sequences based on abundance using a k-prime countgraph.\n\nTool homepage:
  https://khmer.readthedocs.io/"
inputs:
  - id: input_graph
    type: File
    doc: The input k-prime countgraph filename.
    inputBinding:
      position: 1
  - id: input_sequence_files
    type:
      type: array
      items: File
    doc: Input sequence filenames.
    inputBinding:
      position: 2
  - id: cutoff
    type:
      - 'null'
      - int
    doc: Cutoff at which to filter.
    default: 2
    inputBinding:
      position: 103
      prefix: --cutoff
  - id: normalize_to
    type:
      - 'null'
      - int
    doc: Normalize coverage to this value.
    inputBinding:
      position: 103
      prefix: --normalize-to
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    default: 1
    inputBinding:
      position: 103
      prefix: --threads
  - id: variable_coverage
    type:
      - 'null'
      - boolean
    doc: Only filter sequences with variable coverage.
    inputBinding:
      position: 103
      prefix: --variable-coverage
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory for filtered files.
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
