cwlVersion: v1.2
class: CommandLineTool
baseCommand: metabinner_gen_kmer.py
label: metabinner_gen_kmer.py
doc: "Generates k-mers from input sequences.\n\nTool homepage: https://github.com/ziyewang/MetaBinner"
inputs:
  - id: input_file
    type: File
    doc: Path to the input FASTA file.
    inputBinding:
      position: 1
  - id: length_threshold
    type: int
    doc: Minimum length of k-mers to consider.
    inputBinding:
      position: 2
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: Size of the k-mers to generate. Defaults to 31.
    default: 31
    inputBinding:
      position: 103
      prefix: --kmer_size
  - id: min_freq
    type:
      - 'null'
      - int
    doc: Minimum frequency for a k-mer to be included in the output. Defaults to
      1.
    default: 1
    inputBinding:
      position: 103
      prefix: --min_freq
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Path to the output file for k-mer counts. Defaults to stdout.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabinner:1.4.4--hdfd78af_1
