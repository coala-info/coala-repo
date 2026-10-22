cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxor
  - build
label: taxor_build
doc: "Creates an HIXF index of a given set of fasta files using either k-mers or syncmers\n\nTool homepage: https://github.com/JensUweUlrich/Taxor"
inputs:
  - id: input_file
    type: File
    doc: 'Tab-separated-value file containing taxonomy information and reference file names'
    inputBinding:
      position: 101
      prefix: --input-file
  - id: input_sequence_dir
    type: Directory
    doc: 'Directory containing the fasta reference files (file stems match the last FTP path part in column 3 of the input file)'
    inputBinding:
      position: 101
      prefix: --input-sequence-dir
  - id: output_filename
    type: string
    doc: 'A file name for the resulting index'
    inputBinding:
      position: 102
      prefix: --output-filename
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: 'Size of kmers used for index construction (default 20, range 1-64)'
    inputBinding:
      position: 101
      prefix: --kmer-size
  - id: syncmer_size
    type:
      - 'null'
      - int
    doc: 'Size of syncmer used for index construction (default 10, range 1-26)'
    inputBinding:
      position: 101
      prefix: --syncmer-size
  - id: window_size
    type:
      - 'null'
      - int
    doc: 'Window size of minimizer scheme used for index construction (default 20, range 1-96)'
    inputBinding:
      position: 101
      prefix: --window-size
  - id: scaling
    type:
      - 'null'
      - int
    doc: 'Factor for scaling down syncmer/minimizer sketches (default 1, range 10-1000)'
    inputBinding:
      position: 101
      prefix: --scaling
  - id: threads
    type:
      - 'null'
      - int
    doc: 'The number of threads to use (default 1, range 1-32)'
    inputBinding:
      position: 101
      prefix: --threads
  - id: use_syncmer
    type:
      - 'null'
      - boolean
    doc: 'Enable using syncmers for smaller index size'
    inputBinding:
      position: 101
      prefix: --use-syncmer
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: index_file
    type:
      - 'null'
      - File
    doc: HIXF index file
    outputBinding:
      glob: $(inputs.output_filename)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxor:0.2.1--h4e8ebbd_0
stdout: taxor_build.out
