cwlVersion: v1.2
class: CommandLineTool
baseCommand: KPopCount
label: kpop_KPopCount
doc: "Computes k-mer spectra from FASTA or FASTQ files.\n\nTool homepage: https://github.com/PaoloRibeca/KPop"
inputs:
  - id: fasta
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: -f
    doc: FASTA input file containing sequences. More than one FASTA input can
      be given, but not FASTA and FASTQ together.
    inputBinding:
      position: 2
  - id: single_end
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: -s
    doc: FASTQ input file containing single-end sequencing reads. More than one
      input can be given, but not FASTQ and FASTA together.
    inputBinding:
      position: 3
  - id: paired_end
    type:
      - 'null'
      - type: array
        items: File
    doc: Two FASTQ input files (read 1 and read 2) containing paired-end
      sequencing reads.
    inputBinding:
      position: 4
      prefix: '-p'
  - id: k_mer_length
    type:
      - 'null'
      - int
    doc: k-mer length (must be positive, and <= 30 for DNA or <= 12 for
      protein; default 12).
    inputBinding:
      position: 5
      prefix: '-k'
  - id: max_results_size
    type:
      - 'null'
      - int
    doc: Maximum number of k-mer hashes to be kept in memory at any given time
      (default 16777216).
    inputBinding:
      position: 6
      prefix: '-M'
  - id: content
    type:
      - 'null'
      - string
    doc: "How file contents should be interpreted: DNA-ss, DNA-single-stranded,
      DNA-ds, DNA-double-stranded or protein (default DNA-ds)."
    inputBinding:
      position: 7
      prefix: '-C'
  - id: label
    type:
      - 'null'
      - string
    doc: Label to be given to the k-mer spectrum in the output file. Either
      label or one_spectrum_per_sequence is mandatory.
    inputBinding:
      position: 8
      prefix: '-l'
  - id: one_spectrum_per_sequence
    type:
      - 'null'
      - boolean
    doc: Output one spectrum per input sequence, using the sequence name as
      label.
    inputBinding:
      position: 9
      prefix: '-L'
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Set verbose execution.
    inputBinding:
      position: 10
      prefix: '-v'
  - id: output_file_path
    type: string
    doc: Name of the generated output file.
    inputBinding:
      position: 11
      prefix: '-o'
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: k-mer spectra table written by KPopCount
    outputBinding:
      glob: '$(inputs.output_file_path)'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kpop:1.1.1--h9ee0642_1
