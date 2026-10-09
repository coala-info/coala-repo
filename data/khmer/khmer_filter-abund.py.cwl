cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - filter-abund.py
label: khmer_filter-abund.py
doc: Trim sequences at a minimum k-mer abundance.
inputs:
  - id: input_count_graph_filename
    type: File
    doc: The input k-mer countgraph filename
    inputBinding:
      position: 1
  - id: input_sequence_filename
    type:
      type: array
      items: File
    doc: Input FAST[AQ] sequence filename
    inputBinding:
      position: 2
  - id: info
    type:
      - 'null'
      - boolean
    doc: print citation information
    inputBinding:
      position: 103
      prefix: --info
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of simultaneous threads to execute
    inputBinding:
      position: 103
      prefix: --threads
  - id: cutoff
    type:
      - 'null'
      - int
    doc: Trim at k-mers below this abundance.
    inputBinding:
      position: 103
      prefix: --cutoff
  - id: variable_coverage
    type:
      - 'null'
      - boolean
    doc: Only trim low-abundance k-mers from sequences that have high coverage.
    inputBinding:
      position: 103
      prefix: --variable-coverage
  - id: normalize_to
    type:
      - 'null'
      - int
    doc: Base the variable-coverage cutoff on this median k-mer abundance.
    inputBinding:
      position: 103
      prefix: --normalize-to
  - id: output
    type:
      - 'null'
      - string
    doc: Output the trimmed sequences into a single file with the given filename
      instead of creating a new file for each input file.
    inputBinding:
      position: 103
      prefix: --output
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite output file if it exists
    inputBinding:
      position: 103
      prefix: --force
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: quiet
    inputBinding:
      position: 103
      prefix: --quiet
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: Compress output using gzip
    inputBinding:
      position: 103
      prefix: --gzip
  - id: bzip
    type:
      - 'null'
      - boolean
    doc: Compress output using bzip2
    inputBinding:
      position: 103
      prefix: --bzip
outputs:
  - id: output_output
    type:
      - 'null'
      - File
    doc: Output the trimmed sequences into a single file with the given filename
      instead of creating a new file for each input file.
    outputBinding:
      glob: $(inputs.output)
  - id: trimmed_sequences
    type:
      type: array
      items: File
    doc: Trimmed sequences, one ${input_sequence_filename}.abundfilt file per input file (when --output is not given)
    outputBinding:
      glob: '*.abundfilt'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
s:url: https://khmer.readthedocs.io/
$namespaces:
  s: https://schema.org/
