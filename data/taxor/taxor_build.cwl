cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxor-build
label: taxor_build
doc: "Creates an HIXF index of a given set of fasta files\n\nTool homepage: https://github.com/JensUweUlrich/Taxor"
inputs:
  - id: export_help
    type:
      - 'null'
      - string
    doc: Export the help page information. Value must be one of [html, man].
    inputBinding:
      position: 101
      prefix: --export-help
  - id: input_file
    type:
      - 'null'
      - string
    doc: tab-separated-value file containing taxonomy information and reference 
      file names
    inputBinding:
      position: 101
      prefix: --input-file
  - id: input_sequence_dir
    type:
      - 'null'
      - Directory
    doc: directory containing the fasta reference files
    default: .
    inputBinding:
      position: 101
      prefix: --input-sequence-dir
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: size of kmers used for index construction
    default: 20
    inputBinding:
      position: 101
      prefix: --kmer-size
  - id: output_filename
    type:
      - 'null'
      - string
    doc: A file name for the resulting index.
    default: .
    inputBinding:
      position: 101
      prefix: --output-filename
  - id: scaling
    type:
      - 'null'
      - int
    doc: factor for scaling down syncmer/minimizer sketches
    default: 1
    inputBinding:
      position: 101
      prefix: --scaling
  - id: syncmer_size
    type:
      - 'null'
      - int
    doc: size of syncmer used for index construction
    default: 10
    inputBinding:
      position: 101
      prefix: --syncmer-size
  - id: threads
    type:
      - 'null'
      - int
    doc: The number of threads to use.
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: use_syncmer
    type:
      - 'null'
      - boolean
    doc: enable using syncmers for smaller index size
    inputBinding:
      position: 101
      prefix: --use-syncmer
  - id: window_size
    type:
      - 'null'
      - int
    doc: window size of minimizer scheme used for index construction
    default: 20
    inputBinding:
      position: 101
      prefix: --window-size
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxor:0.2.1--h4e8ebbd_0
stdout: taxor_build.out
