cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-extract-fasta-kmers
label: dsh-bio_extract-fasta-kmers
doc: "Extract kmers from a FASTA file.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: alphabet
    type:
      - 'null'
      - string
    doc: input FASTA alphabet { dna, protein }, default dna
    inputBinding:
      position: 101
      prefix: --alphabet
  - id: downstream_length
    type:
      - 'null'
      - int
    doc: downstream length, default 0
    inputBinding:
      position: 101
      prefix: --downstream-length
  - id: include_ns
    type:
      - 'null'
      - boolean
    doc: for DNA sequences, include kmers containing Ns
    inputBinding:
      position: 101
      prefix: --include-ns
  - id: input_fasta_path
    type:
      - 'null'
      - File
    doc: input FASTA path, default stdin
    inputBinding:
      position: 101
      prefix: --input-fasta-path
  - id: kmer_length
    type: int
    doc: kmer length
    inputBinding:
      position: 101
      prefix: --kmer-length
  - id: upstream_length
    type:
      - 'null'
      - int
    doc: upstream length, default 0
    inputBinding:
      position: 101
      prefix: --upstream-length
  - id: output_kmer_file_path
    type: string
    doc: Output or path parameter `output_kmer_file_path`
    inputBinding:
      position: 102
      prefix: --output-kmer-file
outputs:
  - id: output_kmer_file
    type:
      - 'null'
      - File
    doc: output kmer file, default stdout
    outputBinding:
      glob: $(inputs.output_kmer_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
