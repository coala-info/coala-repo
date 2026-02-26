cwlVersion: v1.2
class: CommandLineTool
baseCommand: sak
label: sak
doc: "Slicing and dicing of FASTA/FASTQ files.\n\nTool homepage: https://github.com/seqan/seqan/tree/master/apps/sak"
inputs:
  - id: input_file
    type: File
    doc: 'INPUT_FILE. Valid filetypes are: .sam, .raw, .gbk, .frn, .fq, .fna, .ffn,
      .fastq, .fasta, .faa, .fa, and .embl.'
    inputBinding:
      position: 1
  - id: infix
    type:
      - 'null'
      - type: array
        items: string
    doc: Select characters from-to where from and to are 0-based indices.
    inputBinding:
      position: 102
      prefix: --infix
  - id: line_length
    type:
      - 'null'
      - int
    doc: Set line length in output file. See section Line Length for details. In
      range [-1..inf].
    default: -1
    inputBinding:
      position: 102
      prefix: --line-length
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximal number of sequence characters to write out.
    inputBinding:
      position: 102
      prefix: --max-length
  - id: revcomp
    type:
      - 'null'
      - boolean
    doc: Reverse-complement output.
    inputBinding:
      position: 102
      prefix: --revcomp
  - id: sequence
    type:
      - 'null'
      - type: array
        items: int
    doc: Select the given sequence for extraction by 0-based index.
    inputBinding:
      position: 102
      prefix: --sequence
  - id: sequence_name
    type:
      - 'null'
      - type: array
        items: string
    doc: Select sequence with name prefix being NAME.
    inputBinding:
      position: 102
      prefix: --sequence-name
  - id: sequences
    type:
      - 'null'
      - type: array
        items: string
    doc: Select sequences from-to where from and to are 0-based indices.
    inputBinding:
      position: 102
      prefix: --sequences
  - id: version_check
    type:
      - 'null'
      - boolean
    doc: Turn this option off to disable version update notifications of the 
      application. One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO.
    default: true
    inputBinding:
      position: 102
      prefix: --version-check
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'Path to the resulting file. If omitted, result is printed to stdout in FastQ
      format. Valid filetypes are: .sam, .raw, .frn, .fq, .fna, .ffn, .fastq, .fasta,
      .faa, and .fa.'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sak:0.4.8--h9948957_0
