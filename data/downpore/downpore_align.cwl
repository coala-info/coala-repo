cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - downpore
  - align
label: downpore_align
doc: "Aligns a set of reads to each other (or to an optional reference) with dynamic
  time warping over short k-mers. Writes the aligned sequences, one line each with
  the alignment consensus first, to stdout.\n\nTool homepage: https://github.com/jteutenberg/downpore"
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
  - id: k
    type:
      - 'null'
      - int
    doc: K-mer size for alignment when no model specified (default 5)
    inputBinding:
      position: 101
      prefix: -k
  - id: reference
    type:
      - 'null'
      - File
    doc: (optional) A fasta file containing a reference sequence to align against
    inputBinding:
      position: 101
      prefix: -reference
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: Name of the file that receives the alignment written to stdout
    default: downpore_align.txt
outputs:
  - id: output_file
    type: File
    doc: Alignment lines (consensus line first, then one line per input sequence)
    outputBinding:
      glob: $(inputs.output_file_path)
stdout: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/downpore:0.3.4--h375a9b1_0
