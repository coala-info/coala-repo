cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kallisto
  - index
label: kallisto_index
doc: Builds a kallisto index
inputs:
  - id: fasta_files
    type:
      type: array
      items: File
    doc: FASTA-files to build the index from
    inputBinding:
      position: 1
  - id: index
    type: string
    doc: Filename for the kallisto index to be constructed
    inputBinding:
      position: 102
      prefix: --index
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: 'k-mer (odd) length (default: 31, max value: 63)'
    inputBinding:
      position: 102
      prefix: --kmer-size
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use (default: 1)'
    inputBinding:
      position: 102
      prefix: --threads
  - id: d_list
    type:
      - 'null'
      - File
    doc: Path to a FASTA-file containing sequences to mask from quantification
    inputBinding:
      position: 102
      prefix: --d-list
  - id: make_unique
    type:
      - 'null'
      - boolean
    doc: Replace repeated target names with unique names
    inputBinding:
      position: 102
      prefix: --make-unique
  - id: aa
    type:
      - 'null'
      - boolean
    doc: Generate index from a FASTA-file containing amino acid sequences
    inputBinding:
      position: 102
      prefix: --aa
  - id: distinguish
    type:
      - 'null'
      - boolean
    doc: Generate index where sequences are distinguished by the sequence name
    inputBinding:
      position: 102
      prefix: --distinguish
  - id: tmp
    type:
      - 'null'
      - Directory
    doc: 'Temporary directory (default: tmp)'
    inputBinding:
      position: 102
      prefix: --tmp
  - id: min_size
    type:
      - 'null'
      - int
    doc: 'Length of minimizers (default: automatically chosen)'
    inputBinding:
      position: 102
      prefix: --min-size
  - id: ec_max_size
    type:
      - 'null'
      - int
    doc: 'Maximum number of targets in an equivalence class (default: no maximum)'
    inputBinding:
      position: 102
      prefix: --ec-max-size
outputs:
  - id: output_index
    type:
      - 'null'
      - File
    doc: Filename for the kallisto index to be constructed
    outputBinding:
      glob: $(inputs.index)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kallisto:0.52.0--h13ff97a_0
s:url: https://pachterlab.github.io/kallisto
$namespaces:
  s: https://schema.org/
