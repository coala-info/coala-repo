cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - downpore
  - consensus
label: downpore_consensus
doc: "Builds a consensus sequence from a set of reads of the same region with dynamic
  time warping. Writes the consensus and three per-base quality lines (cost, votes,
  state space) to stdout.\n\nTool homepage: https://github.com/jteutenberg/downpore"
inputs:
  - id: input
    type: File
    doc: Fasta/fastq input file (one line per sequence)
    inputBinding:
      position: 101
      prefix: -input
  - id: rc_input
    type:
      - 'null'
      - File
    doc: Additional input file containing sequences from reverse-complement reads
    inputBinding:
      position: 101
      prefix: -rc_input
  - id: model
    type:
      - 'null'
      - File
    doc: Model file containing current levels
    inputBinding:
      position: 101
      prefix: -model
  - id: matrix
    type:
      - 'null'
      - File
    doc: K-mer confusion matrix to use in place of a model
    inputBinding:
      position: 101
      prefix: -matrix
  - id: k
    type:
      - 'null'
      - int
    doc: K-mer size for alignment when no model specified (default 5)
    inputBinding:
      position: 101
      prefix: -k
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: Name of the file that receives the consensus written to stdout
    default: downpore_consensus.txt
outputs:
  - id: output_file
    type: File
    doc: Consensus sequence line followed by three quality lines
    outputBinding:
      glob: $(inputs.output_file_path)
stdout: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/downpore:0.3.4--h375a9b1_0
