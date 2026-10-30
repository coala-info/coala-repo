cwlVersion: v1.2
class: CommandLineTool
baseCommand: obipairing
label: obitools4_obipairing
doc: "Align and merge overlapping paired-end reads into consensus sequences.\n\nTool homepage: https://obitools4.metabarcoding.org"
inputs:
  - id: input
    type:
      - 'null'
      - type: array
        items: File
    doc: Input sequence file(s).
    inputBinding:
      position: 100
  - id: forward_reads
    type: File
    doc: "The file names containing the forward reads."
    inputBinding:
      position: 20
      prefix: --forward-reads
  - id: reverse_reads
    type: File
    doc: "The file names containing the reverse reads."
    inputBinding:
      position: 20
      prefix: --reverse-reads
  - id: batch_size
    type:
      - 'null'
      - int
    doc: "Number of sequence per batch for paralelle processing."
    inputBinding:
      position: 20
      prefix: --batch-size
  - id: compressed
    type:
      - 'null'
      - boolean
    doc: "Compress all the result using gzip."
    inputBinding:
      position: 20
      prefix: --compressed
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Enable debug mode, by setting log level to debug."
    inputBinding:
      position: 20
      prefix: --debug
  - id: delta
    type:
      - 'null'
      - int
    doc: "Length added to the fast detected overlap for the precise alignement."
    inputBinding:
      position: 20
      prefix: --delta
  - id: ecopcr
    type:
      - 'null'
      - boolean
    doc: "Read data following the ecoPCR output format."
    inputBinding:
      position: 20
      prefix: --ecopcr
  - id: embl
    type:
      - 'null'
      - boolean
    doc: "Read data following the EMBL flatfile format."
    inputBinding:
      position: 20
      prefix: --embl
  - id: exact_mode
    type:
      - 'null'
      - boolean
    doc: "Do not run fast alignment heuristic."
    inputBinding:
      position: 20
      prefix: --exact-mode
  - id: fast_absolute
    type:
      - 'null'
      - boolean
    doc: "Compute absolute fast score (no action in exact mode)."
    inputBinding:
      position: 20
      prefix: --fast-absolute
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: "Read data following the fasta format."
    inputBinding:
      position: 20
      prefix: --fasta
  - id: fasta_output
    type:
      - 'null'
      - boolean
    doc: "Write sequence in fasta format."
    inputBinding:
      position: 20
      prefix: --fasta-output
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: "Read data following the fastq format."
    inputBinding:
      position: 20
      prefix: --fastq
  - id: fastq_output
    type:
      - 'null'
      - boolean
    doc: "Write sequence in fastq format."
    inputBinding:
      position: 20
      prefix: --fastq-output
  - id: force_one_cpu
    type:
      - 'null'
      - boolean
    doc: "Force to use only one cpu core for parallel processing."
    inputBinding:
      position: 20
      prefix: --force-one-cpu
  - id: gap_penalty
    type:
      - 'null'
      - float
    doc: "Gap penaity expressed as the multiply factor applied to the mismatch score between two nucleotides with a quality of 40."
    inputBinding:
      position: 20
      prefix: --gap-penalty
  - id: genbank
    type:
      - 'null'
      - boolean
    doc: "Read data following the Genbank flatfile format."
    inputBinding:
      position: 20
      prefix: --genbank
  - id: input_OBI_header
    type:
      - 'null'
      - boolean
    doc: "FASTA/FASTQ title line annotations follow OBI format."
    inputBinding:
      position: 20
      prefix: --input-OBI-header
  - id: input_json_header
    type:
      - 'null'
      - boolean
    doc: "FASTA/FASTQ title line annotations follow json format."
    inputBinding:
      position: 20
      prefix: --input-json-header
  - id: json_output
    type:
      - 'null'
      - boolean
    doc: "Write sequence in json format."
    inputBinding:
      position: 20
      prefix: --json-output
  - id: max_cpu
    type:
      - 'null'
      - int
    doc: "Number of parallele threads computing the result."
    inputBinding:
      position: 20
      prefix: --max-cpu
  - id: min_identity
    type:
      - 'null'
      - float
    doc: "Minimum identity between ovelaped regions of the reads to consider the aligment."
    inputBinding:
      position: 20
      prefix: --min-identity
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: "Minimum ovelap between both the reads to consider the aligment."
    inputBinding:
      position: 20
      prefix: --min-overlap
  - id: no_order
    type:
      - 'null'
      - boolean
    doc: "When several input files are provided, indicates that there is no order among them."
    inputBinding:
      position: 20
      prefix: --no-order
  - id: no_progressbar
    type:
      - 'null'
      - boolean
    doc: "Disable the progress bar printing."
    inputBinding:
      position: 20
      prefix: --no-progressbar
  - id: out
    type:
      - 'null'
      - string
    doc: Filename used for saving the output (default is standard output).
    inputBinding:
      position: 10
      prefix: --out
  - id: output_OBI_header
    type:
      - 'null'
      - boolean
    doc: "output FASTA/FASTQ title line annotations follow OBI format."
    inputBinding:
      position: 20
      prefix: --output-OBI-header
  - id: output_json_header
    type:
      - 'null'
      - boolean
    doc: "output FASTA/FASTQ title line annotations follow json format."
    inputBinding:
      position: 20
      prefix: --output-json-header
  - id: penalty_scale
    type:
      - 'null'
      - float
    doc: "Scale factor applied to the mismatch score and the gap penalty."
    inputBinding:
      position: 20
      prefix: --penalty-scale
  - id: skip_empty
    type:
      - 'null'
      - boolean
    doc: "Sequences of length equal to zero are suppressed from the output."
    inputBinding:
      position: 20
      prefix: --skip-empty
  - id: solexa
    type:
      - 'null'
      - boolean
    doc: "Decodes quality string according to the Solexa specification."
    inputBinding:
      position: 20
      prefix: --solexa
  - id: without_stat
    type:
      - 'null'
      - boolean
    doc: "Remove alignment statistics from the produced consensus sequences."
    inputBinding:
      position: 20
      prefix: --without-stat
outputs:
  - id: stdout
    type: stdout
    doc: Result printed on standard output when no output file is given.
  - id: output_file
    type:
      - 'null'
      - File
    doc: Result file written with --out
    outputBinding:
      glob: "$(inputs.out ? inputs.out : 'no_out_given')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/obitools4:4.4.0--h6e5cb0d_0
stdout: obitools4_obipairing.out
