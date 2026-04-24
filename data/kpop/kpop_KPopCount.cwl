cwlVersion: v1.2
class: CommandLineTool
baseCommand: KPopCount
label: kpop_KPopCount
doc: "KPopCount version 14 (18-Mar-2024)\n\nTool homepage: https://github.com/PaoloRibeca/KPop"
inputs:
  - id: content
    type:
      - 'null'
      - string
    doc: "how file contents should be interpreted.\n    When content is 'DNA-ss' or
      'protein', the sequence is hashed;\n    when content is 'DNA-ds', both sequence
      and reverse complement are hashed.\n    'DNA-ss' prevents automatic matching
      of reverse-complemented sequences;\n    use it only when comparing a set of
      single, homogeneus sequences"
    inputBinding:
      position: 101
      prefix: --content
  - id: fasta_file
    type:
      - 'null'
      - File
    doc: "FASTA input file containing sequences.\n    You can specify more than one
      FASTA input, but not FASTA and FASTQ inputs\n    at the same time. Contents
      are expected to be homogeneous across inputs"
    inputBinding:
      position: 101
      prefix: --fasta
  - id: k_mer_length
    type:
      - 'null'
      - int
    doc: "k-mer length\n    (must be positive, and <= 30 for DNA or <= 12 for protein)"
    inputBinding:
      position: 101
      prefix: --k-mer-size
  - id: k_mer_length
    type:
      - 'null'
      - int
    doc: "k-mer length\n    (must be positive, and <= 30 for DNA or <= 12 for protein)"
    inputBinding:
      position: 101
      prefix: --k-mer-length
  - id: max_results_size
    type:
      - 'null'
      - int
    doc: "maximum number of k-mer hashes to be kept in memory at any given time.\n\
      \    If more are present, the ones corresponding to the lowest cardinality\n\
      \    will be removed from memory and printed out, and there will be\n    repeated
      hashes in the output"
    inputBinding:
      position: 101
      prefix: --max-results-size
  - id: one_spectrum_per_sequence
    type: boolean
    doc: "output one spectrum per input sequence, using the sequence name as label.\n\
      \    Sequence names must not contain double quote \" characters.\n    Either
      option '-l' or option '-L' is mandatory"
    inputBinding:
      position: 101
      prefix: --one-spectrum-per-sequence
  - id: output_vector_label
    type: string
    doc: "label to be given to the k-mer spectrum in the output file.\n    It must
      not contain double quote \" characters.\n    Either option '-l' or option '-L'
      is mandatory"
    inputBinding:
      position: 101
      prefix: --label
  - id: paired_end_fastq1
    type:
      - 'null'
      - type: array
        items: File
    doc: "FASTQ input files containing paired-end sequencing reads\n    You can specify
      more than one FASTQ input, but not FASTQ and FASTA inputs\n    at the same time.
      Contents are expected to be homogeneous across inputs"
    inputBinding:
      position: 101
      prefix: --paired-end
  - id: paired_end_fastq2
    type:
      - 'null'
      - type: array
        items: File
    doc: "FASTQ input files containing paired-end sequencing reads\n    You can specify
      more than one FASTQ input, but not FASTQ and FASTA inputs\n    at the same time.
      Contents are expected to be homogeneous across inputs"
    inputBinding:
      position: 101
      prefix: --paired-end
  - id: single_end_fastq
    type:
      - 'null'
      - File
    doc: "FASTQ input file containing single-end sequencing reads\n    You can specify
      more than one FASTQ input, but not FASTQ and FASTA inputs\n    at the same time.
      Contents are expected to be homogeneous across inputs"
    inputBinding:
      position: 101
      prefix: --single-end
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: set verbose execution
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: name of generated output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kpop:1.1.1--h9ee0642_1
